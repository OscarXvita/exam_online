package com.system.dataManagement;



import java.util.Iterator;
import java.util.List;

import com.system.entity.Teacher;

public class ManageUnbindingTeacher {


	public List<Teacher>getUnbindingTeacher(List<Teacher> l,List<Teacher> l1,List<Teacher> l2){
		//System.out.println("执行");
		if(l!=null&&l1!=null&&l2!=null){
			
			
			Iterator<Teacher> iterList2 = l2.iterator();
			while(iterList2.hasNext()){
				Teacher t2=iterList2.next();
				Iterator<Teacher> iterList = l.iterator();
				while(iterList.hasNext()){
					Teacher t=iterList.next();
//					System.out.println("t"+t.getEmail());
//					System.out.println("t2"+t2.getEmail());
					if(t.getEmail().equals(t2.getEmail())){
						iterList2.remove();
						//System.out.println("dsdsdsds");
					}
				}
				
			}
			 iterList2 = l2.iterator();
			while(iterList2.hasNext()){
				Teacher t2=iterList2.next();
				Iterator<Teacher> iterList1 = l1.iterator();
				while(iterList1.hasNext()){
					Teacher t1=iterList1.next();
//					System.out.println("t1"+t1.getEmail());
//					System.out.println("t2"+t2.getEmail());
					if(t1.getEmail().equals(t2.getEmail())){
						//System.out.println("saddsdsxfddv");
						iterList2.remove();
					}
				}
				
			}
			return l2;
		}
		else{
			return null;
		}




	}
}
