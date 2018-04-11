package com.system.entity;

import java.io.Serializable;

public class SaveFile implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7294234623321622561L;
	private long fileID;
	private String fileName="未知";
	private String fileLocate="未知";
	private boolean accept=false;
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileLocate() {
		return fileLocate;
	}
	public void setFileLocate(String fileLocate) {
		this.fileLocate = fileLocate;
	}
	
	public long getFileID() {
		return fileID;
	}
	public void setFileID(long fileID) {
		this.fileID = fileID;
	}
	public boolean isAccept() {
		return accept;
	}
	public void setAccept(boolean accept) {
		this.accept = accept;
	}
	
}
