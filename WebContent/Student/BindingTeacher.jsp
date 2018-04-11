<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.system.entity.*"%>
<%@page import="com.system.service.*"%>
<%@page import="java.util.*"%>
<%@page import="com.system.dataManagement.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<!--<base href="http://localhost:8080/Portal/">-->
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>绑定老师</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="keywords" content="">
<!--<link rel="shortcut icon" href="http://localhost:8080/Portal/../resources/images/favicon.ico" />-->
<link href="../resources/bootstrap/css/bootstrap-huan.css"
	rel="stylesheet">
<link href="../resources/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet">

<style>
.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td,
	.table>tbody>tr>td, .table>tfoot>tr>td {
	padding: 8px 0;
	line-height: 1.42857143;
	vertical-align: middle;
	border-top: 1px solid #ddd;
}

a.join-practice-btn {
	margin-top: 0;
}
</style>

</head>
<%
	if (!(session.getAttribute("student") == null || session.isNew())) {
		Student student = (Student) session.getAttribute("student");
		ViewTeacherService service = new ViewTeacherService();
		List<Teacher> allTeachers = new ConsultService().getAllTeachers();//所有老师
		List<Teacher> bindingTeachers = service.getBindingTeachers(student);//正在绑定
		List<Teacher> bindedTeachers = service.getBindedTeachers(student);//绑定成功
		//System.out.println("sizeixiasdfasdf"+bindedTeachers.size());
		List<Teacher> remainTeacher = new ManageUnbindingTeacher().getUnbindingTeacher(
				service.getBindedTeachers(student), service.getBindingTeachers(student),
				new ConsultService().getAllTeachers());
		if (remainTeacher != null && bindedTeachers != null && bindingTeachers != null && allTeachers != null) {
			//System.out.println("所有老师的人数："+allTeachers.size());
			//System.out.println("正在绑定的老师的人数:"+bindingTeachers.size());
			//System.out.println("绑定成功的老师的人数:"+bindedTeachers.size())	;
			//System.out.println("剩余没有绑定的老师的人数" + remainTeacher.size());
%>



<body>
	<header>
	<div class="container">
		<div class="row">
			<div class="col-xs-5">
				<div class="logo">
					<h1>
						<a href="#"><img alt="" src="../resources/images/logo.png"></a>
					</h1>
				</div>
			</div>
			<div class="col-xs-7" id="login-info">

				<a class="btn btn-primary" href="">欢迎您<%=student.getName()%></a>
				<a class="btn btn-success" href="logout">退出</a>

			</div>
		</div>
	</div>
	</header>
	<!-- Navigation bar starts -->

	<div class="navbar bs-docs-nav" role="banner">
		<div class="container">
			<nav class="collapse navbar-collapse bs-navbar-collapse"
				role="navigation">
			<ul class="nav navbar-nav">
				<li><a href="Home.jsp"><i class="fa fa-home"></i>主页</a>
				</li>
				<li><a href="Practice.jsp"><i class="fa fa-edit"></i>试题练习</a></li>
				<li><a href="Test.jsp"><i class="fa fa-dashboard"></i>在线考试</a>
				</li>
				<li><a href="@teacher.jsp"><i class="fa fa-cogs"></i>@老师</a></li>
				<li  class="active"><a href="BindingTeacher.jsp"><i class="fa fa-dashboard"></i>绑定老师</a>
				</li>
				<li><a href="Feedback.jsp"><i class="fa fa-dashboard"></i>成绩反馈</a>
				</li>
			</ul>
			</nav>
		</div>
	</div>

	<!-- Navigation bar ends -->

	<!-- Slider starts -->
	<!-- 未绑定！ -->
	<div class="content" style="margin-bottom: 100px;">

		<div class="container">
			<br /> <br />
			<div class="row">
				<div class="col-xs-12">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-book"></i> 未绑定的老师
						</h3>
						<!-- 这里面的 是默认的第一题库 -->
					</div>

					<table class="table-striped table">
						<thead>

							<tr>
								<td>老师</td>
								<td>性别</td>
								<td>电话</td>
								<td>邮箱</td>
							</tr>
						</thead>
						<tbody>
							<%
								Iterator<Teacher> remainIter = remainTeacher.iterator();
										while (remainIter.hasNext()) {
											Teacher tempTeacher = remainIter.next();
											String gender = "男";

											if (tempTeacher.getGender() == "1") {
												gender = "女";
											}
							%>


							<!--老师的姓名-->
							<tr>
								<td><%=tempTeacher.getName()%></td>
								<!--性别-->
								<td><%=gender%></td>
								<!-- 老师的电话-->
								<td><span class="span-info question-number"><%=tempTeacher.getPhone()%></span></td>
								<!-- 老师的邮箱-->
								<td><%=tempTeacher.getEmail()%></td>
								<!-- 相关操作-->
								<td>
								<form method="post" action="binding">
								<button class="btn btn-success btn-sm join-practice-btn" type="submit">申请</button>
								<input type="hidden" name="teacher" value=<%=tempTeacher.getEmail() %> />
									</form>
									</td>
							</tr>



							<%
								}
							%>
						</tbody>
						<tfoot></tfoot>
					</table>
				</div>

			</div>

		</div>

	</div>
	<div class="content" style="margin-bottom: 10px;">
		<!-- 已经绑定！ -->
		<div class="container">
			<br /> <br />
			<div class="row">
				<div class="col-xs-12">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-book"></i> 已经绑定的老师
						</h3>
						<!-- 这里面的 是默认的第一题库 -->
					</div>

					<table class="table-striped table">
						<thead>

							<tr>
								<td>老师</td>
								<td>性别</td>
								<td>电话</td>
								<td>邮箱</td>
							</tr>
						</thead>
							<tbody>
						<%
							Iterator<Teacher> bindedIter = bindedTeachers.iterator();
									while (bindedIter.hasNext()) {

										Teacher tempTeacher = bindedIter.next();
										String gender = "男";

										if (tempTeacher.getGender() == "1") {
											gender = "女";
										}

										//System.out.println("++");
						%>

					
							<!--老师的姓名-->
							<tr>
								<td><%=tempTeacher.getName()%></td>
								<!--性别-->
								<td><%=gender%></td>
								<!-- 老师的电话-->
								<td><span class="span-info question-number"><%=tempTeacher.getPhone()%></span></td>
								<!-- 老师的邮箱-->
								<td><%=tempTeacher.getEmail()%></td>

							</tr>


						
						<%
							}
						%>
						</tbody>
						<tfoot></tfoot>
					</table>
				</div>

			</div>

		</div>






		<div class="container">
			<br /> <br />
			<div class="row">
				<div class="col-xs-12">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-book"></i> 正在申请的老师
						</h3>
						<!-- 这里面的 是默认的第一题库 -->
					</div>

					<table class="table-striped table">
						<thead>

							<tr>
								<td>老师</td>
								<td>性别</td>
								<td>电话</td>
								<td>邮箱</td>
							</tr>
						</thead>
						<tbody>
						<%
							Iterator<Teacher> bindingIter = bindingTeachers.iterator();
									while (bindingIter.hasNext()) {
										Teacher tempTeacher = bindingIter.next();
										String gender = "男";

										if (tempTeacher.getGender() == "1") {
											gender = "女";
										}
						%>

						
							<!--老师的姓名-->
							<tr>
								<td><%=tempTeacher.getName()%></td>
								<!--性别-->
								<td><%=gender%></td>
								<!-- 老师的电话-->
								<td><span class="span-info question-number"><%=tempTeacher.getPhone()%></span></td>
								<!-- 老师的邮箱-->
								<td><%=tempTeacher.getEmail()%></td>
							</tr>


						
						<%
							}
						%>
						</tbody>
						<tfoot></tfoot>
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
						在线考试系统 ©
						<!-- 这里面的 连接是本网站的连接 -->
						<a href="绑定老师.html" target="_blank">在线考试系统的主页</a> - <a href="."
							target="_blank">绑定老师</a>
					</p>
				</div>
			</div>
		</div>

	</div>

	</footer>

	<!-- Slider Ends -->

	<!-- Javascript files -->
	<!-- jQuery -->

</body>
<%
	}
%>
<%
	}
%>
</html>