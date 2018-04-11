package com.system.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.system.entity.Teacher;
import com.system.service.RegisterService;

public class do_teacherRegister extends HttpServlet {
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
		String phone=request.getParameter("phone");
		if(email==null||password==null||name==null||sex==null||phone==null||email.equals("")||password.equals("")||name.equals("")||sex.equals("")||phone.equals("")){
			response.sendRedirect("error.jsp");
			System.out.println("啥都没有");
			return;
		}
		Teacher t=new Teacher();
		t.setEmail(email);
		t.setPassword(password);
		if(sex.equals("男")){
			t.setGender("0");
		}else {
			t.setGender("1");
		}
		
		t.setPhone(phone);
		t.setName(name);
		boolean b=new RegisterService().TeacherRegister(t);
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
