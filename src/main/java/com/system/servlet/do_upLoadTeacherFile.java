package com.system.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.system.service.NormalFileService;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.system.entity.SaveFile;
import com.system.entity.Student;
import com.system.entity.Teacher;
import com.system.util.FileRootFactory;

public class do_upLoadTeacherFile extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6092647301811546691L;
	private Teacher teacher = null;
	private Student student = null;
	private String tempPath = FileRootFactory.getUpLocation();
	private String filePath = FileRootFactory.getTrueLoacation();
	private SaveFile saveFile = new SaveFile();
	private boolean emptyFlag = true;

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// super.doPost(req, resp);
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter writer = resp.getWriter();
		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(4 * 1024);// 上传缓存
			factory.setRepository(new File(tempPath));

			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(40 * 1024 * 1024);// 文件最大的大小
			List<FileItem> items = upload.parseRequest(req);
			Iterator<FileItem> iter = items.iterator();
			while (iter.hasNext()) {
				FileItem item = iter.next();
				if (item.isFormField()) {
					processFormFiled(item, writer);
					//System.out.println("普通");
				} else {
					processUploadFile(item, writer);
					//System.out.println("文见");
				}
			}
			if (!emptyFlag && student != null && teacher != null && teacher.getEmail() != null
					&& student.getEmail() != null && tempPath != null && filePath != null) {
				boolean flag = new NormalFileService().upFile(teacher, student, saveFile);
				if (flag) {
					writer.println("成功进入数据库");
					//writer.flush();
					req.getRequestDispatcher("teacherIndex.jsp").forward(req, resp);
				} else {
					writer.println("加入数据库失败");
					// req.getRequestDispatcher("studentIndex.jsp").forward(req,
					// resp);
				}
			} else {
				writer.println("filter失败");
				// req.getRequestDispatcher("error.jsp").forward(req, resp);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			writer.println("服务器故障");
		}
	}

	private void processUploadFile(FileItem item, PrintWriter writer) throws Exception {
		// TODO Auto-generated method stub
		String fileName = item.getName();
		int index = fileName.lastIndexOf("\\");
		fileName = fileName.substring(index + 1, fileName.length());
		long fileSize = item.getSize();
		if (fileName.equals("") && fileSize == 0) {
			return;
		}
		emptyFlag = false;
		File upLoadFile = new File(filePath + "/" + fileName);
		item.write(upLoadFile);

		writer.println("文件已上传至服务器");
		saveFile.setFileName(fileName);
		saveFile.setFileLocate(filePath + "/" + fileName);
		saveFile.setAccept(false);
	}

	private void processFormFiled(FileItem item, PrintWriter writer) {
		// TODO Auto-generated method stub
		String name = item.getFieldName();
		String value = item.getString();
		if (name.equals("teacherEmail")) {
			teacher = new Teacher();
			teacher.setEmail(value);
			writer.println("服务器连接");
		} else if (name.equals("studentEmail")) {
			student = new Student();
			student.setEmail(value);
			writer.println("服务器连接");
		}
	}

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
}
