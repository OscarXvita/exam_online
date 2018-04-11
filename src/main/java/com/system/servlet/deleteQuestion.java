package com.system.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.system.entity.ObjectQuestion;
import com.system.service.ObjectQuestionService;


public class deleteQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if (!session.isNew()) {
			if (session == null || session.getAttribute("teacher") == null
					|| (Boolean) session.getAttribute("state") == false) {
				session.invalidate();
				response.sendRedirect("index.jsp");
			}
			else{
				String questionID=request.getParameter("questionID");
				System.out.println("questionID="+questionID);
				ObjectQuestion question=new ObjectQuestion();
				question.setId(Long.parseLong(questionID));
				if(questionID!=null&&!questionID.equals("")){
					boolean flag=new ObjectQuestionService().deleteAQuestion(question);
					if(flag){
						System.out.println("删除成功！");
//						response.sendRedirect("teacherIndex.jsp");
					request.getRequestDispatcher("/Teacher/paperManage.jsp").forward(request, response);
					}
					else{
						System.out.println("删除失败！");
					//						response.sendRedirect("teacherIndex.jsp");
					request.getRequestDispatcher("/Teacher/teacherIndex.jsp").forward(request, response);
					}
				}
				else{
					session.invalidate();
				//					response.sendRedirect("index.jsp");
				request.getRequestDispatcher("/index.jsp").forward(request, response);

				}
				
				
			}
	}

}
}