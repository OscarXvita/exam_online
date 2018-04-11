package com.system.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.system.entity.Test;
import com.system.service.CheckTestService;

public class do_checkTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if (!session.isNew()) {
			if (session == null || session.getAttribute("teacher") == null
					|| (Boolean) session.getAttribute("state") == false) {
				session.invalidate();
				response.sendRedirect("index.jsp");
			} else {
				String testID = request.getParameter("testID");
				System.out.println("该testID=" + testID);
				if (testID != null && !testID.equals("")) {
					Test test = new Test();

					test.setTestID(Long.parseLong(testID));
					int score = new CheckTestService().checkTest(test);
					System.out.println("score="+score);
					if (score == -1) {
						System.out.println("批改失败");

						request.getRequestDispatcher("/Teacher/teacherIndex.jsp").forward(request, response);

					} else {
						System.out.println("批改成功");
						request.getRequestDispatcher("/Teacher/TestRecord.jsp").forward(request, response);

					}

					// request.setAttribute(testID, score);
					// RequestDispatcher
					// rd=request.getRequestDispatcher("/allRecord.jsp");
					// rd.forward(request,response);

				} else {
					session.invalidate();
					response.sendRedirect("index.jsp");
				}

			}

		} else {
			session.invalidate();
			response.sendRedirect("index.jsp");

		}

	}
}
