package com.system.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.system.dao.TestDAO;
import com.system.entity.Student;

import com.system.entity.QuestionSpace;
import com.system.entity.Test;

public class TestDaoImpl implements TestDAO {
	private final String format = "%Y-%m-%d %H:%i:%s";

	@Override
	public synchronized ResultSet insert(Connection conn, Student student, QuestionSpace space, Test test)
			throws SQLException {
		// TODO Auto-generated method stub
		String insertSql = "INSERT INTO tbl_test VALUES(NULL,STR_TO_DATE(?,'"
				+ format + "'),?,?,?,?)";
		PreparedStatement ps = conn.prepareStatement(insertSql);

		ps.setString(1, test.getTestTime());
		ps.setInt(2, test.isExam() == true ? 1 : 0);
		ps.setLong(3, student.getId());
		ps.setLong(4, space.getId());
		System.out.print(test.getTestScore());
		ps.setInt(5, test.getTestScore());
		ps.execute();
		String sql = "SELECT max(testID) from tbl_test";
		Statement st = conn.createStatement();
		return st.executeQuery(sql);
	}

	@Override
	public void update(Connection conn, Test test) throws SQLException {
		// TODO Auto-generated method stub
		String updateSql = "UPDATE tbl_test SET testScore=? WHERE testID=?";
		PreparedStatement ps = conn.prepareStatement(updateSql);
		ps.setInt(1, test.getTestScore());
		ps.setLong(2, test.getTestID());
		ps.execute();

	}

	@Override
	public void delete(Connection conn, Test test) throws SQLException {
		// TODO Auto-generated method stub
		String deleteSql = "DELETE * FROM tbl_test WHERE testID=?";
		PreparedStatement ps = conn.prepareStatement(deleteSql);
		ps.setLong(1, test.getTestID());
		ps.execute();

	}

	@Override
	public ResultSet get(Connection conn, Test test) throws SQLException {
		// TODO Auto-generated method stub
		String getSql = "SELECT * FROM tbl_test WHERE testID=?";
		PreparedStatement ps = conn.prepareStatement(getSql);
		ps.setLong(1, test.getTestID());
		return ps.executeQuery();
	}

	/*
	 * 通过学生ID查找Test信息
	 */
	public ResultSet get(Connection conn, Student student) throws SQLException {

		String getSql = "SELECT tbl_test.testScore,tbl_test.testTime,tbl_test.isExam ,tbl_test.testID FROM tbl_test,tbl_student WHERE tbl_student.studentID=? AND tbl_student.studentID=tbl_test.studentID";
		PreparedStatement ps = conn.prepareStatement(getSql);
		ps.setLong(1, student.getId());
		return ps.executeQuery();
	}

	/*
	 * 通过题库ID查找Test信息
	 */
	public ResultSet get(Connection conn, QuestionSpace space) throws SQLException {
		String getSql = "SELECT tbl_test.testScore,tbl_test.testTime,tbl_test.isExam ,tbl_test.testID,tbl_test.studentID FROM tbl_test,tbl_teacherquestionspace WHERE tbl_teacherquestionspace.id=? AND tbl_teacherquestionspace.id=tbl_test.questionSpaceID";
		PreparedStatement ps = conn.prepareStatement(getSql);
		ps.setLong(1, space.getId());
		return ps.executeQuery();
	}

	public ResultSet getScores(Connection conn, QuestionSpace space) throws SQLException {
		String sql = "SELECT * FROM tbl_test WHERE questionSpaceID=? AND isExam=1";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, space.getId());
		return ps.executeQuery();
	}



}
