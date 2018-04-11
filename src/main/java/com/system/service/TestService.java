package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import com.system.daoImpl.ObjectAnswerInfoDaoImpl;
import com.system.daoImpl.StudentDaoImpl;
import com.system.daoImpl.TeacherDaoImpl;
import com.system.daoImpl.TeacherQuestionSpaceDaoImpl;
import com.system.daoImpl.TestDaoImpl;
import com.system.entity.QuestionSpace;
import com.system.entity.Student;
import com.system.entity.Teacher;
import com.system.entity.Test;
import com.system.util.ConnectionFactory;

public class TestService {
	/*
	 * 通过testID查找对应的题库和老师，返回为Map，只含有一对key-value； 如果发生异常，返回null
	 * 这一对key-value包含了对应对象的所有信息，除了老师的密码
	 */
	public Map<QuestionSpace, Teacher> getDetailOfTest(Test test) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet testSet = null;
		ResultSet spaceSet = null;
		ResultSet teacherSet = null;
		TestDaoImpl testImpl = new TestDaoImpl();
		TeacherQuestionSpaceDaoImpl spaceImpl = new TeacherQuestionSpaceDaoImpl();
		TeacherDaoImpl teacherImpl = new TeacherDaoImpl();
		try {
			conn.setAutoCommit(false);
			testSet = testImpl.get(conn, test);
			Teacher trueTeacher = new Teacher();
			QuestionSpace trueSpace = new QuestionSpace();
			while (testSet.next()) {
				QuestionSpace space = new QuestionSpace();
				space.setId(testSet.getLong("questionSpaceID"));
				spaceSet = spaceImpl.get(conn, space);
				while (spaceSet.next()) {
					Long id = spaceSet.getLong("id");
					String type = spaceSet.getString("type");
					String name = spaceSet.getString("name");
					String beginTime = spaceSet.getTimestamp("beginTime").toString();
					String endTime = spaceSet.getTimestamp("endTime").toString();
					long teacherID = spaceSet.getLong("teacherID");
					Teacher tempTeacher = new Teacher();
					tempTeacher.setId(teacherID);
					QuestionSpace tempSpace = new QuestionSpace();
					tempSpace.setBeginTime(beginTime);
					tempSpace.setEndTime(endTime);
					tempSpace.setId(id);
					tempSpace.setType(type);
					tempSpace.setName(name);
					trueSpace = tempSpace;
					teacherSet = teacherImpl.getById(conn, tempTeacher);
					while (teacherSet.next()) {
						long trueTeacherID = teacherSet.getLong("teacherID");
						String teacherEmail = teacherSet.getString("teacherEmail");
						String teacherName = teacherSet.getString("teacherName");
						String teacherPhone = teacherSet.getString("teacherPhone");
						int gender = teacherSet.getInt("teacherGender");
						String trueGender = "1";
						if (gender == 0) {
							trueGender = "0";
						}
						trueTeacher.setGender(trueGender);
						trueTeacher.setEmail(teacherEmail);
						trueTeacher.setName(teacherName);
						trueTeacher.setPhone(teacherPhone);
						trueTeacher.setId(trueTeacherID);
					}
				}
			}

			conn.commit();
			Map<QuestionSpace, Teacher> returnMap = new HashMap<QuestionSpace, Teacher>();
			returnMap.put(trueSpace, trueTeacher);
			return returnMap;
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
				teacherSet.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				spaceSet.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				testSet.close();
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
	 * 创建一场考试或者测试的时候使用，需要传入Test对象，其中包含开始时间，是否是考试等信息 需要传入QuestionSpace对象， 包含其ID属性
	 * 需要传入Student对象，包含其ID属性 返回值为这次考试（测试）分配的ID信息，之后添加为每道题添加答案的时候需要利用该ID
	 * 如果发生异常，则返回-1L
	 */
	public long beginTest(Test test, QuestionSpace spaceWithID, Student studentWithID) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet testIdSet = null;
		try {
			conn.setAutoCommit(false);
			testIdSet = new TestDaoImpl().insert(conn, studentWithID, spaceWithID, test);
			conn.commit();
			while (testIdSet.next()) {
				return testIdSet.getLong("max(testID)");
			}
			return -1L;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return -1L;
		} finally {
			try {
				testIdSet.close();
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
	 * 根据测试的ID查找测试的信息 需要传入测试对象，其中至少包含测试的ID 返回对应该ID的唯一测试结果，包含内容为：
	 * 测试时间，是否是考试，这次测试的分数。 如果没有查到相应，返回一个没有内容的Test对象 如果查询过程发生异常，返回null
	 */
	public Test getTestRecord(Test test) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet recordSet = null;
		try {
			conn.setAutoCommit(false);

			recordSet = new TestDaoImpl().get(conn, test);
			while (recordSet.next()) {
				Test tempTest = new Test();
				int examflag = recordSet.getInt("isExam");
				switch (examflag) {
				case 1:
					tempTest.setExam(true);
					break;
				case 0:
					tempTest.setExam(false);
					break;
				default:
					return null;
				}
				tempTest.setTestID(recordSet.getLong("testID"));
				tempTest.setTestTime(recordSet.getTimestamp("testTime").toString());
				tempTest.setTestScore(recordSet.getInt("testScore"));
				conn.commit();
				return tempTest;
			}
			return new Test();
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
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				recordSet.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * 根据题库的ID信息查找考试信息 。如果发生异常，返回null
	 */
	public Map<Test, Student> getTestRecord(QuestionSpace space) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet testSet = null;
		ResultSet studentSet = null;
		Map<Test, Student> map = new HashMap<Test, Student>();
		try {
			conn.setAutoCommit(false);
			testSet = new TestDaoImpl().get(conn, space);
			while (testSet.next()) {
				Test truet = new Test();
				Student trues = new Student();
				Student tempS = new Student();
				long sid = testSet.getLong("studentID");
				tempS.setId(sid);
				studentSet = new StudentDaoImpl().getByID(conn, tempS);
				while (studentSet.next()) {
					Long studentID = studentSet.getLong("studentID");
					String studentEmail = studentSet.getString("studentEmail");
					String name = studentSet.getString("studentName");
					int studentGender = studentSet.getInt("studentGender");
					trues.setId(studentID);
					trues.setEmail(studentEmail);
					trues.setGender(String.valueOf(studentGender));
					trues.setName(name);

				}
				int examflag = testSet.getInt("isExam");
				switch (examflag) {
				case 1:
					truet.setExam(true);
					break;
				case 0:
					truet.setExam(false);
					break;
				default:
					return null;
				}
				truet.setTestID(testSet.getLong("testID"));
				truet.setTestScore(testSet.getInt("testScore"));
				truet.setTestTime(testSet.getTimestamp("testTime").toString());
				map.put(truet, trues);
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
				testSet.close();
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
	 * 通过学生的ID查询考试信息，如果发生异常，返回null
	 */
	public Vector<Test> getTestRecord(Student student) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet testSet = null;
		try {
			conn.setAutoCommit(false);
			testSet = new TestDaoImpl().get(conn, student);
			Vector<Test> testVector = new Vector<Test>();
			while (testSet.next()) {
				Test tempTest = new Test();
				int examflag = testSet.getInt("isExam");
				switch (examflag) {
				case 1:
					tempTest.setExam(true);
					break;
				case 0:
					tempTest.setExam(false);
					break;
				default:
					return null;
				}
				tempTest.setTestID(testSet.getLong("testID"));
				tempTest.setTestScore(testSet.getInt("testScore"));
				tempTest.setTestTime(testSet.getTimestamp("testTime").toString());
				testVector.add(tempTest);
			}
			conn.commit();
			return testVector;

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
				testSet.close();
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
	 * 检查这次考试是否被批改，返回一个Map，Map的Key是题目的总数，Value是被批改的题目的数目。 如果发生异常，返回null
	 */
	public Map<Integer, Integer> getCheckState(Test test) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		// ResultSet testSet=null;
		ResultSet answerSet = null;
		try {
			conn.setAutoCommit(false);
			answerSet = new ObjectAnswerInfoDaoImpl().get(conn, test);
			Map<Integer, Integer> stateMap = new HashMap<Integer, Integer>();
			int quizamount = 0;
			int checkamount = 0;
			while (answerSet.next()) {
				quizamount++;
				int flag = answerSet.getInt("isChecked");
				if (flag == 1) {
					checkamount++;
				}
			}
			stateMap.put(quizamount, checkamount);
			conn.commit();
			return stateMap;
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
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * 对上一个方法的辅助
	 */
	public int getCheckStateInNumber(Test test) {
		Map<Integer, Integer> checkMap = getCheckState(test);
		if (checkMap == null) {
			return -1;
		}
		for (Map.Entry<Integer, Integer> entry : checkMap.entrySet()) {
			int all = entry.getKey();
			int check = entry.getValue();
			if (all != 0) {
				if (all > check) {
					return 0;
				} else if (all == check) {
					return 1;
				} else {
					return -1;
				}
			} else {
				return -1;
			}
		}
		return -1;
	}
}
