package com.system.test;
import java.io.File;
import java.util.Vector;

import com.system.entity.ObjectQuestion;
import com.system.service.XlsResolveService;
public class XlsServiceTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		XlsResolveService svs=new XlsResolveService();
		File file=new File("C:/Users/Shayne/Desktop/导入ExcelDemo/计算机操作基础.xls");
		Vector<ObjectQuestion>v=svs.resoloveXls(file);
		System.out.println(v==null);
		System.out.println(v.get(10).getTitle());
	
		System.out.println(v.size());
	}

}
