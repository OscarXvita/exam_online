package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Vector;

import com.system.daoImpl.ObjectQuestionDaoImpl;
import com.system.entity.ObjectQuestion;
import com.system.entity.QuestionSpace;
import com.system.util.ConnectionFactory;

public class ObjectQuestionService {
	public boolean addQuestionsToSpace(Vector<ObjectQuestion>questions,QuestionSpace space){
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ObjectQuestionDaoImpl impl=new ObjectQuestionDaoImpl();
		try {
			conn.setAutoCommit(false);
			Iterator<ObjectQuestion> iter=questions.iterator();
			while(iter.hasNext()){
				ObjectQuestion question=iter.next();
				impl.insert(conn, question, space);
			}
			conn.commit();
			//conn.close();
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
	 * 添加题目的时候使用，需要题库对象（包含ID)，需要题目对象(包含详细信息）
	 */
	public boolean addQuestionToSpace(ObjectQuestion question, QuestionSpace space) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		try {
			conn.setAutoCommit(false);
			new ObjectQuestionDaoImpl().insert(conn, question, space);
			conn.commit();
			//conn.close();
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
	 * 获取所有题目，传入Space对象，其中至少包含ID,如果发生异常，返回null,否则返回Vector
	 */
	public Vector<ObjectQuestion> getAllQuestionOfSpace(QuestionSpace space) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		Vector<ObjectQuestion> questionVector = new Vector<ObjectQuestion>();
		ResultSet questionSet = null;

		try {
			conn.setAutoCommit(false);
			questionSet = new ObjectQuestionDaoImpl().get(conn, space);
			while (questionSet.next()) {
				ObjectQuestion question = new ObjectQuestion();
				question.setTitle(questionSet.getString("questionContent"));
				question.setId(questionSet.getLong("questionID"));
				question.setChoiceA(questionSet.getString("answer1"));
				question.setChoiceB(questionSet.getString("answer2"));
				question.setChoiceC(questionSet.getString("answer3"));
				question.setChoiceD(questionSet.getString("answer4"));
				question.setCorrectAnswer(questionSet.getInt("trueAnswer"));
				question.setScore(questionSet.getInt("score"));
				question.setAnswerAnalyze(questionSet.getString("questionAnalyze"));
				questionVector.add(question);
			}
			conn.commit();
			questionSet.close();
			//conn.close();
			return questionVector;
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
	 * 修改试题时候使用，需要传入试题对象，其中至少包含试题的ID，通过ID定位试题并根据其对象的其他属性修改试题
	 */
	public boolean updateQuestion(ObjectQuestion question) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		try {
			conn.setAutoCommit(false);
			new ObjectQuestionDaoImpl().update(conn, question);
			conn.commit();
			//conn.close();
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
	 * 删除一道题目，传入题目对象，其中至少包含ID
	 */
	public boolean deleteAQuestion(ObjectQuestion question) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		try {
			conn.setAutoCommit(false);
			new ObjectQuestionDaoImpl().delete(conn, question);
			conn.commit();
			//conn.close();
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
	 * 删除属于某一个题库的所有题目，传入题库对象，其中至少包含ID属性
	 */
	public boolean deleteAllQuestionOfSpace(QuestionSpace space) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		try {
			conn.setAutoCommit(false);
			new ObjectQuestionDaoImpl().deleteAll(conn, space);
			conn.commit();
			//conn.close();
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
