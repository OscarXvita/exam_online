package com.system.util;

import java.util.ArrayList;
import java.util.List;

public class RandomManage {
	// 传入需要多少个不同的随机数，返回随机数放在List中,其中随机数介于1·amount之间，包括amount
	public List<Integer> getRandom(int amount,int range) {
		if(amount>range){
			return null;
		}
		if (amount <= 0) {
			return null;
		}
		List<Integer> tempList = new ArrayList<Integer>();
		while (tempList.size() < amount) {
			int rdm = (int) (Math.random() * range) + 1;
			if (checkList(tempList, rdm)) {
				tempList.add(rdm);
			}
		}
		return tempList;
	}

	// 查重,如果重复，返回false
	private boolean checkList(List<Integer> list, int num) {
		if (list.size() == 0) {
			return true;
		}
		for (int a : list) {
			if (a == num) {
				return false;
			}
		}
		return true;
	}
	//编码
	public String encoding(List<Long> list){
		String s="";
		for(long num:list){
			s+=num;
			s+="@";
		}
		return s;
	}
	//解码
	public List<Long>deCoding(String s){
		List<Long>intList=new ArrayList<Long>();
		String s_num[]=s.split("@");
		try {
			for(int i=0;i<s_num.length;i++){
				intList.add(Long.parseLong(s_num[i]));
			}
			return intList;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}
//	public static void main(String[] args) {
//		List<Integer>tempList=new RandomManage().getRandom(10,100);
//		for(int a:tempList){
//			System.out.println(a);
//		}
//	}
}
