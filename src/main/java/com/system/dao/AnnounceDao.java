package com.system.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.entity.Announce;
import com.system.entity.Teacher;

public interface AnnounceDao {
	void insert(Connection conn, Announce announce, Teacher teacher) throws SQLException;

	void update(Connection conn, Announce annnounce) throws SQLException;

	void delete(Connection conn, Announce announce) throws SQLException;

	ResultSet get(Connection conn, Announce announce) throws SQLException;

	ResultSet get(Connection conn, Teacher teacher) throws SQLException;
}
