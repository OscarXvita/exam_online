package com.system.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.system.entity.ObjectAnswer;
import com.system.entity.ObjectQuestion;
import com.system.entity.QuestionSpace;
import com.system.entity.Test;
import com.system.service.ObjectAnswerService;
import com.system.service.ObjectQuestionService;

public class do_practice extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if(!session.isNew()){
			QuestionSpace currentTeacherSpace=(QuestionSpace)session.getAttribute("currentTeacherSpace");
			Test testInstance=(Test)session.getAttribute("testInstance");
			if(currentTeacherSpace==null||testInstance==null){
				session.invalidate();
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				Vector<ObjectQuestion> objectQuestionLists = new ObjectQuestionService()
						.getAllQuestionOfSpace(currentTeacherSpace);
				if(objectQuestionLists!=null){
					Iterator<ObjectQuestion> iterList = objectQuestionLists.iterator();
					Map<ObjectQuestion, ObjectAnswer> answerMap=new HashMap<ObjectQuestion, ObjectAnswer>(); 
					int number=0;
					while (iterList.hasNext()) {
						ObjectQuestion o = iterList.next();
						String temp=request.getParameter(Integer.toString(number+1));
						if(temp==null){
							temp="0";
						}
						ObjectAnswer objectAnswer=new ObjectAnswer();
						objectAnswer.setAnswerContent(Integer.parseInt(temp));
						answerMap.put(o, objectAnswer);	
						number++;
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
