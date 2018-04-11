package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.system.daoImpl.ObjectAnswerInfoDaoImpl;
import com.system.daoImpl.ObjectQuestionDaoImpl;
import com.system.daoImpl.StudentDaoImpl;
import com.system.daoImpl.TestDaoImpl;
import com.system.entity.ObjectQuestion;
import com.system.entity.QuestionSpace;
import com.system.entity.Student;
import com.system.entity.Test;
import com.system.util.ConnectionFactory;

public class ScoreAnalyzeService {
	/*
	 * 根据传入的每道题，查看正确率...如果发生异常，返回-1
	 */
	public double getPassRate(ObjectQuestion question) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ObjectAnswerInfoDaoImpl answerImpl = new ObjectAnswerInfoDaoImpl();
		ResultSet answerSet = null;
		try {
			conn.setAutoCommit(false);
			answerSet = answerImpl.get(conn, question);
			int count = 0;
			int correct = 0;
			// double rate=0;
			while (answerSet.next()) {
				int tempCheckState = answerSet.getInt("isChecked");
				int tempScore = answerSet.getInt("answerScore");
				if (tempCheckState == 1) {
					if (tempScore > 0) {
						correct++;
						count++;
					} else if (tempScore == 0) {
						count++;
					}
				}
			}

			conn.commit();
			if (count != 0) {
				return (double) correct / (double) count;
			} else {
				return 0;
			}
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
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (answerSet != null) {
				try {
					answerSet.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	/*
	 * 根据传入的QuestionSpace对象查看每道题的正确率。
	 * 返回Map<>,key=question,key含有题目的全部信息，double是通过率.. 如果异常，返回null;
	 */
	public Map<ObjectQuestion, Double> getPassRate(QuestionSpace space) {
		Map<ObjectQuestion, Double> rateMap = new HashMap<ObjectQuestion, Double>();
		List<ObjectQuestion> quizList = new ArrayList<ObjectQuestion>();
		// Map<ObjectQuestion, Double> tempRateMap = new HashMap<ObjectQuestion,
		// Double>();
		// TestDaoImpl testImpl=new TestDaoImpl();
		ObjectAnswerInfoDaoImpl answerImpl = new ObjectAnswerInfoDaoImpl();
		ObjectQuestionDaoImpl questionImpl = new ObjectQuestionDaoImpl();
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		// ResultSet testSet=null;
		ResultSet quizSet = null;
		ResultSet answerSet = null;
		try {
			conn.setAutoCommit(false);
			quizSet = questionImpl.get(conn, space);
			// 获取所有题目,放在quizList中
			while (quizSet.next()) {
				ObjectQuestion tempQuiz = new ObjectQuestion();
				tempQuiz.setId(quizSet.getLong("questionID"));
				tempQuiz.setTitle(quizSet.getString("questionContent"));
				tempQuiz.setChoiceA(quizSet.getString("answer1"));
				tempQuiz.setChoiceB(quizSet.getString("answer2"));
				tempQuiz.setChoiceC(quizSet.getString("answer3"));
				tempQuiz.setChoiceD(quizSet.getString("answer4"));
				tempQuiz.setCorrectAnswer(quizSet.getInt("trueAnswer"));
				tempQuiz.setAnswerAnalyze(quizSet.getString("questionAnalyze"));
				tempQuiz.setScore(quizSet.getInt("score"));
				quizList.add(tempQuiz);
			}
			// 根据每个question对象寻找到这道题，然后统计对应题目的正确率
			Iterator<ObjectQuestion> iter = quizList.iterator();

			while (iter.hasNext()) {
				ObjectQuestion trueQuestion = iter.next();
				answerSet = answerImpl.get(conn, trueQuestion);
				int count = 0;
				int correct = 0;
				// double rate=0;
				double tempRate = 0;
				while (answerSet.next()) {
					int tempCheckState = answerSet.getInt("isChecked");
					int tempScore = answerSet.getInt("answerScore");
					if (tempCheckState == 1) {
						if (tempScore > 0) {
							correct++;
							count++;
							// System.out.println("正确+1");
						} else if (tempScore == 0) {
							count++;
							// System.out.println("错误+1");
						}
					}

				}
				if (count != 0) {
					tempRate = (double) correct / (double) count;
					// System.out.println("返回某个提的通过率为：" + tempRate);
					rateMap.put(trueQuestion, tempRate);
				} else {
					rateMap.put(trueQuestion, 0.0);
				}
			}
			conn.commit();
			return rateMap;
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
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (quizSet != null) {
				try {
					quizSet.close();
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
			if (answerSet != null) {
				try {
					answerSet.close();
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		}
	}

	/*
	 * 传入Test对象，其中包括testID属性，最好调用的时候确定这个考生的试题已经被批改
	 * 传回对应这个Test的题库的所有考试学生的分数的列表(已经排序) 如果没有被批改的Test，则返回一个不含有任何元素的List
	 * 如果发生异常，则返回null
	 */
	public List<Integer> getRangeList(Test test) {
		List<Integer> tempL = new ArrayList<Integer>();
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		TestDaoImpl Timpl = new TestDaoImpl();
		ResultSet testSet = null;
		ResultSet allSet = null;
		// long studentID;
		long spaceId = 0;
		try {
			conn.setAutoCommit(false);
			testSet = Timpl.get(conn, test);
			while (testSet.next()) {
				spaceId = testSet.getLong("questionSpaceID");
			}
			QuestionSpace tempSpace = new QuestionSpace();
			tempSpace.setId(spaceId);
			allSet = Timpl.getScores(conn, tempSpace);
			while (allSet.next()) {
				int score = allSet.getInt("testScore");
				tempL.add(score);
			}
			Collections.sort(tempL);

			conn.commit();
			return tempL;
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
				if (allSet != null) {
					allSet.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (testSet != null) {
					testSet.close();
				}
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
	 * 传入QuestionSpace对象，其中至少包括id属性。 返回对value排序完成的map 其中key为Student，value为分数
	 * 如果发生异常，返回null
	 */
	public Map<Student, Integer> getRangeMap(QuestionSpace space) {
		Map<Student, Integer> map = new HashMap<Student, Integer>();
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		TestDaoImpl testImpl = new TestDaoImpl();
		StudentDaoImpl studentImpl = new StudentDaoImpl();
		ResultSet scoreSet = null;
		ResultSet studentSet = null;
		try {
			conn.setAutoCommit(false);
			scoreSet = testImpl.getScores(conn, space);
			Student tempS = new Student();
			while (scoreSet.next()) {
				int testScore = scoreSet.getInt("testScore");
				long studentID = scoreSet.getLong("studentID");
				tempS.setId(studentID);
				studentSet = studentImpl.getByID(conn, tempS);
				while (studentSet.next()) {
					Student trueS = new Student();
					trueS.setId(studentSet.getLong("studentID"));
					trueS.setEmail(studentSet.getString("studentEmail"));
					trueS.setName(studentSet.getString("studentName"));
					trueS.setGender(String.valueOf(studentSet.getInt("studentGender")));
					map.put(trueS, testScore);
				}
			}
			conn.commit();
			return sortMapByValue(map);
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
				if (studentSet != null) {
					studentSet.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (scoreSet != null) {
					scoreSet.close();
				}
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
	 * 同上，传入参数为考试
	 */
	public Map<Student, Integer> getRangeMap(Test test) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		TestDaoImpl testImpl = new TestDaoImpl();
		ResultSet testSet = null;
		try {
			conn.setAutoCommit(false);
			testSet = testImpl.get(conn, test);
			// long spaceId=0L;
			QuestionSpace space = new QuestionSpace();
			while (testSet.next()) {
				space.setId(testSet.getLong("questionSpaceID"));
			}
			conn.commit();
			return getRangeMap(space);

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
				if (testSet != null) {
					testSet.close();
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
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
	 * 以下方法私有，排序算法，使用链式散列表
	 */
	private static Map<Student, Integer> sortMapByValue(Map<Student, Integer> orimap) {

		if (orimap == null || orimap.isEmpty()) {
			return null;
		}
		Map<Student, Integer> sortedMap = new LinkedHashMap<Student, Integer>();
		List<Map.Entry<Student, Integer>> entryList = new ArrayList<Map.Entry<Student, Integer>>(orimap.entrySet());
		Collections.sort(entryList, new MapValueComparator());
		Iterator<Map.Entry<Student, Integer>> iter = entryList.iterator();
		Map.Entry<Student, Integer> tmpEntry = null;
		while (iter.hasNext()) {
			tmpEntry = iter.next();
			sortedMap.put(tmpEntry.getKey(), tmpEntry.getValue());
		}
		return sortedMap;

	}

}

class MapValueComparator implements Comparator<Map.Entry<Student, Integer>> {

	@Override
	public int compare(Entry<Student, Integer> me1, Entry<Student, Integer> me2) {

		return me2.getValue().compareTo(me1.getValue());
	}
}