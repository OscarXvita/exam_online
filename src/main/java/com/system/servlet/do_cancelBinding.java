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

public class do_cancelBinding extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if(!session.isNew()){
			if (session == null || session.getAttribute("teacher") == null
					|| (Boolean) session.getAttribute("state") == false) {
				session.invalidate();
				request.getRequestDispatcher("index.jsp").forward(request, response);
			} else {
				Teacher teacher = (Teacher) session.getAttribute("teacher");
				String sEmails[] = request.getParameterValues("cancelBindingStudent");
				Student temps = new Student();
				if (sEmails != null && sEmails.length >= 0) {

					for (int i = 0; i < sEmails.length; i++) {
						temps.setEmail(sEmails[i]);
						boolean b = new BindingService().cancelBindingService(temps, teacher);
						if (b) {
							//System.out.println("解除同意");
							
//							response.sendRedirect("bindedStudent.jsp");
						} else {
							//System.out.println("解除失败");
							response.sendRedirect("error.jsp");
						}
					}
					request.getRequestDispatcher("/Teacher/bindedStudent.jsp").forward(request, response);

				}
				else{
					System.out.println("系统错误");
					request.getRequestDispatcher("/Teacher/teacherIndex.jsp").forward(request, response);
					//response.sendRedirect("bindedStudent.jsp");
				}
			}
		}
		else{
			session.invalidate();
			response.sendRedirect("index.jsp");
		}
		
	}

}
