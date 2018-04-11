package com.system.test;

import java.sql.Connection;
import java.sql.SQLException;

import com.system.util.ConnectionFactory;

public class DBConnectionTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		while (true) {
			Connection conn = ConnectionFactory.getInstace().makeConnection();
			try {
				System.out.println(conn.getCatalog());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
