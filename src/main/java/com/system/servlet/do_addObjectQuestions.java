package com.system.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.system.entity.*;
import com.system.service.ObjectQuestionService;

public class do_addObjectQuestions extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session=request.getSession();
		QuestionSpace currentTeacherSpace = (QuestionSpace)session.getAttribute("currentTeacherSpace");
		String questionName=request.getParameter("questionName");
		String answerA=request.getParameter("answerA");
		String answerB=request.getParameter("answerB");
		String answerC=request.getParameter("answerC");
		String answerD=request.getParameter("answerD");
		String correctAnswer=request.getParameter("correctAnswer");
		String score=request.getParameter("score");
		String answerAnalyze=request.getParameter("answerAnalyze");
		if(questionName==null||questionName.equals("")||answerA==null||
				answerA.equals("")||answerB==null||answerB.equals("")||
				answerC==null||answerC.equals("")||answerD==null||answerD.equals("")||
				correctAnswer==null||correctAnswer.equals("")||score==null||score.equals("")
				||answerAnalyze==null||answerAnalyze.equals("")){
			response.sendRedirect("error.jsp");
			return;
		}
		else{
			ObjectQuestion question=new ObjectQuestion();
			question.setTitle(questionName);
			question.setChoiceA(answerA);
			question.setChoiceB(answerB);
			question.setChoiceC(answerC);
			question.setChoiceD(answerD);
			question.setCorrectAnswer(Integer.parseInt(correctAnswer));
			question.setAnswerAnalyze(answerAnalyze);
			question.setScore(Integer.parseInt(score));
			boolean flag=new ObjectQuestionService().addQuestionToSpace(question, currentTeacherSpace);
			if(flag){
				System.out.println("添加成功！");
				request.getRequestDispatcher("/Teacher/getTeacherAllSpace.jsp").forward(request, response);
			}
			else{
				System.out.println("添加失败！");
				request.getRequestDispatcher("/Teacher/teacherIndex.jsp").forward(request, response);
			}
		}

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

}
