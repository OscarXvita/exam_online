package com.system.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class do_register extends HttpServlet{


	/**
	 * 
	 */
	private static final long serialVersionUID = 9090370605834985819L;
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String type=request.getParameter("type");
		if(type==null||type.equals("")){
			response.sendRedirect("error.jsp");
		}else{
			if(type.equals("teacher")){
				request.getRequestDispatcher("/teacherRegister").forward(request, response);
				
			}else if(type.equals("student")){
				request.getRequestDispatcher("/studentRegister").forward(request, response);
			}else{
				response.sendRedirect(request.getContentType()+"error.jsp");
			}
		}
	}
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req,resp);
	}
}
