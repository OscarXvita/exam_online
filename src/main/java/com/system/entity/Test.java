package com.system.entity;

import java.io.Serializable;

public class Test implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8950162593990950183L;
	private String testTime = "2016-01-01 09:00:00";
	private long testID;
	private boolean isExam = false;
	private int testScore = 0;

	public boolean isExam() {
		return isExam;
	}

	public void setExam(boolean isExam) {
		this.isExam = isExam;
	}

	public long getTestID() {
		return testID;
	}

	public void setTestID(long testID) {
		this.testID = testID;
	}

	public String getTestTime() {
		return testTime;
	}

	public void setTestTime(String testTime) {
		this.testTime = testTime;
	}

	public int getTestScore() {
		return testScore;
	}

	public void setTestScore(int testScore) {
		this.testScore = testScore;
	}

}
