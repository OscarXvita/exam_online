<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.system.service.*"%>
<%@page import="java.util.*"%>
<%@page import="com.system.entity.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Grade</title>
</head>
<body>
<%
		if (!session.isNew()) {
			if (session == null || session.equals("") || session.getAttribute("type") == null
					|| session.getAttribute("state") == null || session.getAttribute("teacher") == null) {
	%>
	<%
		out.println("会话过期或者未登录，请重新登录");
	%>
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
							String spaceID=request.getParameter("spaceID");
							QuestionSpace currentTeacherSpace= new QuestionSpace();
							currentTeacherSpace.setId(Long.parseLong(spaceID));
							%>
				<form method="post" action="viewScoreAnalyze.jsp">
				<input type="hidden" name="spaceID" value=<%=spaceID %>>
				<input type="submit" name="submit" value=<%="查看排名情况" %>>
				</form><br>
				<form method="post" action="viewPassRate.jsp">
				<input type="hidden" name="spaceID" value=<%=spaceID %>>
				<input type="submit" name="submit" value=<%="查看通过率情况" %>>
				</form><br>
							<% 
	
	}

				else {
	%>
	<%
		session.invalidate();
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="index.jsp">登录</a>
	<%
		}

			}
		} else {
	%>
	<%
		session.invalidate();
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="index.jsp">登录</a>
	<%
		}
	%>
</body>
</html>