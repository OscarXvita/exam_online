package com.system.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.system.dao.AnnounceDao;
import com.system.entity.Announce;
import com.system.entity.Teacher;

public class AnnounceDaoImpl implements AnnounceDao {
	private final String format = "%Y-%m-%d %H:%i:%s";

	@Override
	public void insert(Connection conn, Announce announce, Teacher teacher) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO tbl_announce VALUES(?,?,STR_TO_DATE(?,'"
				+ format + "'),?,NULL)";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, announce.getTitle());
		ps.setString(2, announce.getContent());
		ps.setString(3, announce.getTime());
		ps.setLong(4, teacher.getId());
		ps.execute();
	}

	@Override
	public void update(Connection conn, Announce annnounce) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(Connection conn, Announce announce) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM tbl_announce WHERE announceID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, announce.getId());
		ps.execute();
	}

	@Override
	public ResultSet get(Connection conn, Announce announce) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM tbl_announce WHERE announceID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, announce.getId());
		return ps.executeQuery();
	}

	@Override
	public ResultSet get(Connection conn, Teacher teacher) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM tbl_announce WHERE teacherID=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setLong(1, teacher.getId());
		return ps.executeQuery();
	}
	

}
