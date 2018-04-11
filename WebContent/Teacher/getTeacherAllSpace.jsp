<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.system.entity.*"%>
<%@ page import="com.system.service.*"%>
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
<title>管理题库</title>
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
				if (flag && type.equals("teacher")) {%>
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
						<li class="active">
							<a href="getTeacherAllSpace.jsp"><i class="fa fa-edit"></i>题库管理</a>
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

		<!-- Navigation bar ends -->

		<!-- Slider starts -->
		<div class="content" style="margin-bottom: 100px;">

			<div class="container" style="margin-top: 40px;">
				
				<div class="row" style="margin-left: 50px;">
					<div class="col-xs-10">
						<div style="border-bottom: 1px solid #ddd;">
							<h3 class="title"><i class="fa fa-edit"></i> 题库管理</h3>
						</div>	
						<div>
							<table class="table-striped table">
								<tr align="center">
											<td width="16%">题库</td>
											<td width="16%">start</td>
											<td width="16%">end</td>
											<td width="16%">类型</td>
											<td width="16%">名称</td>
											<td width="10%">操作</td>
											<td width="10%"></td>
								</tr>

				<% 
					List<QuestionSpace> spacelists = new QuestionSpaceService().getQuestionSpaceOfTeacher(t);
					session.setAttribute("SpaceList", spacelists);
					for (int i = 0; i < spacelists.size(); i++) {
	%>

								<tr align="center">
											<td width="16%"><%=spacelists.get(i).getName()%></td>
											<td width="16%"><%=spacelists.get(i).getBeginTime() %></td>
											<td width="16%"><%=spacelists.get(i).getEndTime() %></td>
											<td width="16%">选择题</td>
											<td width="16%"><%=spacelists.get(i).getType() %></td>
											
											
											<form method="post" action="addObjectQuestions.jsp">
											<td width="10%"><button class="btn btn-success">增加题目</button></td>
											<input type="hidden" name="spaceID" value=<%=spacelists.get(i).getId()%>>
											</form>
																						
											<form method="post" action="spaceManage.jsp">
											<td width="10%"><button class="btn btn-success">查看题目</button></td>
											<input type="hidden" name="spaceID" value=<%=spacelists.get(i).getId()%>>
											</form>
										
								</tr>

	
	
	

	<%
		}
	%>
								
							</table>
						
					</div>
					
				</div>
				
				

			</div>

		</div>
		</div>
		
				<div class="content" style="margin-bottom: 100px;">

			<div class="container" style="margin-top: 40px;">
				
				<div class="row" style="margin-left: 50px;">
					<div class="col-xs-10">
						<div style="border-bottom: 1px solid #ddd;">
							<h3 class="title"><a href="teacherQuestionBank.jsp" title="创建题库"><i class="fa fa-leaf">&nbsp</i><span class="left-menu-item-name"> 创建题库</span></a></h3>
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
								在线考试系统 ©<!-- 这里面的 连接是本网站的连接 -->
                                 <a href="" target="_blank">在线考试系统</a> - <a href="getTeacherAllSpace.jsp" target="_blank">题库管理</a>
							</p>
						</div>
					</div>
				</div>

			</div>

		</footer>
	
	

	<%
		} else {
					session.invalidate();
					response.sendRedirect("index.jsp");
				}
	%>
	<%
		}
			%>

		<%}
		else{%>
		<%session.invalidate(); %>
		<%="会话过期或者未登录，请重新登录"%>
		<a href="index.jsp">登录</a>
<% 	}
	%>








</body>
</html>