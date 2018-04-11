package com.system.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.dao.ObjectQuestionDAO;
import com.system.entity.ObjectQuestion;
import com.system.entity.QuestionSpace;

public class ObjectQuestionDaoImpl implements ObjectQuestionDAO {

	@Override
	public void insert(Connection conn, ObjectQuestion question, QuestionSpace space) throws SQLException {
		// TODO Auto-generated method stub
		String insertSQL = "INSERT INTO tbl_objectquestion VALUES(NULL,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = conn.prepareStatement(insertSQL);
		ps.setString(1, question.getTitle());
		ps.setString(2, question.getChoiceA());
		ps.setString(3, question.getChoiceB());
		ps.setString(4, question.getChoiceC());
		ps.setString(5, question.getChoiceD());
		ps.setInt(6, question.getCorrectAnswer());
		ps.setString(7, question.getAnswerAnalyze());
		ps.setInt(8, question.getScore());
		ps.setLong(9, space.getId());
		System.out.println(ps.toString());
		ps.execute();

	}

	@Override
	public void update(Connection conn, ObjectQuestion question) throws SQLException {
		// TODO Auto-generated method stub
		String updateSQL = "UPDATE tbl_objectquestion SET questionContent=?,answer1=?,answer2=?,answer3=?,answer4=?,trueAnswer=?,questionAnalyze=?,score=? WHERE questionID=?";
		PreparedStatement ps = conn.prepareStatement(updateSQL);
		ps.setString(1, question.getTitle());
		ps.setString(2, question.getChoiceA());
		ps.setString(3, question.getChoiceB());
		ps.setString(4, question.getChoiceC());
		ps.setString(5, question.getChoiceD());
		ps.setInt(6, question.getCorrectAnswer());
		ps.setString(7, question.getAnswerAnalyze());
		ps.setInt(8, question.getScore());
		ps.setLong(9, question.getId());
		ps.execute();
	}

	@Override
	public void delete(Connection conn, ObjectQuestion question) throws SQLException {
		// TODO Auto-generated method stub
		String deleteSQL = "DELETE  FROM tbl_objectquestion WHERE questionID=?";
		PreparedStatement ps = conn.prepareStatement(deleteSQL);
		ps.setLong(1, question.getId());
		ps.execute();
	}

	@Override
	public ResultSet get(Connection conn, QuestionSpace space) throws SQLException {
		// TODO Auto-generated method stub

		String getSQL = "SELECT tbl_objectquestion.questionID,tbl_objectquestion.questionContent,tbl_objectquestion.answer1,tbl_objectquestion.answer2,tbl_objectquestion.answer3,tbl_objectquestion.answer4,tbl_objectquestion.trueAnswer,tbl_objectquestion.questionAnalyze,tbl_objectquestion.score FROM tbl_teacherquestionspace,tbl_objectquestion WHERE tbl_teacherquestionspace.id=? AND tbl_objectquestion.questionSpaceID=tbl_teacherquestionspace.id";
		PreparedStatement ps = conn.prepareStatement(getSQL);
		ps.setLong(1, space.getId());
		return ps.executeQuery();
	}
	/*
	 * 通过ID查找
	 */
	public ResultSet get(Connection conn,ObjectQuestion question) throws SQLException{
		String getSQL="SELECT * FROM tbl_objectquestion WHERE questionID=?";
		PreparedStatement ps=conn.prepareStatement(getSQL,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ps.setLong(1, question.getId());
		return ps.executeQuery();
				
	}
	/*
	 * 删除属于某个题库的所有题目
	 */
	public void deleteAll(Connection conn,QuestionSpace space)throws SQLException{
		String deleteAllSql="DELETE * FROM tbl_objectquestion WHERE questionSpaceID=?";
		PreparedStatement ps=conn.prepareStatement(deleteAllSql);
		ps.setLong(1, space.getId());
		ps.execute();
		
	}

}
