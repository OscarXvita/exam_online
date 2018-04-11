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
<% request.setCharacterEncoding("UTF-8");%>
<%response.setCharacterEncoding("UTF-8"); %>
	<%
		if (!session.isNew()) {

			if ((session == null) || session.getAttribute("type") == null || session.getAttribute("teacher") == null
					|| session.getAttribute("state") == null) {
	%>
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
	%>
	<form method="post" action="addObjectQuestion">
		请输入题目内容： <input type="text" name="questionName"><br> <br />
		请输入A选项内容： <input type="text" name="answerA"><br> <br />
		请输入B选项内容： <input type="text" name="answerB"><br> <br />
		请输入C选项内容： <input type="text" name="answerC"><br> <br />
		请输入D选项内容： <input type="text" name="answerD"><br> <br />
		请选择正确选项： <input type="radio" name="correctAnswer" value="1">A<br>
		<input type="radio" name="correctAnswer" value="2">B<br>
		<input type="radio" name="correctAnswer" value="3">C<br>
		<input type="radio" name="correctAnswer" value="4">D<br>
		请输入答案解析： <input type="text" name="answerAnalyze"><br> <br />
		请输入该题的分值： <input type="text" name="score"><br> <br /> 
		<input
			type="submit" name="submit" value="确定"><br> <br /> <br />

	</form>
	<h1>从Excel中导入</h1>
	<br />
	<br />
	<form name="uploadFileForm" method="post" enctype="multipart/form-data"
		action="fileUpLoad">
		<input type="file" name="upFile" size=50 /><br /> <br /> <input
			type="submit" name="submit" value="upload" />
	</form>
	<%
		} else {
					session.invalidate();
					response.sendRedirect("index.jsp");
				}
	%>
	<%
		}
			%>
			<a href="getTeacherAllSpace.jsp">返回</a>
		<%} else {
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="index.jsp">登录</a>
	<%
		}
	%>






</body>
</html>