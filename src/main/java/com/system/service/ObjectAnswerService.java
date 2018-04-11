package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.system.daoImpl.ObjectAnswerInfoDaoImpl;
import com.system.daoImpl.ObjectQuestionDaoImpl;
import com.system.entity.ObjectAnswer;
import com.system.entity.ObjectQuestion;
import com.system.entity.Test;
import com.system.util.ConnectionFactory;

public class ObjectAnswerService {
	/*
	 * 
	 * 通过Test的ID获取answer内容 传入Test对象，其中至少包含ID
	 * 返回Map<ObjectQuestion,ObjectAnswer>,包含question,answer对象的所有内容.如果发生异常，返回null
	 * 
	 */
	public Map<ObjectQuestion, ObjectAnswer> getObjectAnswer(Test test) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet questionSet = null;
		ResultSet answerSet = null;
		Map<ObjectQuestion, ObjectAnswer> map = new HashMap<ObjectQuestion, ObjectAnswer>();
		try {
			conn.setAutoCommit(false);
			answerSet = new ObjectAnswerInfoDaoImpl().get(conn, test);
			while (answerSet.next()) {
				long quizID = answerSet.getLong("questionID");
				ObjectQuestion truequestion = new ObjectQuestion();
				ObjectQuestion tempQuestion = new ObjectQuestion();
				tempQuestion.setId(quizID);
				ObjectAnswer trueAnswer = new ObjectAnswer();
				// ObjectAnswer answer = new ObjectAnswer();
				trueAnswer.setAnswerInfoID(answerSet.getLong("answerInfoID"));
				trueAnswer.setAnswerContent(answerSet.getInt("studentAnswer"));
				trueAnswer.setAnswerScore(answerSet.getInt("answerScore"));
				trueAnswer.setChecked(false);
				int tempState = answerSet.getInt("isChecked");
				if (tempState == 1) {
					trueAnswer.setChecked(true);
				}
				trueAnswer.setAnswerTime(answerSet.getTimestamp("answerTime").toString());
				questionSet = new ObjectQuestionDaoImpl().get(conn, tempQuestion);
				while (questionSet.next()) {
					truequestion.setId(questionSet.getLong("questionID"));
					truequestion.setTitle(questionSet.getString("questionContent"));
					truequestion.setChoiceA(questionSet.getString("answer1"));
					truequestion.setChoiceB(questionSet.getString("answer2"));
					truequestion.setChoiceC(questionSet.getString("answer3"));
					truequestion.setChoiceD(questionSet.getString("answer4"));
					truequestion.setAnswerAnalyze(questionSet.getString("questionAnalyze"));
					truequestion.setScore(questionSet.getInt("score"));
					truequestion.setCorrectAnswer(questionSet.getInt("trueAnswer"));
				}
				map.put(truequestion, trueAnswer);
			}
			conn.commit();
			return map;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return null;
		} finally {
			try {
				answerSet.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			try {
				questionSet.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * 在学生回答了一道题之后使用。 传入test对象，其中包含ID属性 传入question对象，其中包含ID属性
	 * 传入ObjectAnswer对象，其中包含学生的回答内容，回答的时间信息等 返回操作是否成功
	 * 
	 */
	public boolean addObjectAnswer(Test test, ObjectQuestion question, ObjectAnswer answer) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		try {
			conn.setAutoCommit(false);
			new ObjectAnswerInfoDaoImpl().insert(conn, test, question, answer);
			conn.commit();

			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * 需要添加许多answer信息的时候使用，注意事项如上 如果发生异常，返回false
	 */
	public boolean addObjectAnswer(Test test, Map<ObjectQuestion, ObjectAnswer> answerMap) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ObjectAnswerInfoDaoImpl impl = new ObjectAnswerInfoDaoImpl();
		// long testID=test.getTestID();

		try {
			conn.setAutoCommit(false);
			for (Map.Entry<ObjectQuestion, ObjectAnswer> entry : answerMap.entrySet()) {
				impl.insert(conn, test, entry.getKey(), entry.getValue());
			}
			conn.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}
}
