<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.system.entity.*"%>
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
						<li class="active">
							<a href="teacherIndex.jsp"><i class="fa fa-home"></i>主页</a>
						</li>
						<li>
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

		<!-- Navigation bar ends -->

		<!-- Slider starts -->
		<div class="content" style="margin-bottom: 100px;">

			<div class="container" style="margin-top: 40px;">
				
				<div class="row" style="margin-left: 50px;">
					<div class="col-xs-14">
						<div style="border-bottom: 1px solid #ddd;">
							<h3 class="title"><i class="fa fa-cloud-upload"></i> 介绍</h3>
						</div>	
						
					<!-- 	<div class="myDiv1" > -->
			<div class="full-slider">
			<!-- Slider (Flex Slider) -->

			<div class="container" >
				<div class="row" >
					<div class="col-md-12" >
						<div class="flexslider">
							<div class="flex-caption">
								<!-- Left column -->
								<div class="col-l">
									<p style="text-indent:2em;">
										Exam是国内首款一款基于JAVA与MYSQL开发的网络考试系统。它可以稳定、顺畅的运行在Windows与Linux平台上。您可以通过它快捷方便的创建试题和题库，发布试卷，组织考试，系统自动批改。高度的可配置性和灵活性使得它可以被应用于很多领域。
									</p>
							
								</div>
								<!-- Right column -->
								<div class="col-r">

									<!-- Use the class "flex-back" to add background inside flex slider -->

									<!-- <img alt="" src="../resources/images/ad.png"> -->
									<p>
										如果您对软件有任何反馈和建议，加入我们的QQ群1111一起讨论吧!
									</p>

									<!-- Button -->
									<a class="btn btn-default btn-cta" href="../index.jsp"><i class="fa fa-arrow-circle-down"></i> 马上加入我们吧</a>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
					<!-- 	</div> -->
					</div>
					<div class="col-xs-14"style="margin-right: 50px;">
						<div style="border-bottom: 1px solid #ddd;">
							<h3 class="title"><i class="fa fa-cloud-upload"></i> 申请加入的同学：</h3>
						</div>	
						
		         <jsp:include page="teacherBindingInfo.jsp"></jsp:include>
						
					</div>
					<div class="col-xs-14"style="margin-right: 50px;">
						<div style="border-bottom: 1px solid #ddd;">
							<h3 class="title"><i class="fa fa-cloud-upload"></i> 我的资源：</h3>
						</div>	
					</div>
				</div>
				
				
				<div style="margin-left: 40px;">
				  <div class="col-xs-3">
					<table width="280" height="90" align="center">
					  <tr align="center">
						<td width="50">试卷</td>
						<td width="40">10套</td>
						<td width="170"><button class="btn btn-success">查看</button></td>
					  </tr>
					</table>
				  </div>
					<div class="col-xs-3">
						<table width="280" height="90" align="center">
						  <tr align="center">
							<td width="50">试题</td>
							<td width="40">100个</td>
							<td width="170"><button class="btn btn-success">查看</button></td>
						  </tr>
						</table>
					</div>
					<div class="col-xs-3">
						 <table width="280" height="90" align="center">
						  <tr align="center">
							<td width="50">学员</td>
							<td width="40">10名</td>
							<td width="170"><button class="btn btn-success">查看</button></td>
						  </tr>
						</table>
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
                                 <a href="" target="_blank">在线考试系统的主页</a> - <a href="teacherIndex.jsp" target="_blank">主页</a>
							</p>
						</div>
					</div>
				</div>
			</div>

		</footer>
		<!-- Slider Ends -->
	

	
<br>

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
	<a href="../index.jsp">登录</a>
	<%
		}
	%>



</body>
</html>