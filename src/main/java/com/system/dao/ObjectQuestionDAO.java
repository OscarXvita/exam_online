package com.system.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.entity.ObjectQuestion;
import com.system.entity.QuestionSpace;

public interface ObjectQuestionDAO {
	void insert(Connection conn, ObjectQuestion question, QuestionSpace space) throws SQLException;

	void update(Connection conn, ObjectQuestion question) throws SQLException;

	void delete(Connection conn, ObjectQuestion question) throws SQLException;

	ResultSet get(Connection conn, QuestionSpace space) throws SQLException;
}
