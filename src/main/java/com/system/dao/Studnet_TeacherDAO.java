package com.system.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.entity.Student;
import com.system.entity.Teacher;

public interface Studnet_TeacherDAO {
	void insert(Connection conn, Student student, Teacher teacher) throws SQLException;

	void update(Connection conn, Student student, Teacher teacher) throws SQLException;

	void delete(Connection conn, Student student, Teacher teacher) throws SQLException;

	ResultSet get(Connection conn, Student student, Teacher teacher) throws SQLException;
}
