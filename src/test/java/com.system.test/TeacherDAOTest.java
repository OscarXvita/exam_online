package com.system.test;

import java.sql.Connection;

import java.sql.SQLException;

import com.system.daoImpl.TeacherDaoImpl;
import com.system.entity.Teacher;
import com.system.util.ConnectionFactory;

public class TeacherDAOTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		Teacher t = new Teacher();
		t.setEmail("teacher@126.com");
		t.setGender("1");
		t.setName("王老师");
		t.setPassword("123");
		t.setPhone("138138138138");
		//TeacherDaoImpl tdi = new TeacherDaoImpl();
		int i=0;
		try {
			while(true){
				new TeacherDaoImpl().insert(conn, t);
				t.setEmail(String.valueOf(i)+"sdfas");
		i++;
			}
			// tdi.insert(conn, t);
			// tdi.delete(conn, t);
			// tdi.update(conn, t);
		
			

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
