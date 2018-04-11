package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.system.daoImpl.AnnounceDaoImpl;
import com.system.entity.Announce;

import com.system.entity.Teacher;
import com.system.util.ConnectionFactory;

public class AnnounceService {
	public boolean addAnnounce(Announce announce, Teacher teacher) {
		teacher = new ConsultService().getTeacherID(teacher);
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		try {
			conn.setAutoCommit(false);
			new AnnounceDaoImpl().insert(conn, announce, teacher);
			conn.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public boolean deleteAnnounce(Announce announce) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		try {
			conn.setAutoCommit(false);
			new AnnounceDaoImpl().delete(conn, announce);
			conn.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	public List<Announce> getAnnounce(Teacher teacher) {
		teacher = new ConsultService().getTeacherID(teacher);
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		List<Announce> ansList = new ArrayList<Announce>();
		ResultSet ansSet = null;
		try {
			conn.setAutoCommit(false);
			ansSet = new AnnounceDaoImpl().get(conn, teacher);
			while (ansSet.next()) {
				Announce temp = new Announce();
				temp.setId(ansSet.getLong(5));
				temp.setContent(ansSet.getString(2));
				temp.setTitle(ansSet.getString(1));
				temp.setTime(ansSet.getTimestamp(3).toString());
				ansList.add(temp);
			}
			conn.commit();
			Collections.reverse(ansList);
			return ansList;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return null;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (ansSet != null) {
				try {
					ansSet.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
