package com.system.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.system.dao.TeacherQuestionSpaceDAO;
import com.system.entity.QuestionSpace;
import com.system.entity.Teacher;

public class TeacherQuestionSpaceDaoImpl implements TeacherQuestionSpaceDAO {
	private final String format = "%Y-%m-%d %H:%i:%s";

	@Override
	public synchronized ResultSet insert(Connection conn, QuestionSpace space, Teacher teacher) throws SQLException {
		// TODO Auto-generated method stub
		String insertSQL = "INSERT INTO tbl_teacherquestionspace VALUES(NULL,?,?,STR_TO_DATE(?,'"
				+ format + "'),STR_TO_DATE(?,'" + format + "'),?,?)";
		PreparedStatement ps = conn.prepareStatement(insertSQL);
		ps.setString(2, space.getName());
		ps.setString(1, space.getType());
		ps.setString(3, space.getBeginTime());
		ps.setLong(5, teacher.getId());
		ps.setString(4, space.getEndTime());
		ps.setInt(6, space.getAmount());
		Statement st = conn.createStatement();
		String sql = "SELECT MAX(id) FROM tbl_teacherquestionspace";
		ps.execute();
		return st.executeQuery(sql);
	}

	@Override
	public void update(Connection conn, QuestionSpace space) throws SQLException {
		// TODO Auto-generated method stub
		String updateSQL = "UPDATE tbl_teacherquestionspace SET beginTime=STR_TO_DATE(?,'" + format
				+ "'),name=?, type=?, endTime=STR_TO_DATE(?,'" + format + "') WHERE id=?";
		PreparedStatement ps = conn.prepareStatement(updateSQL);
		ps.setString(1, space.getBeginTime());
		ps.setString(2, space.getName());
		ps.setString(3, space.getType());
		ps.setString(4, space.getEndTime());
		ps.setLong(5, space.getId());

		ps.execute();
	}

	@Override
	public void delete(Connection conn, QuestionSpace space) throws SQLException {
		// TODO Auto-generated method stub
		String deleteSQL = "DELETE * FROM tbl_teacherquestionspace WHERE id=?";
		PreparedStatement ps = conn.prepareStatement(deleteSQL);
		ps.setLong(1, space.getId());
		ps.execute();

	}

	@Override
	public ResultSet get(Connection conn, Teacher teacher) throws SQLException {
		// TODO Auto-generated method stub
		String getSQL = "SELECT tbl_teacherquestionspace.amountPerTest,tbl_teacherquestionspace.id,tbl_teacherquestionspace.type,tbl_teacherquestionspace.name,tbl_teacherquestionspace.beginTime,tbl_teacherquestionspace.endTime FROM tbl_teacher,tbl_teacherquestionspace WHERE tbl_teacher.teacherID=? AND tbl_teacherquestionspace.teacherID=tbl_teacher.teacherID";
		PreparedStatement ps = conn.prepareStatement(getSQL);
		ps.setLong(1, teacher.getId());
		return ps.executeQuery();
	}

	public ResultSet get(Connection conn, QuestionSpace space) throws SQLException {
		String sql = "SELECT * FROM tbl_teacherquestionspace WHERE id=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, space.getId());
		return ps.executeQuery();
	}

}
