package com.system.entity;
import java.util.*;
public class TypeBank {
	private String type1="计算机组成原理";
	private String type2="Java" ;
	private String type3="C++" ;
	private String type4="计算机网络" ;
	public List<String> getBankType(){
		List<String> banklists=new ArrayList<String>();
		banklists.add(type1);
		banklists.add(type2);
		banklists.add(type3);
		banklists.add(type4);
		return banklists;
		
	}
	

}
