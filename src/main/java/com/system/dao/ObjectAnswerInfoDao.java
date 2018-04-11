package com.system.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.entity.ObjectAnswer;
import com.system.entity.ObjectQuestion;


import com.system.entity.Test;

public interface ObjectAnswerInfoDao {
	void insert(Connection conn, Test test, ObjectQuestion question, ObjectAnswer answer)
			throws SQLException;

	void update(Connection conn, ObjectAnswer answer) throws SQLException;

	void delete(Connection conn, ObjectAnswer answer) throws SQLException;

	ResultSet get(Connection conn, Test test) throws SQLException;
}
