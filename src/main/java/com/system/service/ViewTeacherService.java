package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.system.daoImpl.Student_TeacherDaoImpl;
import com.system.entity.Student;
import com.system.entity.Teacher;
import com.system.util.ConnectionFactory;

public class ViewTeacherService {
	/*
	 * 这个方法，返回所有对于学生s已经绑定成功的老师
	 */
	public List<Teacher> getBindedTeachers(Student s) {
		List<Teacher> teachers = new ArrayList<Teacher>();

		ConsultService cService = new ConsultService();
		if (s.getId() == -1L) {
			s = cService.getStudentID(s);
		}
		if (s != null) {
			Connection conn = ConnectionFactory.getInstace().makeConnection();
			ResultSet teacherSet = null;
			try {
				conn.setAutoCommit(false);
				teacherSet = new Student_TeacherDaoImpl().getAllBindedTeachersOfStudent(conn, s);
				while (teacherSet.next()) {
					Teacher teacher = new Teacher();
					teacher.setId(teacherSet.getLong("teacherID"));
					teacher = cService.getTeacherByID(teacher);
					teachers.add(teacher);
					//System.out.println("一个绑定了的");
				}
				conn.commit();
				//System.out.println("司泽思泽斯则"+teachers.size());
				return teachers;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				try {
					conn.rollback();
					System.out.println("回滚");
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
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		} else {
			return null;
		}

	}

	/*
	 * 这个方法返回所有正在绑定的老师(已经提交了申请)
	 */
	public List<Teacher> getBindingTeachers(Student s) {
		List<Teacher> teachers = new ArrayList<Teacher>();

		ConsultService cService = new ConsultService();
		if (s.getId() == -1L) {
			s = cService.getStudentID(s);
		}
		if (s != null) {
			Connection conn = ConnectionFactory.getInstace().makeConnection();
			ResultSet teacherSet = null;
			try {
				conn.setAutoCommit(false);
				teacherSet = new Student_TeacherDaoImpl().getAllBindingTeachersOfStudent(conn, s);
				while (teacherSet.next()) {
					Teacher teacher = new Teacher();
					teacher.setId(teacherSet.getLong("teacherID"));
					teacher = cService.getTeacherByID(teacher);
					teachers.add(teacher);
				}
				conn.commit();
				return teachers;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				try {
					conn.rollback();
					System.out.println("回滚");
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
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		} else {
			return null;
		}
	}

}
