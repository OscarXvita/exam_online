package com.system.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.entity.SaveFile;
import com.system.entity.Student;
import com.system.entity.Teacher;

public interface FileDao {
	void insert(Connection conn, Student student, Teacher teacher, SaveFile file) throws SQLException;

	void insert(Connection conn, Teacher teacher, Student student, SaveFile file) throws SQLException;

	void update(Connection conn, SaveFile file) throws SQLException;

	void delete(Connection conn, SaveFile file) throws SQLException;

	ResultSet get(Connection conn, SaveFile file) throws SQLException;
}
