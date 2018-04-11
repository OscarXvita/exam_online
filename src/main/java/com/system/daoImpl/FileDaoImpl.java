package com.system.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.dao.FileDao;
import com.system.entity.SaveFile;
import com.system.entity.Student;
import com.system.entity.Teacher;

public class FileDaoImpl implements FileDao {

	@Override
	public void insert(Connection conn, Student student, Teacher teacher, SaveFile file) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO tbl_file VALUES(NULL,?,?,?,?,?)";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, file.getFileName());
		ps.setString(2, file.getFileLocate());
		ps.setLong(3, student.getId());
		ps.setLong(4, teacher.getId());
		if (file.isAccept()) {
			ps.setInt(5, 1);
		} else {
			ps.setInt(5, 0);
		}
		ps.execute();
	}

	@Override
	public void update(Connection conn, SaveFile file) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "UPDATE tbl_file SET acceptState=? WHERE fileLocate=?";

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(2, file.getFileLocate());
		/// System.out.println(file.getFileLocate());
		if (file.isAccept()) {
			ps.setInt(1, 1);
			// System.out.println("ok");
		} else {
			ps.setInt(1, 0);
		}
		// System.out.println("update");
		ps.execute();
	}

	@Override
	public void delete(Connection conn, SaveFile file) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "DELETE from tbl_file WHERE fileID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, file.getFileID());
		ps.execute();
	}

	@Override
	public ResultSet get(Connection conn, SaveFile file) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM tbl_file WHERE fileID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, file.getFileID());
		return ps.executeQuery();
	}

	@Override
	public void insert(Connection conn, Teacher teacher, Student student, SaveFile file) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO tbl_file (fileName,fileLocate,fromID,toID,acceptState) VALUES(?,?,?,?,?)";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, file.getFileName());
		ps.setString(2, file.getFileLocate());
		ps.setLong(4, student.getId());
		ps.setLong(3, teacher.getId());
		if (file.isAccept()) {
			ps.setInt(5, 1);
		} else {
			ps.setInt(5, 0);
		}
		// System.out.println("老师给学生上传了一个文件");
		ps.execute();
	}

	public ResultSet getFromOf(Connection conn, Student student) throws SQLException {
		String sql = "SELECT * FROM tbl_file WHERE fromID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, student.getId());
		return ps.executeQuery();
	}

	public ResultSet getFromOf(Connection conn, Teacher teacher) throws SQLException {
		String sql = "SELECT * FROM tbl_file WHERE fromID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, teacher.getId());
		return ps.executeQuery();
	}

	public ResultSet getToOf(Connection conn, Teacher teacher) throws SQLException {
		String sql = "SELECT * FROM tbl_file WHERE toID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, teacher.getId());
		return ps.executeQuery();
	}

	public ResultSet getToOf(Connection conn, Student student) throws SQLException {
		String sql = "SELECT * FROM tbl_file WHERE toID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, student.getId());
		return ps.executeQuery();
	}
}
