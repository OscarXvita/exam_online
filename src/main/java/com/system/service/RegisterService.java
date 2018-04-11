package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.daoImpl.StudentDaoImpl;
import com.system.daoImpl.TeacherDaoImpl;
import com.system.entity.Student;
import com.system.entity.Teacher;
import com.system.util.ConnectionFactory;

public class RegisterService {
	/*
	 * 学生注册，若学生已经注册过，或者其他原因，都返回false
	 */
	public boolean StudentRegister(Student student){
		Connection conn=ConnectionFactory.getInstace().makeConnection();
		ResultSet rs=null;
		try {
			conn.setAutoCommit(false);
			rs=new StudentDaoImpl().get(conn, student);
			while(rs.next()){
				return false;
			}
			new StudentDaoImpl().insert(conn, student);
			conn.commit();
			return true;
			
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
			// TODO: handle exception
		}finally{
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
	public boolean TeacherRegister(Teacher teacher){
		Connection conn=ConnectionFactory.getInstace().makeConnection();
		ResultSet rs=null;
		try {
			conn.setAutoCommit(false);
			rs=new TeacherDaoImpl().get(conn, teacher);
			while(rs.next()){
				return false;
			}
			new TeacherDaoImpl().insert(conn, teacher);
			conn.commit();
			return true;
			
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
			// TODO: handle exception
		}finally{
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
