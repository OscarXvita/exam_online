package com.system.entity;

import java.io.Serializable;

public class ObjectAnswer implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4177651667251406148L;
	private long answerInfoID;
	private int answerScore = 0;
	private String answerTime = "2016-01-01 09:00:00";
	private int answerContent = 0;
	private boolean isChecked = false;

	public long getAnswerInfoID() {
		return answerInfoID;
	}

	public void setAnswerInfoID(long answerInfoID) {
		this.answerInfoID = answerInfoID;
	}

	public int getAnswerScore() {
		return answerScore;
	}

	public void setAnswerScore(int answerScore) {
		this.answerScore = answerScore;
	}

	public String getAnswerTime() {
		return answerTime;
	}

	public void setAnswerTime(String answerTime) {
		this.answerTime = answerTime;
	}

	public int getAnswerContent() {
		return answerContent;
	}

	public void setAnswerContent(int answerContent) {
		this.answerContent = answerContent;
	}

	public boolean isChecked() {
		return isChecked;
	}

	public void setChecked(boolean isChecked) {
		this.isChecked = isChecked;
	}

}
