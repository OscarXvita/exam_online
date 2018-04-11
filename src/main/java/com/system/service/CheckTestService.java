package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.daoImpl.ObjectAnswerInfoDaoImpl;
import com.system.daoImpl.ObjectQuestionDaoImpl;
import com.system.daoImpl.TestDaoImpl;
import com.system.entity.ObjectAnswer;
import com.system.entity.ObjectQuestion;
import com.system.entity.Test;
import com.system.util.ConnectionFactory;

public class CheckTestService {
	/*
	 * 需要通过Test信息来批改试题的时候调用该方法； 需要传入Test对象，这个对象至少包含ID信息；
	 * 如果其中的题目已经批改过，则不会再批改核对，直接将分数累计 如果其中的题目没有批改过，则寻找数据进行批改;
	 * 返回这场考试批改后的分数，如果批改失败，返回-1； 如果发生异常，返回-1。
	 */
	public int checkTest(Test test) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ObjectAnswerInfoDaoImpl answerImpl = new ObjectAnswerInfoDaoImpl();
		ObjectQuestionDaoImpl questionImpl = new ObjectQuestionDaoImpl();
		TestDaoImpl testImpl = new TestDaoImpl();
		ResultSet answerSet = null;

		try {

			conn.setAutoCommit(false);
			answerSet = answerImpl.get(conn, test);
			int testScore = 0;
			while (answerSet.next()) {
				int tempState = answerSet.getInt("isChecked");
				long answerInfoId = answerSet.getLong("answerInfoID");
				if (tempState == 0) {
					long quizID = answerSet.getLong("questionID");
					int studentAnswer = answerSet.getInt("studentAnswer");
					ObjectQuestion tempQuiz = new ObjectQuestion();
					tempQuiz.setId(quizID);
					ResultSet quizSet = questionImpl.get(conn, tempQuiz);
					if(!quizSet.first()){
						ObjectAnswer tempAnswer = new ObjectAnswer();
						tempAnswer.setAnswerInfoID(answerInfoId);
						tempAnswer.setAnswerScore(0);
						tempAnswer.setChecked(true);
						tempAnswer.setAnswerContent(0);
						answerImpl.update(conn, tempAnswer);
						quizSet.beforeFirst();
					}
					quizSet.beforeFirst();
					while (quizSet.next()) {
						int trueAnswer = quizSet.getInt("trueAnswer");
						int score = quizSet.getInt("score");
						
						if (trueAnswer == studentAnswer) {
							testScore += score;
							ObjectAnswer tempAnswer = new ObjectAnswer();
							tempAnswer.setAnswerInfoID(answerInfoId);
							tempAnswer.setAnswerScore(score);
							tempAnswer.setChecked(true);
							tempAnswer.setAnswerContent(studentAnswer);
							answerImpl.update(conn, tempAnswer);
						} else {
							ObjectAnswer tempAnswer = new ObjectAnswer();
							tempAnswer.setAnswerInfoID(answerInfoId);
							tempAnswer.setAnswerScore(0);
							tempAnswer.setChecked(true);
							tempAnswer.setAnswerContent(studentAnswer);
							answerImpl.update(conn, tempAnswer);
						}
					}
				} else if (tempState == 1) {
					int checkScore = answerSet.getInt("answerScore");
					testScore += checkScore;
				} else {
					// 说明已经发生了异常，则直接返回-1
					return -1;
				}

			}
			test.setTestScore(testScore);
			testImpl.update(conn, test);
			conn.commit();
			return testScore;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return -1;
		} finally {
			try {
				answerSet.close();
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
}
