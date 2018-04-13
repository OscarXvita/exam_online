package com.system.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.system.service.ObjectQuestionService;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.system.entity.ObjectQuestion;
import com.system.entity.QuestionSpace;
import com.system.service.XlsResolveService;
import com.system.util.FileRootFactory;

public class do_FileUpLoad extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2398119461999403630L;

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// super.doPost(req, resp);
		System.out.println("准备导入");
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/plain");
		PrintWriter writer = resp.getWriter();
		HttpSession session = req.getSession();
		if (session.getAttribute("currentTeacherSpace") == null) {
			writer.println("没有相应的题库信息");
			writer.flush();
			return;
		}
		new FileRootFactory();
		String tempPath = FileRootFactory.getUpLocation();
		new FileRootFactory();
		String filePath = FileRootFactory.getTrueLoacation();
		File dir = new File(tempPath);
		dir.mkdirs();
		dir = new File(filePath);
		dir.mkdirs();
		dir=null;
		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(4 * 1024);// 设置缓冲区大小
			factory.setRepository(new File(tempPath));
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(4000 * 1024 * 1024);// 设置上传文件的最大大小为4000M
			List<FileItem> items = upload.parseRequest(req);
			Iterator<FileItem> iter = items.iterator();
			while (iter.hasNext()) {
				FileItem item = iter.next();
				if (!item.isFormField()) {
					String fileName = item.getName();
					int index = fileName.lastIndexOf("\\");
					fileName = fileName.substring(index + 1, fileName.length());
					long fileSize = item.getSize();
					if (fileName.equals("") && fileSize == 0) {
						writer.println("文件大小为空");
						writer.flush();
					} else {
						File uploadFile = new File(filePath + "/" + fileName);
						item.write(uploadFile);
						writer.println("文件上传成功");
						writer.println("文件大小为：" + fileSize + "KB");
						writer.println("解析中");
						writer.flush();
						XlsResolveService xlsResolveService = new XlsResolveService();
						Vector<ObjectQuestion> questions = xlsResolveService.resoloveXls(uploadFile);
						if (questions != null) {
							writer.println("解析完成,准备添加至数据库中");

							QuestionSpace currentTeacherSpace = (QuestionSpace) session
									.getAttribute("currentTeacherSpace");
							// session.setAttribute("questionsFile", questions);
							ObjectQuestionService service = new ObjectQuestionService();
							boolean flag = service.addQuestionsToSpace(questions, currentTeacherSpace);
							if (flag) {
								writer.println("已经全部添加到题库中");
								writer.flush();
							} else {
								writer.println("添加失败");
								writer.flush();
							}
						} else {
							writer.println("无法解析");
							writer.flush();
						}

					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			writer.println("无法解析");
			writer.flush();
		}
	}

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
}
