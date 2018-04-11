<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.system.entity.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<!--<base href="http://localhost:8080/Portal/">-->
		<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>Exam++</title>
		<meta name="viewport"
		content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="keywords" content="">
		<!--<link rel="shortcut icon" href="http://localhost:8080/Portal/../resources/images/favicon.ico" />-->
		<link href="resources/bootstrap/css/bootstrap-huan.css"
		rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css"
		rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">
		<link href="resources/css/mystyle.css"  rel="stylesheet">

		<style>
			.table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
				padding: 8px 0;
				line-height: 1.42857143;
				vertical-align: middle;
				border-top: 1px solid #ddd;
			}

			a.join-practice-btn {
				margin-top: 0;
			}
		</style>
		
		
		
		
<title>我的主页</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
	<%
		if (!session.isNew()) {

			if ((session == null) || session.getAttribute("type") == null || session.getAttribute("teacher") == null
					|| session.getAttribute("state") == null) {
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="../index.jsp">登录</a>

	<%
		} else {
	%>
	<%
		String type = (String) session.getAttribute("type");
				Teacher t = (Teacher) session.getAttribute("teacher");
				boolean flag = (boolean) session.getAttribute("state");
				if (flag && type.equals("teacher")) {
					//out.println("欢迎您，" + t.getName() + "教师!");
	%>
				<header>
			<div class="container">
				<div class="row">
					<div class="col-xs-5">
						<div class="logo">
							<h1><a href="#"><img alt="" src="resources/images/logo.png"></a></h1>
						</div>
					</div>
					<div class="col-xs-7" id="login-info">

						<a class="btn btn-primary" href=""><%="欢迎您，"+t.getName()+"!" %></a>
						<a class="btn btn-success" href="logout">登出</a>

					</div>
				</div>
			</div>
		</header>
		<div class="navbar bs-docs-nav" role="banner">
			<div class="container">
				<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
					<ul class="nav navbar-nav">
						<li >
							<a href="teacherIndex.jsp"><i class="fa fa-home"></i>主页</a>
						</li>
						<li class="active">
							<a href="getTeacherAllSpace.jsp"><i class="fa fa-edit"></i>管理题库</a>
						</li>
						<li>
							<a href="TestRecord.jsp"><i class="fa fa-dashboard"></i>考试记录</a>
						</li>
						<li>
							<a href="paperManage.jsp"><i class="fa fa-cogs"></i>管理试题</a>
						</li>
						<li>
							<a href="bindedStudent.jsp"><i class="fa fa-cogs"></i>学生管理</a>
						</li>
						<li>
							<a href="@student.jsp"><i class="fa fa-cogs"></i>@学生</a>
						</li>
						<li>
							<a href="viewOldNotice.jsp"><i class="fa fa-cogs"></i>公告管理</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>
		<center>
	<form method="post" action="teacherBank">
		请输入题库名：<br><input type="text" name="bankName"><br> <br />
		请选择题库类型：<br/>
		<%
 	List<String> banklists = new TypeBank().getBankType();
 %>
		<%
			if (banklists != null) {
		%>
		<select name="bankType">
		<%
			for (int i = 0; i < banklists.size(); i++) {
		%>
		
		<option  value=<%=banklists.get(i) %>><%=banklists.get(i) %></option>

		<%
			}
		
		%>
		</select><br/><br/>
		设置答题数目：<br/>
		<input type="text" name="amount"/>
		<br/>
		<br/>
		
		开始时间： <br/><input name="startTime" type="text"><br/><br/> 结束时间：<br/> <input
			name="endTime" type="text"><br> <input type="submit"
			name="submit" value="确定"><br>
	</form>
	</center>
	<%
		} else {
	%>
	<%="无法获取题库类型"%>
	<%
		}
	%>

	<%
		} else {
					session.invalidate();
					response.sendRedirect("index.jsp");
				}
	%>
	<%
		}
			%>
			<!-- <a href="teacherIndex.jsp">返回</a> -->
		<%} else {
	%>
	<%
		session.invalidate();
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="../index.jsp">登录</a>
	<%
		}
	%>





</body>
</html>