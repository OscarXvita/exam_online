package com.system.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.entity.*;

public interface StudentDAO {
	void insert(Connection conn, Student student) throws SQLException;

	void update(Connection conn, Student student) throws SQLException;

	void delete(Connection conn, Student student) throws SQLException;

	ResultSet get(Connection conn, Student student) throws SQLException;
}
