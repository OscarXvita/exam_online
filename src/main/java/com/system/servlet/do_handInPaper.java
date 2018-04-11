package com.system.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.system.entity.ObjectAnswer;
import com.system.entity.ObjectQuestion;
import com.system.entity.QuestionSpace;
import com.system.entity.Student;
import com.system.entity.Test;
import com.system.service.ObjectAnswerService;
import com.system.service.ObjectQuestionService;
import com.system.util.RandomManage;
public class do_handInPaper extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3263616668494221907L;
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter writer=resp.getWriter();
		if(req.getParameter("spaceID")==null||req.getParameter("testID")==null||req.getParameter("studentID")==null||req.getParameter("idStr")==null){
			//resp.setContentType("plain/text");
			writer.println("参数异常");
			return;
		}
		/*
		 * 获得所需的ID参数
		 */
		long spaceID=Long.parseLong(req.getParameter("spaceID"));
		long testID=Long.parseLong(req.getParameter("testID"));
		long studentID=Long.parseLong(req.getParameter("studentID"));
		boolean isExam=Boolean.parseBoolean(req.getParameter("isExam"));
		QuestionSpace space=new QuestionSpace();
		Test test=new Test();
		if(isExam){
			test.setExam(true);
			//System.out.println("isExamIsExam");
		}
		Student student=new Student();
		student.setId(studentID);
		test.setTestID(testID);
		space.setId(spaceID);
		Vector<ObjectQuestion>allQuestions=new ObjectQuestionService().getAllQuestionOfSpace(space);//获取题库中的所有题目
		List<ObjectQuestion>ansQuestionList=new ArrayList<ObjectQuestion>();//定义已经回答了的题目
		Map<ObjectQuestion,ObjectAnswer>answerMap=new HashMap<ObjectQuestion,ObjectAnswer>();
		if(allQuestions.size()>0){
			List<Long>idList=new RandomManage().deCoding(req.getParameter("idStr"));
			//获得这次考试考的题目
			for(ObjectQuestion question:allQuestions){
				for(long id:idList){
					if(question.getId()==id){
						ansQuestionList.add(question);
					}
				}
			}
			//获得这次考试的回答
			for(ObjectQuestion question:ansQuestionList){
				String answer=req.getParameter(String.valueOf(question.getId()));
				ObjectAnswer tempanswer=new ObjectAnswer();
				if(answer!=null){
					try {
						tempanswer.setAnswerContent(Integer.parseInt(answer));
					} catch (NumberFormatException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						tempanswer.setAnswerContent(0);
					}
				}else{
					tempanswer.setAnswerContent(0);
				}
				answerMap.put(question, tempanswer);
			}
			//提交至数据库
			boolean flag=new ObjectAnswerService().addObjectAnswer(test, answerMap);
			if(flag){
				//resp.setContentType("plain/text");
				
				//writer.println("答题成功");
				//writer.flush();
				
				req.getRequestDispatcher("Home.jsp").forward(req, resp);
			}else{
				//resp.setContentType("plain/text");
				writer.println("将answer加入数据库异常");
				writer.flush();
			}
			
		}else{
			//resp.setContentType("plain/text");
			writer.println("没有题目");
			return;
		}
		
	}
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		doPost(req, resp);
	}
}
