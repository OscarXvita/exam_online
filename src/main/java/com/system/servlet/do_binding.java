package com.system.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.system.entity.Student;
import com.system.entity.Teacher;
import com.system.service.BindingService;

@WebServlet("/do_binding")
public class do_binding extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session=request.getSession();
		if(!session.isNew()){
			Student student=(Student)session.getAttribute("student");
			//System.out.println(student.getEmail());
			String[] teacherEmail=request.getParameterValues("teacher");
			if(teacherEmail!=null&&teacherEmail.length>0){
				for(String str:teacherEmail){
					Teacher t=new Teacher();
					t.setEmail(str);
					
					boolean isBinding=new BindingService().CheckWhetherBinding(student, t);
					if(isBinding){
						boolean flag=new BindingService().InsertBindStudentTeacherService(student, t);
						System.out.println(flag);
						if(flag){
							//System.out.println("申请成功！");
							request.getRequestDispatcher("BindingTeacher.jsp").forward(request, response);
							
						}
						else{
							//System.out.println("申请失败！");
							request.getRequestDispatcher("Home.jsp").forward(request, response);
						}	
					}
					else{
						System.out.println("你已经绑定"+t.getName()+"老师！");
						request.getRequestDispatcher("BindingTeacher.jsp").forward(request, response);
						
					}
					
				}
				//request.getRequestDispatcher("Home.jsp").forward(request, response);
			}
			else{
				System.out.println("服务器故障，请稍候重试");
				request.getRequestDispatcher("Home.jsp").forward(request, response);
			}
		}
		else{
			session.invalidate();
			request.getRequestDispatcher("/index.jsp").forward(request, response);

		}

		
	}

}
