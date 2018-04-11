package com.system.dataManagement;

import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import com.system.entity.Student;

public class ManageStudent {

	public Vector<Student> getStudent(Vector<Student> allStudent,List<Student> bindingStudent){
		if(allStudent!=null&&bindingStudent!=null){
			Iterator<Student> iterList=allStudent.iterator();
			
			while(iterList.hasNext()){
				Student s=iterList.next();
				Iterator<Student> iterList2=bindingStudent.iterator();
				while(iterList2.hasNext()){
					Student s2=iterList2.next();
					if(s.getEmail().equals(s2.getEmail())){
						iterList.remove();
					}
				}
			}
			
			return allStudent;	
		}
		else{
			return null;
		}
		
		
		
		
		
		
	}
	
	
	
	
}
