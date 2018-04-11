package com.system.test;
public class TimeTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String time="2014-06-01 13:00:00";
		com.system.util.TimeUtil ti = new com.system.util.TimeUtil();
		ti.parseStringToDate(time);
	}

}
