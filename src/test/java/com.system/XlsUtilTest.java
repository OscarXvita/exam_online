package com.system.test;
import java.io.File;

import com.system.util.XlsUtil;
public class XlsUtilTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		XlsUtil util=new XlsUtil();
		File file=new File("C:/Users/Shayne/Desktop/导入ExcelDemo/计算机操作基础.xls");
		System.out.println(util.checkXls(file));
	}

}
