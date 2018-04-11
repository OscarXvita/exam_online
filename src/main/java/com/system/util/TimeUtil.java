package com.system.util;

import java.sql.Date;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class TimeUtil {
	/*
	 * 这个方法有毒，需要修改，不要用!!!!!
	 */
	public static  Date getCurrentTime() {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date(System.currentTimeMillis());
		format.format(now);
		return now;
	}

	/*
	 * 该方法返回当前时间的字符串，主要调用这个方法
	 */
	public  String getTime() {
		java.util.Date date = new java.util.Date();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}

	public java.sql.Date parseStringToDate(String str) {
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 小写的mm表示的是分钟
		try {
			java.util.Date date = sdf.parse(str);
			System.out.println(date.getTime());
			java.sql.Date sqlDate = new java.sql.Date(date.getTime());

			System.out.println(sqlDate);
			return sqlDate;
		} catch (ParseException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
			return null;
		}
	}
}
