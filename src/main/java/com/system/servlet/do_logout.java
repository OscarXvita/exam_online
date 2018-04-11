package com.system.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class do_logout extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8017259065723027793L;
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//super.doPost(req, resp);
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		HttpSession session=req.getSession();
		if(session==null||session.equals("")){
			resp.sendRedirect("/OnlineStudy/index.jsp");
		}else{
			session.invalidate();
			resp.sendRedirect("/OnlineStudy/index.jsp");
			//System.out.println("成功清除session");
		}
	}
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//super.doGet(req, resp);
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		doPost(req, resp);
	}
}
