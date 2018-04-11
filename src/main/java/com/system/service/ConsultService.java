package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.system.daoImpl.StudentDaoImpl;
import com.system.daoImpl.TeacherDaoImpl;
import com.system.entity.Student;
import com.system.entity.Teacher;
import com.system.util.ConnectionFactory;

public class ConsultService {
	/*
	 * 
	 * 获得所有学生的集合，如果查询异常返回null
	 */
	public Vector<Student> getAllStudents() {
		Vector<Student> students = new Vector<Student>();
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet studentSet = null;
		try {
			conn.setAutoCommit(false);
			studentSet = new StudentDaoImpl().getAll(conn);
			while (studentSet.next()) {
				Student tempS = new Student();
				tempS.setEmail(studentSet.getString("studentEmail"));
				tempS.setGender(String.valueOf(studentSet.getInt("studentGender")));
				tempS.setName(studentSet.getString("studentName"));
				tempS.setId(studentSet.getLong("studentID"));
				students.add(tempS);
			}
			conn.commit();
			return students;
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
				studentSet.close();
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
	 * 返回所有老师的集合，如果查询异常返回null
	 */
	public List<Teacher> getAllTeachers() {
		List<Teacher> teachers = new ArrayList<Teacher>();
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet teacherSet = null;
		try {
			conn.setAutoCommit(false);
			teacherSet = new TeacherDaoImpl().getAll(conn);
			while (teacherSet.next()) {
				Teacher temp = new Teacher();
				temp.setEmail(teacherSet.getString("teacherEmail"));
				temp.setGender(teacherSet.getString("teacherGender"));
				temp.setName(teacherSet.getString("teacherName"));
				temp.setPassword(teacherSet.getString("teacherPassword"));
				temp.setPhone(teacherSet.getString("teacherPhone"));
				teachers.add(temp);
			}
			conn.commit();
			return teachers;
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
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * 获取学生的ID信息
	 */
	protected Student getStudentID(Student student) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet studentSet = null;
		try {
			conn.setAutoCommit(false);
			studentSet = new StudentDaoImpl().get(conn, student);
			while (studentSet.next()) {
				student.setId(studentSet.getLong("studentID"));
				conn.commit();
				return student;
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e2) {
				// TODO: handle exception
			}
			return null;
			// TODO: handle exception
		} finally {
			try {
				studentSet.close();
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
	 * 获取老师ID信息
	 */
	protected Teacher getTeacherID(Teacher teacher) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet teacherSet = null;
		try {
			conn.setAutoCommit(false);
			teacherSet = new TeacherDaoImpl().get(conn, teacher);
			while (teacherSet.next()) {
				teacher.setId(teacherSet.getLong("teacherID"));
				conn.commit();
				return teacher;
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e2) {
				// TODO: handle exception
			}
			return null;
			// TODO: handle exception
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
	}

	protected Student getStudentByID(Student student) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ResultSet studentSet = null;
		Student s = student;
		try {
			conn.setAutoCommit(false);
			studentSet = new StudentDaoImpl().getByID(conn, student);
			while (studentSet.next()) {
				s.setEmail(studentSet.getString("studentEmail"));
				s.setGender(String.valueOf(studentSet.getInt("studentGender")));
				s.setId(studentSet.getLong("studentID"));
				s.setName(studentSet.getString("studentName"));

			}
			conn.commit();
			return s;
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
			if (studentSet != null) {
				try {
					studentSet.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	protected Teacher getTeacherByID(Teacher teacher) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		Teacher t = teacher;
		ResultSet teacherSet = null;
		try {
			conn.setAutoCommit(false);
			teacherSet = new TeacherDaoImpl().getById(conn, teacher);
			while (teacherSet.next()) {
				t.setEmail(teacherSet.getString("teacherEmail"));
				t.setGender(String.valueOf(teacherSet.getInt("teacherGender")));
				t.setName(teacherSet.getString("teacherName"));
				t.setPhone(teacherSet.getString("teacherPhone"));
				return t;
			}
			return null;
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
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
