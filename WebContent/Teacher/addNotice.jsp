<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@page import="com.system.service.*"%>
<%@page import="java.util.*"%>
<%@page import="com.system.entity.*"%>
<%@ page import="com.system.entity.Teacher" %>
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

<title>发布公告</title>
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
		<!-- Navigation bar starts -->

		<div class="navbar bs-docs-nav" role="banner">
			<div class="container">
				<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
					<ul class="nav navbar-nav">
						<li>
							<a href="teacherIndex.jsp"><i class="fa fa-home"></i>主页</a>
						</li>
						<li>
							<a href="getTeacherAllSpace.jsp"><i class="fa fa-file-text-o"></i>管理题库</a>
						</li>
						<li>
							<a href="TestRecord.jsp"><i class="fa fa-trophy"></i>考试记录</a>
						</li>
						<li>
							<a href="paperManage.jsp"><i class="fa fa-cloud"></i>管理试题</a>
						</li>
						<li>
							<a href="bindedStudent.jsp"><i class="fa fa-user"></i>学生管理</a>
						</li>
						<li>
							<a href="@student.jsp"><i class="fa fa-cubes"></i>@学生</a>
						</li>
						<li class="active">
							<a href="viewOldNotice.jsp"><i class="fa fa-dashboard"></i>公告管理</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>

		<!-- Navigation bar ends -->
<div>
			<!-- Slider (Flex Slider) -->

			<div class="container" style="min-height:500px;">

				<div class="row">
					<div class="col-xs-2" id="left-menu">
						

					<ul class="nav default-sidenav">
						<!-- 	<li>
								<a href="admin/user-list"> <i class="fa fa-list-ul"></i> 会员管理 </a>
							</li>
							<li class="active">
								<a> <i class="fa fa-list-ul"></i> 添加会员 </a>
							</li> -->
	
		
			<li>
				<a href="viewOldNotice.jsp" title="查看历史公告"><i class="fa fa-volume-up">&nbsp</i><span class="left-menu-item-name"> 查看历史公告</span></a>
			</li>
		
		
	
		
			<li  class="active">
				<a href="addNotice.jsp" title="发布新公告"><i class="fa fa-plus-square">&nbsp</i><span class="left-menu-item-name"> 发布新公告</span></a>
			</li>
		
</ul></div>
					<div class="col-xs-10">
						<div style="border-bottom: 1px solid #ddd;">
							<h3 class="title"><i class="fa fa-dashboard"></i> 公告管理</h3>
						</div>	
						<div>
							<form method="post" action="addNotices">
							标题：<br>
							<input type="text" name="title" ><br>
							内容：<br>
							<textarea name="content" rows="6" cols="80"></textarea><br>
							<button class="btn btn-success">发布</button>
							</form>
						</div>

					</div>
				</div>
			</div>
		</div>
							
				<footer>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="copy">
							<p>
								在线考试系统 ?<!-- 这里面的 连接是本网站的连接 -->
                                 <a href="＃" target="_blank">在线考试系统</a> - <a href="." target="_blank">公告管理</a>
							</p>
						</div>
					</div>
				</div>

			</div>

		</footer>					
			
	
	<% }

				else {
	%>
	<%
		session.invalidate();
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="../index.jsp">登录</a>
	<%
		}

			}
			%>
			
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
</body>
</html>