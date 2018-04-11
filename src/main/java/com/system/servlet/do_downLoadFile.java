package com.system.servlet;



import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.system.service.NormalFileService;
import com.system.util.FileRootFactory;

public class do_downLoadFile extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9142191718274552731L;
	private String filePath = FileRootFactory.getTrueLoacation();

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// TODO Auto-generated method stub
		// super.doGet(req, resp);
		OutputStream out;// 获得响应文件的输出流
		InputStream in;// 获得本地文件的输入流
		String fileName = req.getParameter("fileName");
		if (fileName == null) {
			out = resp.getOutputStream();
			out.write("no name".getBytes());
			out.close();
			return;
		}
		//System.out.println(filePath + "/" + fileName);
		
		in = new NormalFileService().downFile(filePath+"/"+fileName,req.getSession().getAttribute("teacher")!=null);
		if(in!=null){
			int length = in.available();
			// 设置相应正文的MIME类型
			resp.setContentType("application/force-download");
			resp.setHeader("Contemt_length", String.valueOf(length));
			resp.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\" ");

			out = resp.getOutputStream();
			int bytesRead = 0;
			byte[] buffer = new byte[1024];
			while ((bytesRead = in.read(buffer)) != -1) {
				out.write(buffer, 0, bytesRead);
			}
			in.close();
			out.close();
		}
		
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// super.doPost(req, resp);
		doGet(req, resp);
	}
}
