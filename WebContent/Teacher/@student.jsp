<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.system.entity.*"%>
<%@page import="com.system.service.*"%>
<%@page import="com.system.util.*"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
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

	</head>

<%
	if (!(session.isNew() || session.getAttribute("teacher") == null)) {
		Teacher teacher = (Teacher) session.getAttribute("teacher");
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

				<a class="btn btn-primary" href="user-register">欢迎您,<%=teacher.getName()%>！</a>
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
						<li class="active">
							<a href="@student.jsp"><i class="fa fa-cubes"></i>@学生</a>
						</li>
						<li >
							<a href="viewOldNotice.jsp"><i class="fa fa-dashboard"></i>公告管理</a>
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
							<i class="fa fa-book"></i> 您接收的文件
						</h3>
						<br />
						<!-- 这里面的 是默认的第一题库 -->
					</div>
					<%
						
					%>
					<table class="table-striped table">
						<thead>

							<tr>
								<td>学生的名字</td>
								<td>文件名</td>
								<td>接受状态</td>
							</tr>
						</thead>
						<tbody>
							<%
								Map<SaveFile, Student> map = new NormalFileService().getRecvFiles(teacher);
									for (Map.Entry<SaveFile, Student> entry : map.entrySet()) {
										SaveFile sfile = entry.getKey();
										Student student = entry.getValue();
										if (sfile != null && student != null) {
											String fileName = sfile.getFileName();
											String fileLocate = sfile.getFileLocate();
											boolean acceptState = sfile.isAccept();
											String state = "未接收";
											if (acceptState) {
												state = "已接收";
											}
											String studentName = student.getName();
							%>

							<!-- 老师的名字-->
							<tr>
								<td><%=studentName%></td>
								<!-- 上传的文件-->
								<td><%=fileName%></a></td>
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
								<td>学生的名字</td>
								<td>文件名</td>
								<td>接受状态</td>
							</tr>
						</thead>
						<tbody>

							<%
								Map<SaveFile, Student> sendMap = new NormalFileService().getSendFile(teacher);
									for (Map.Entry<SaveFile, Student> entry : sendMap.entrySet()) {
										SaveFile sfile = entry.getKey();
										Student student = entry.getValue();
										if (sfile != null && student != null) {
											String fileName = sfile.getFileName();
											String fileLocate = sfile.getFileLocate();
											boolean acceptState = sfile.isAccept();
											String state = "未接收";
											if (acceptState) {
												state = "已接收";
											}
											String studentName = student.getName();
							%>


							<!-- 老师的名字-->

							<tr>
								<td><%=student.getName()%></td>
								<!-- 上传的文件-->
								<td><%=fileLocate%></td>
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
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp;
	<div class="content" style="margin-bottom: 100px;">

		<div class="container">
			<br /> <br />

			<div class="row">
				<div class="col-xs-12">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-book"></i> 上传文件
						</h3>
						<br />
					
					</div>

					<table class="table-striped table">
						<thead>

							<tr>
								<td>选择学生</td>
								<td>选择文件</td>
								<td>操作</td>
							</tr>
						</thead>
						<tbody>
	<tr>
    <form action="upLoadTeacherNormalFile" method="post" enctype="multipart/form-data">

	<input type="hidden" name="teacherEmail" value=<%=teacher.getEmail() %>>
	
	
	<td>
	<select name="studentEmail">
	<%
		Vector<Student> students = new BindingService().getAllStudent(teacher);
			Iterator<Student> iter = students.iterator();
			while (iter.hasNext()) {
				Student tempStudent=iter.next();
	%>
		<option value=<%=tempStudent.getEmail() %>><%=tempStudent.getName() %></option>

	<%
		}
	%>
	</select>
	</td>
	
	<td>
	<input name="upFile"type="file"> 
	</td>
	
	<td>
	<button  class="btn btn-success btn-sm join-practice-btn" type="submit">上传文件</button>
	</td>
	</form>
							</tr>

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
							target="_blank">@student</a>
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