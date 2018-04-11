package com.system.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.system.entity.ObjectQuestion;
import com.system.service.ObjectQuestionService;

public class do_modifyQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String questionName=request.getParameter("questionName");
		String answerA=request.getParameter("answerA");
		String answerB=request.getParameter("answerB");
		String answerC=request.getParameter("answerC");
		String answerD=request.getParameter("answerD");
		String correctAnswer=request.getParameter("correctAnswer");
		String score=request.getParameter("score");
		String answerAnalyze=request.getParameter("answerAnalyze");
		String questionID=request.getParameter("questionID");
		if(questionName==null||questionName.equals("")||answerA==null||
				answerA.equals("")||answerB==null||answerB.equals("")||
				answerC==null||answerC.equals("")||answerD==null||questionID==null||answerD.equals("")||
				correctAnswer==null||correctAnswer.equals("")||score==null||score.equals("")
				||answerAnalyze==null||answerAnalyze.equals("")||questionID.equals("")){
			response.sendRedirect("error.jsp");
			return;
		}
		else{
			ObjectQuestion question=new ObjectQuestion();
			question.setId(Long.parseLong(questionID));
			question.setTitle(questionName);
			question.setChoiceA(answerA);
			question.setChoiceB(answerB);
			question.setChoiceC(answerC);
			question.setChoiceD(answerD);
			question.setCorrectAnswer(Integer.parseInt(correctAnswer));
			question.setAnswerAnalyze(answerAnalyze);
			question.setScore(Integer.parseInt(score));
			boolean flag=new ObjectQuestionService().updateQuestion(question);
			if(flag){
				System.out.println("修改成功！");
			//				response.sendRedirect("teacherIndex.jsp");
			
			request.getRequestDispatcher("/Teacher/paperManage.jsp").forward(request, response);
			}
			else{
				response.sendRedirect("error.jsp");
				System.out.println("修改失败！");
			}
		}

		
	}

}
