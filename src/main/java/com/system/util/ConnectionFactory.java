package com.system.util;

import java.util.Properties;

import org.junit.Test;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
	private static String driver;
	private static String dburl;
	private static String user;
	private static String password;
	private static final ConnectionFactory factory = new ConnectionFactory();
	private Connection conn = null;
	static {
		Properties prop = new Properties();
		try {
			InputStream in = ConnectionFactory.class.getClassLoader().getResourceAsStream("dbconfig.properties");
			prop.load(in);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		driver = prop.getProperty("driver");
		dburl = prop.getProperty("dburl");
		user = prop.getProperty("user");
		password = prop.getProperty("password");
		System.out.println("user" + user + "password" + password);
	}

//	private ConnectionFactory() {
//
//	}

	public static ConnectionFactory getInstace() {
		return factory;
	}
	@Test
	public void testConn(){
		makeConnection();
	}
	public Connection makeConnection() {

		try {
			Class.forName(driver);
			System.out.println(dburl + " " + user + " " + password);
			conn = DriverManager.getConnection(dburl, user, password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
}
