<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.system.entity.*"%>
<%@page import="java.util.*"%>
<%@page import="com.system.service.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教师查看学生绑定邀请</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
	<%
		if ((session == null) || session.getAttribute("state") == null
				|| (Boolean) session.getAttribute("state") == false || session.getAttribute("type") == null
				|| session.getAttribute("teacher") == null) {
	%>
	<%="你还没有登陆"%>&nbsp;
	<a href="index.jsp">现在去登陆</a>
	<%
		} else {
			//以下准备插入数据
	%>
	<%
		Teacher teacher = (Teacher) session.getAttribute("teacher");
			List<Student> applyStudents = new BindingService().getApplyStudent(teacher);
			Iterator<Student> iterator = applyStudents.iterator();
	
	%>
	<div class="page-content">
	<div id="teacher-list">
	<form method="post" action="acceptBinding">

		<table class="table-striped table">
		<tr align="center">
		<td  width="25%">
		打勾
		</td>
		<td  width="25%">
		姓名
		</td>
		<td  width="25%">
		邮箱
		</td>
		<td  width="25%">
		性别
		</td>
		</tr>
		
		
		
		<%
			while (iterator.hasNext()) {
					Student s = iterator.next();%>
					<tr align="center">
					<td  width="25%">
					<input type="checkbox" name="acceptStudents" value=<%=s.getEmail() %>>
					</td>	
					<td  width="25%">
					<%=s.getName() %>
					</td>
					<td  width="25%">
					<%=s.getEmail() %>
					</td>
					<td  width="25%">
					<%=(s.getGender().equals("0")) ? "男" : "女" %>
					</td>
					</tr>
					
					<% 
	

			}
		%>
		</table>
		<br /> <br /> <br />
		<button class="btn btn-success">允许</button>
	</form>
	</div>
	</div>
	<%
		}
	%>
</body>
</html>