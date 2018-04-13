package com.system.test;

import java.util.Iterator;
import java.util.List;

import com.system.entity.Teacher;
import com.system.service.ConsultService;

public class GetAllTeacherTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List<Teacher> l=new ConsultService().getAllTeachers();
		Iterator<Teacher> iterator=l.iterator();
		while(iterator.hasNext()){
			Teacher t= iterator.next();
			System.out.println(t.getEmail());
		}
	}

}
