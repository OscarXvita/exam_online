<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.system.entity.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (!session.isNew()) {
			if ((session == null) || session.getAttribute("type") == null || session.getAttribute("teacher") == null
					|| session.getAttribute("state") == null) {
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="index.jsp">登录</a>

	<%
		} else {
	%>
	<%
		String type = (String) session.getAttribute("type");
				Teacher t = (Teacher) session.getAttribute("teacher");
				boolean flag = (boolean) session.getAttribute("state");
				if (flag && type.equals("teacher")) {
					out.println("欢迎您，" + t.getName() + "教师!");
	%><br>
	<a href="getTeacherAllSpace.jsp">查看题库</a>
	<br />
	<a href="teacherQuestionBank.jsp">添加题库</a>
	<br>

	<a href="viewAllTests.jsp">考试管理</a>
	<br>
	<a href="viewStudent.jsp">学生管理</a>
	<br>
	<a href="notice.jsp">公告管理</a>
	<br>
	<a href="viewStudentGrade.jsp">成绩分析</a>
	<br>
	<a href="viewTeacherRecvFile.jsp">查看文件</a>
	<br />
	<a href="viewUpToStudents.jsp">给学生发文件</a>
	<br />
	<center>
		<jsp:include page="teacherBindingInfo.jsp"></jsp:include>
	</center>
	<%
		} else {
					session.invalidate();
					response.sendRedirect("index.jsp");
				}
	%>
	<%
		}
		} else {
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="index.jsp">登录</a>
	<%
		}
	%>



</body>
</html>