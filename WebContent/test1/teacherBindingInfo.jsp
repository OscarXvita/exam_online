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
	<center>
		<h1>这是教师查看学生绑定邀请的页面</h1>
	</center>
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
	<form method="post" action="acceptBinding">
		<%
			String type1 = "checkbox";
				String FormName = "acceptStudents";
		%>
		<%
			while (iterator.hasNext()) {
					Student s = iterator.next();
					String formValue = s.getEmail();
					out.println("<input type=" + type1 + " name=" + FormName + " value=" + formValue + ">");
					out.println("&nbsp;");
					out.println("&nbsp;");
					out.println("&nbsp;");
		%>
		<%
			out.print("Name:");
					out.println(s.getName());
					out.println("&nbsp;");
					out.println("&nbsp;");
					out.println("&nbsp;");
		%>

		<%
			out.println("Email:" + s.getEmail());
					out.println("&nbsp;");
					out.println("&nbsp;");
					out.println("&nbsp;");
		%>

		<%
			out.print("Gender:");
					out.println((s.getGender().equals("0")) ? "男" : "女");
					out.println("&nbsp;");
					out.println("&nbsp;");
					out.println("&nbsp;");
		%>

		<%
			}
		%>
		<br /> <br /> <br /> <input type="submit" value="允许" />
	</form>
	<%
		}
	%>
</body>
</html>