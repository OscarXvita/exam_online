package com.system.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.system.entity.*;
import com.system.service.ObjectAnswerService;
import com.system.service.ObjectQuestionService;

public class do_test extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if(!session.isNew()){
			QuestionSpace currentTeacherSpace=(QuestionSpace)session.getAttribute("currentTeacherSpace");
			 int array[]=(int[])session.getAttribute("array");
			Test testInstance=(Test)session.getAttribute("testInstance");
			if(currentTeacherSpace==null||array==null||testInstance==null){
				session.invalidate();
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				Vector<ObjectQuestion> objectQuestionLists = new ObjectQuestionService()
						.getAllQuestionOfSpace(currentTeacherSpace);
				if(objectQuestionLists!=null){
					Map<ObjectQuestion, ObjectAnswer> answerMap=new HashMap<ObjectQuestion, ObjectAnswer>(); 
					for(int a=0;a<25;a++){
						ObjectQuestion o = objectQuestionLists.get(array[a]);
						String temp=request.getParameter(String.valueOf(o.getId()));
						ObjectAnswer objectAnswer=new ObjectAnswer();
						if(temp==null){
							temp="0";
						}
						objectAnswer.setAnswerContent(Integer.parseInt(temp));
						answerMap.put(o, objectAnswer);	
					}
					boolean flag=new ObjectAnswerService().addObjectAnswer(testInstance, answerMap);
					if(flag){
						System.out.println("提交成功！");
						request.getRequestDispatcher("/studentIndex.jsp").forward(request, response);
					}
					else{
						System.out.println("提交失败！");
						request.getRequestDispatcher("/studentIndex.jsp").forward(request, response);
					}
				}
				else{
					System.out.println("请求出错，请稍候重试！");
					request.getRequestDispatcher("/studentIndex.jsp").forward(request, response);
				}

			}


		}
		else{
			session.invalidate();
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}

		

}
}
