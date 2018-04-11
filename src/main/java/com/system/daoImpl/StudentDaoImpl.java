package com.system.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.dao.StudentDAO;
import com.system.entity.Student;

public class StudentDaoImpl implements StudentDAO {

	@Override
	public void insert(Connection conn, Student student) throws SQLException {
		// TODO Auto-generated method stub
		String saveSql = "INSERT INTO tbl_student VALUES (null,?,?,?,?)";

		PreparedStatement ps = conn.prepareStatement(saveSql);
		ps.setString(1, student.getEmail());
		ps.setString(2, student.getPassword());
		ps.setString(3, student.getName());
		ps.setString(4, student.getGender());
		ps.execute();
	}

	@Override
	public void update(Connection conn, Student student) throws SQLException {
		// TODO Auto-generated method stub
		String updateSql = "UPDATE tbl_student SET studentPassword=?,studentName=?,studentGender=? WHERE studentEmail=?";
		PreparedStatement ps = conn.prepareStatement(updateSql);
		// ps.setString(1, student.getEmail());
		ps.setString(1, student.getPassword());
		ps.setString(2, student.getName());
		ps.setString(3, student.getGender());
		ps.setString(4, student.getEmail());
		ps.execute();
	}

	@Override
	public void delete(Connection conn, Student student) throws SQLException {
		// TODO Auto-generated method stub
		String deleteSql = "DELETE FROM tbl_student WHERE studentEmail=?";
		PreparedStatement ps = conn.prepareStatement(deleteSql);
		ps.setString(1, student.getEmail());
		ps.execute();

	}

	@Override
	public ResultSet get(Connection conn, Student student) throws SQLException {
		// TODO Auto-generated method stub
		String getSql = "SELECT * FROM tbl_student WHERE studentEmail=?";
		PreparedStatement ps = conn.prepareStatement(getSql);
		ps.setString(1, student.getEmail());
		System.out.print(ps.toString());
		return ps.executeQuery();
	}
	
	public ResultSet getByID(Connection conn, Student student) throws SQLException {
		// TODO Auto-generated method stub
		String getSql = "SELECT * FROM tbl_student WHERE studentID=?";
		PreparedStatement ps = conn.prepareStatement(getSql);
		ps.setLong(1, student.getId());
		return ps.executeQuery();
	}
	public ResultSet getAll(Connection conn)throws SQLException{
		String sql="SELECT * FROM tbl_student";
		PreparedStatement ps=conn.prepareStatement(sql);
		return ps.executeQuery();
	}
}
