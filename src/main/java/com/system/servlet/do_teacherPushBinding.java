package com.system.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.system.entity.Student;
import com.system.entity.Teacher;
import com.system.service.BindingService;


public class do_teacherPushBinding extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req,resp);
	}
	
		public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			req.setCharacterEncoding("UTF-8");
			resp.setCharacterEncoding("UTF-8");
			HttpSession session = req.getSession();
			if(!session.isNew()){
				if (session == null || session.getAttribute("teacher") == null
						|| (Boolean) session.getAttribute("state") == false) {
					session.invalidate();
					resp.sendRedirect("index.jsp");
				} else {
					Teacher teacher = (Teacher) session.getAttribute("teacher");
					String sEmails[] = req.getParameterValues("acceptStudents");
					BindingService acceptService = new BindingService();
					Student temps = new Student();
					
					if (sEmails != null && sEmails.length >= 0) {

						for (int i = 0; i < sEmails.length; i++) {
							temps.setEmail(sEmails[i]);
							boolean b = acceptService.createBinding(temps, teacher);
							if (b) {
								System.out.println("成功同意");
							//	resp.sendRedirect("teacherIndex.jsp");
							
							} else {
								System.out.println("请求未成功");
								resp.sendRedirect("error.jsp");
							}
						}
						req.getRequestDispatcher("/Teacher/unbindedStudent.jsp").forward(req, resp);
					}
					else{
						System.out.println("系统错误");
						req.getRequestDispatcher("/Teacher/teacherIndex.jsp").forward(req, resp);
					
					}
				}
			}
			else{
				session.invalidate();
				resp.sendRedirect("index.jsp");
			}
			

		}
	}

