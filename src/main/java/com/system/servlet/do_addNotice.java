package com.system.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.system.entity.Announce;
import com.system.entity.Teacher;
import com.system.service.AnnounceService;

public class do_addNotice extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if (!session.isNew()) {
			Teacher t = (Teacher) session.getAttribute("teacher");
			if (t == null || t.equals("")) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
				return;
			} else {
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				if (title != null && content != null && !title.equals("") && !content.equals("")) {
					com.system.util.TimeUtil ti = new com.system.util.TimeUtil();
					String time = ti.getTime();
					Announce notice = new Announce();
					notice.setContent(content);
					notice.setTitle(title);
					notice.setTime(time);
					boolean flag = new AnnounceService().addAnnounce(notice, t);
					if (flag) {
						System.out.println("发布成功");
						
						request.getRequestDispatcher("/Teacher/viewOldNotice.jsp").forward(request, response);
					} else {

						System.out.println("发布失败");
						request.getRequestDispatcher("/error.jsp").forward(request, response);

					}
				} else {
					System.out.println("系统繁忙，请稍候重试");
					request.getRequestDispatcher("/error.jsp").forward(request, response);
					return;
				}

			}
		} else {
			session.invalidate();
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}

	}
}
