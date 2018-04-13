package com.system.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.dao.ObjectAnswerInfoDao;
import com.system.entity.ObjectAnswer;
import com.system.entity.ObjectQuestion;
import com.system.entity.Test;

public class ObjectAnswerInfoDaoImpl implements ObjectAnswerInfoDao {
	private final String format = "%Y-%m-%d %H:%i:%s";

	@Override
	public void insert(Connection conn, Test test, ObjectQuestion question, ObjectAnswer answer) throws SQLException {
		// TODO Auto-generated method stub

		String inserSql = "INSERT INTO tbl_objectanswerinfo VALUES(NULL,?,?,?,?,STR_TO_DATE(?,'"
				+ format + "'),?)";
		PreparedStatement ps = conn.prepareStatement(inserSql);
		
		ps.setLong(1, test.getTestID());
		ps.setLong(2, question.getId());
		ps.setInt(3, answer.getAnswerContent());
		ps.setInt(4, answer.getAnswerScore());
		ps.setString(5, answer.getAnswerTime());
		ps.setInt(6, (answer.isChecked() == true ? 1 : 0));
		
		
		ps.execute();
	}

	@Override
	public void update(Connection conn, ObjectAnswer answer) throws SQLException {
		// TODO Auto-generated method stub
		String updateSql = "UPDATE tbl_objectanswerinfo SET studentAnswer=?,answerScore=? ,isChecked=? WHERE answerInfoID=?";
		PreparedStatement ps = conn.prepareStatement(updateSql);
		ps.setInt(1, answer.getAnswerContent());
		ps.setInt(2, answer.getAnswerScore());
		ps.setInt(3, answer.isChecked() == true ? 1 : 0);
		ps.setLong(4, answer.getAnswerInfoID());
		ps.execute();

	}
	
	@Override
	public void delete(Connection conn, ObjectAnswer answer) throws SQLException {
		// TODO Auto-generated method stub
		String deleteSql = "DELETE * FROM tbl_objectanswer WHERE answerInfoID=?";
		PreparedStatement ps = conn.prepareStatement(deleteSql);
		ps.setLong(1, answer.getAnswerInfoID());
		ps.execute();

	}

	@Override
	/*
	 * 通过测试的ID来查找answer
	 * 
	 */
	public ResultSet get(Connection conn, Test test) throws SQLException {
		// TODO Auto-generated method stub
		String getSql = "SELECT tbl_objectanswerinfo.answerInfoID,tbl_objectanswerinfo.testID,tbl_objectanswerinfo.questionID,tbl_objectanswerinfo.studentAnswer,tbl_objectanswerinfo.answerScore,tbl_objectanswerinfo.answerTime,tbl_objectanswerinfo.isChecked FROM tbl_objectanswerinfo,tbl_test WHERE tbl_test.testID=? AND tbl_test.testID=tbl_objectanswerinfo.testID";
		PreparedStatement ps = conn.prepareStatement(getSql);
		ps.setLong(1, test.getTestID());
		return ps.executeQuery();
	}

	/*
	 * 通过question的ID来查找answer
	 */
	public ResultSet get(Connection conn, ObjectQuestion question) throws SQLException {

		String getSql = "SELECT tbl_objectanswerinfo.answerInfoID,tbl_objectanswerinfo.testID,tbl_objectanswerinfo.questionID,tbl_objectanswerinfo.studentAnswer,tbl_objectanswerinfo.answerScore,tbl_objectanswerinfo.answerTime,tbl_objectanswerinfo.isChecked FROM tbl_objectanswerinfo,tbl_objectquestion WHERE tbl_objectquestion.questionID=? AND tbl_objectquestion.questionID=tbl_objectanswerinfo.questionID";
		PreparedStatement ps = conn.prepareStatement(getSql);
		ps.setLong(1, question.getId());
		return ps.executeQuery();
	}

	/*
	 * 通过answerInfoId来查找answer
	 */
	public ResultSet get(Connection conn, ObjectAnswer answer) throws SQLException {
		String getSql = "SELECT * FROM tbl_objectanswerinfo WHERE answerInfoID=?";
		PreparedStatement ps = conn.prepareStatement(getSql);
		ps.setLong(1, answer.getAnswerInfoID());
		return ps.executeQuery();
	}

}
