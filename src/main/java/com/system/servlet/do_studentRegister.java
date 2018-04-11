package com.system.servlet;

import java.io.IOException;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.system.entity.Student;
import com.system.service.RegisterService;

public class do_studentRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req,resp);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String name=request.getParameter("name");
		String sex=request.getParameter("sex");	
		if(email==null||password==null||name==null||sex==null||email.equals("")||password.equals("")||name.equals("")||sex.equals("")){
			response.sendRedirect("error.jsp");
			return;
		}
		Student s=new Student();
		s.setEmail(email);
		if(sex.equals("男")){
			s.setGender("0");
		}
		else{
			s.setGender("1");
		}
		s.setPassword(password);
		s.setName(name);
		boolean b=new RegisterService().StudentRegister(s);
		if(b){
			response.sendRedirect("registerSuccess.jsp");
			return;
		}
		else{
			response.sendRedirect("error.jsp");
			return;
		}
		
		
	}

}
