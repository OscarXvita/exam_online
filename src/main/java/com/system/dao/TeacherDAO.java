package com.system.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.entity.*;

public interface TeacherDAO {
	void insert(Connection conn, Teacher teacher) throws SQLException;

	void update(Connection conn, Teacher teacher) throws SQLException;

	void delete(Connection conn, Teacher teacher) throws SQLException;

	ResultSet get(Connection conn, Teacher teacher) throws SQLException;
}
