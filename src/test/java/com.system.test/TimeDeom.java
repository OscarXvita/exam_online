package com.system.test;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeDeom {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Date date=new Date();
		  DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  String time=format.format(date);//time就是当前时间
		  System.out.println(time);
	}

}
