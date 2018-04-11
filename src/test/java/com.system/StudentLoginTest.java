package com.system.test;

import com.system.entity.Student;
import com.system.service.LoginService;

public class StudentLoginTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Student s=new Student();
		s.setEmail("yytwz96@163.com");
		s.setPassword("root123");
		LoginService login=new LoginService();
		boolean b=login.studentLogin(s);
		System.out.println(b);
	}

}
