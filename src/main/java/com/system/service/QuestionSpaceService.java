package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.system.daoImpl.TeacherQuestionSpaceDaoImpl;
import com.system.entity.QuestionSpace;
import com.system.entity.Teacher;
import com.system.util.ConnectionFactory;

public class QuestionSpaceService {
	/*
	 * 添加题库的同时，返回刚才所添加的题库对象，其中包括ID属性
	 */
	public QuestionSpace addSpaceToGetId(QuestionSpace space, Teacher teacher) {
		QuestionSpace trueSpace = space;
		if (space.getName() == null || space.getBeginTime() == null || space.getType() == null) {
			return null;
		}
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ConsultService cService = new ConsultService();
		try {
			conn.setAutoCommit(false);
			teacher = cService.getTeacherID(teacher);
			ResultSet set = new TeacherQuestionSpaceDaoImpl().insert(conn, space, teacher);
			while (set.next()) {
				trueSpace.setId(set.getLong(1));
				// System.out.println("已经添加");
				return trueSpace;
			}
			conn.commit();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();

			}
			return null;
			// TODO: handle exception
		} finally {
			try {
				conn.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}

	/*
	 * 为某位教师添加题库，需要传入教师的Email和题库的相关信息（名字，类型，开始结束时间）
	 */
	public boolean addSpace(QuestionSpace space, Teacher teacher) {
		if (space.getName() == null || space.getBeginTime() == null || space.getType() == null) {
			return false;
		}
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ConsultService cService = new ConsultService();
		try {
			conn.setAutoCommit(false);
			teacher = cService.getTeacherID(teacher);
			new TeacherQuestionSpaceDaoImpl().insert(conn, space, teacher);
			conn.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();

			}
			return false;
			// TODO: handle exception
		} finally {
			try {
				conn.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}

	/*
	 * 获得某个教师的所有题库，需要传入教师的Email,如果发生异常，返回null
	 */
	public List<QuestionSpace> getQuestionSpaceOfTeacher(Teacher teacher) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ConsultService cService = new ConsultService();
		ResultSet spaceSet = null;
		List<QuestionSpace> spaceList = new ArrayList<QuestionSpace>();
		try {
			conn.setAutoCommit(false);
			if (teacher.getId() == -1L) {
				teacher = cService.getTeacherID(teacher);
			}
			spaceSet = new TeacherQuestionSpaceDaoImpl().get(conn, teacher);
			while (spaceSet.next()) {
				QuestionSpace space = new QuestionSpace();
				space.setId(spaceSet.getLong("id"));
				space.setName(spaceSet.getString("name"));
				space.setType(spaceSet.getString("type"));
				space.setBeginTime(spaceSet.getTimestamp("beginTime").toString());
				space.setEndTime(spaceSet.getTimestamp("endTime").toString());
				space.setAmount(spaceSet.getInt("amountPerTest"));
				// System.out.println("JJJJJJJJJJJJJJJJJJJJJJ"+space.getAmount());

				spaceList.add(space);
			}
			conn.commit();

			return spaceList;
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
				spaceSet.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
