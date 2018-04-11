<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.system.entity.*"%>
<%@ page import="com.system.service.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<%
if(!session.isNew()){


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
				String spaceID=request.getParameter("spaceID");
				QuestionSpace currentTeacherSpace= new QuestionSpace();
				currentTeacherSpace.setId(Long.parseLong(spaceID));
				session.setAttribute("currentTeacherSpace", currentTeacherSpace);%>
			
				
		        <%@ include file="showQuestions.jsp" %>
				
				
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
	<%}
else{%>
<%="会话过期或者未登录，请重新登录"%>
<a href="../index.jsp">登录</a>
<% 	}
%>


</body>
</html>