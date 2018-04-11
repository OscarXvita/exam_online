package com.system.entity;

import java.io.Serializable;

public class ObjectQuestion implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3497124813514084374L;
	private long id;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	private String title = "没有找到该题";
	private String choiceA = "无";
	private String choiceB = "无";
	private String choiceC = "无";
	private String ChoiceD = "无";
	private int correctAnswer = 0;
	private int score = 0;

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	private String answerAnalyze="无";

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getChoiceA() {
		return choiceA;
	}

	public void setChoiceA(String choiceA) {
		this.choiceA = choiceA;
	}

	public String getChoiceB() {
		return choiceB;
	}

	public void setChoiceB(String choiceB) {
		this.choiceB = choiceB;
	}

	public String getChoiceC() {
		return choiceC;
	}

	public void setChoiceC(String choiceC) {
		this.choiceC = choiceC;
	}

	public String getChoiceD() {
		return ChoiceD;
	}

	public void setChoiceD(String choiceD) {
		ChoiceD = choiceD;
	}

	public int getCorrectAnswer() {
		return correctAnswer;
	}

	public void setCorrectAnswer(int correctAnswer) {
		this.correctAnswer = correctAnswer;
	}

	public String getAnswerAnalyze() {
		return answerAnalyze;
	}

	public void setAnswerAnalyze(String answerAnalyze) {
		this.answerAnalyze = answerAnalyze;
	}

}
