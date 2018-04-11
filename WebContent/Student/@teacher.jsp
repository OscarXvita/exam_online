<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.system.entity.*"%>
<%@page import="com.system.service.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--<base href="http://localhost:8080/Portal/">-->
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>考试成绩反馈</title>
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
%>
<%
	Student student = (Student) session.getAttribute("student");
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
				<li ><a href="Home.jsp"><i
						class="fa fa-home"></i>主页</a></li>
				<li><a href="Practice.jsp"><i class="fa fa-edit"></i>试题练习</a></li>
				<li><a href="Test.jsp"><i class="fa fa-dashboard"></i>在线考试</a>
				</li>
				<li class="active"><a href="@teacher.jsp"><i class="fa fa-cogs"></i>@老师</a></li>
				<li><a href="BindingTeacher.jsp"><i class="fa fa-dashboard"></i>绑定老师</a>
				</li>
				<li><a href="Feedback.jsp"><i class="fa fa-dashboard"></i>成绩反馈</a>
				</li>
			</ul>
			</nav>
		</div>
	</div>

	<!-- Navigation bar ends -->

	<!-- Slider starts -->
	<div class="content" style="margin-bottom: 100px;">

		<div class="container">
			<br /> <br />

			<div class="row">
				<div class="col-xs-12">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-book"></i>老师下发的文件
						</h3>
						<br />
						<!-- 这里面的 是默认的第一题库 -->
					</div>

					<table class="table-striped table">
						<thead>

							<tr>
								<td>老师的名字</td>
								<td>文件名</td>
								<td>接受状态</td>
							</tr>
						</thead>
						<tbody>
						<%
							Map<SaveFile, Teacher> map = new NormalFileService().getRecvFiles(student);
								for (Map.Entry<SaveFile, Teacher> entry : map.entrySet()) {
									SaveFile sfile = entry.getKey();
									Teacher teacher = entry.getValue();
									if (sfile != null && teacher != null) {
										String fileName = sfile.getFileName();
										String fileLocate = sfile.getFileLocate();
										boolean acceptState = sfile.isAccept();
										String state = "未接收";
										if (acceptState) {
											state = "已接收";
										}
										String teacherName = teacher.getName();
						%>
						
							<!-- 老师的名字-->
							<tr>
								<td><%=teacherName%></td>
								<!-- 上传的文件-->
								<td><a href="download?<%="fileName=" + fileName%>"><%=fileName%></a></td>
								<!-- 接受的状态-->
								<td><span class="span-info question-number"><%=state%></span></td>

								<!-- 考试的相关操作-->
								<td><a href="download?<%="fileName=" + fileName%>"
									class="btn btn-success btn-sm join-practice-btn">查看</a></td>
							</tr>


						
						<%
							}
						%>
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




	<div class="content" style="margin-bottom: 100px;">

		<div class="container">
			<br /> <br />

			<div class="row">
				<div class="col-xs-12">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-book"></i> 我上传的文件
						</h3>
						<br />
						<!-- 这里面的 是默认的第一题库 -->
					</div>

					<table class="table-striped table">
						<thead>

							<tr>
								<td>老师的名字</td>
								<td>文件名</td>
								<td>接受状态</td>
							</tr>
						</thead>
						<tbody>
						<%
							Map<SaveFile, Teacher> fileMap = new NormalFileService().getSendFile(student);
								if (fileMap != null) {
									for (Map.Entry<SaveFile, Teacher> entry : fileMap.entrySet()) {
										SaveFile sfile = entry.getKey();
										Teacher teacher = entry.getValue();
										String teacherName = teacher.getName();
										boolean acptState = sfile.isAccept();
										String state = "未接收";
										if (acptState) {
											state = "已接收";
										}
										String fileName = sfile.getFileName();
										String fileLocalte = sfile.getFileLocate();
						%>
						
							<!-- 老师的名字-->
							<tr>
								<td><%=teacherName%></td>
								<!-- 上传的文件-->
								<td><a href="download?<%="fileName=" + fileName%>"><%=fileName%></a></td>
								<!-- 接受的状态-->
								<td><span class="span-info question-number"><%=state%></span></td>

								<!-- 考试的相关操作-->
								<td><a href="download?<%="fileName=" + fileName%>"
									class="btn btn-success btn-sm join-practice-btn">查看</a></td>
							</tr>


						
						<%
							}
						%>
						<%
							}
						%>
						</tbody>
						<tfoot></tfoot>
					</table>
				</div>








				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; &nbsp;

				<%
					List<Teacher> teachers = new ViewTeacherService().getBindedTeachers(student);
						if (teachers != null) {
				%>
				
				
								
				<div class="col-xs-12">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-book"></i> 上传文件
						</h3>
						<br />
						<!-- 这里面的 是默认的第一题库 -->
					</div>

					<table class="table-striped table">
						<thead>

							<tr>
								<td>选择老师</td>
								<td>文件名</td>
								<td>操作</td>
							</tr>
						</thead>
						<tbody>
		
					
	
							



				
				
				
				<form action="uploadStudentFile" method="post"
					enctype="multipart/form-data">
					<tr>
					<td><select name="teacherEmail">
						<%
							Iterator<Teacher> iter = teachers.iterator();

									while (iter.hasNext()) {
										Teacher tempTeacher = iter.next();
						%>


						<option value=<%=tempTeacher.getEmail()%>><%=tempTeacher.getName()%></option>

						<%
							}
						%>
					</select>
					</td>
					<td> <input name="upFile"type="file"> <input type="hidden"name="studentEmail" value=<%=student.getEmail()%> /></td>
					<td><button type="submit" 
						class="btn btn-success btn-sm join-practice-btn">上传文件</button></td>
						</tr>
				</form>
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
						<a href="考试成绩反馈.html" target="_blank">在线考试系统的主页</a> - <a href="."
							target="_blank">考试反馈</a>
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
</html>