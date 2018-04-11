package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.daoImpl.StudentDaoImpl;
import com.system.daoImpl.TeacherDaoImpl;
import com.system.entity.Student;
import com.system.entity.Teacher;
import com.system.util.ConnectionFactory;

public class LoginService { // 验证学生登陆服务,同时添加学生的信息(姓名和性别)
	public boolean studentLogin(Student student) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet rs = null;
		try {
			conn.setAutoCommit(false);
			rs = new StudentDaoImpl().get(conn, student);
			while (rs.next()) {
				conn.commit();
				student.setName(rs.getString("studentName"));
				student.setGender(String.valueOf(rs.getInt("studentGender")));
				return rs.getString("studentPassword").equals(student.getPassword());
			}
			conn.commit();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return false;
		} finally {
			try {
				rs.close();
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

	public boolean teacherLogin(Teacher teacher) { // 验证老师登陆服务,同时添加教师的信息(姓名和性别)
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet rs = null;
		try {
			conn.setAutoCommit(false);
			rs = new TeacherDaoImpl().get(conn, teacher);
			while (rs.next()) {
				conn.commit();
				teacher.setName(rs.getString("teacherName"));
				teacher.setGender(String.valueOf(rs.getInt("teacherGender")));
				return rs.getString("teacherPassword").equals(teacher.getPassword());
			}
			conn.commit();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return false;
		} finally {
			try {
				rs.close();
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
