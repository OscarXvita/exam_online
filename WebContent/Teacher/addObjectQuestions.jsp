<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.system.entity.*"%>
<%@ page import="com.system.entity.Teacher" %>
<%@ page import="com.system.entity.QuestionSpace" %>
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
<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">
<link href="resources/css/mystyle.css" rel="stylesheet">

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
<title>增加题目</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<%
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
		if(request.getParameter("spaceID")!=null){
		long spaceID = Long.parseLong(request.getParameter("spaceID"));
				QuestionSpace space = new QuestionSpace();
				space.setId(spaceID);
				session.setAttribute("currentTeacherSpace", space);
		}
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
					<h1>
						<a href="#"><img alt="" src="resources/images/logo.png"></a>
					</h1>
				</div>
			</div>
			<div class="col-xs-7" id="login-info">

				<a class="btn btn-primary" href=""><%="欢迎您，" + t.getName() + "!"%></a>
				<a class="btn btn-success" href="logout">登出</a>

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
				<li><a href="teacherIndex.jsp"><i class="fa fa-home"></i>主页</a>
				</li>
				<li class="active"><a href="getTeacherAllSpace.jsp"><i
						class="fa fa-edit"></i>管理题库</a></li>
				<li><a href="TestRecord.jsp"><i class="fa fa-dashboard"></i>考试记录</a>
				</li>
				<li><a href="paperManage.jsp"><i class="fa fa-cogs"></i>管理试题</a>
				</li>
				<li><a href="bindedStudent.jsp"><i class="fa fa-cogs"></i>学生管理</a>
				</li>
				<li><a href="@student.jsp"><i class="fa fa-cogs"></i>@学生</a></li>
				<li><a href="viewOldNotice.jsp"><i class="fa fa-cogs"></i>公告管理</a>
				</li>
			</ul>
			</nav>
		</div>
	</div>

	<!-- Navigation bar ends -->
	<div>
		<!-- Slider (Flex Slider) -->

		<div class="container" style="min-height: 500px;">

			<div class="row">
				<div class="col-xs-2" id="left-menu">


					<ul class="nav default-sidenav">
						<!-- 	<li>
								<a href="admin/user-list"> <i class="fa fa-list-ul"></i> 会员管理 </a>
							</li>
							<li class="active">
								<a> <i class="fa fa-list-ul"></i> 添加会员 </a>
							</li> -->


						<li class="active"><a href="addObjectQuestions.jsp"
							title="手动添加"><i class="fa fa-plus-square">&nbsp</i><span
								class="left-menu-item-name"> 手动添加</span></a></li>
						<li><a href="import.jsp" title="从Excel导入"><i
								class="fa fa-volume-up">&nbsp</i><span
								class="left-menu-item-name"> 从Excel导入</span></a></li>





					</ul>
				</div>

				<div class="col-xs-10">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-dashboard"></i> 手动添加
						</h3>
					</div>
					<div>

						<form method="post" action="addObjectQuestion">
							请输入题目内容：<br>
							<textarea name="questionName" rows="4" cols="80"></textarea>
							<br> <br /> 请输入A选项内容：<br>
							<textarea name="answerA" rows="4" cols="80"></textarea>
							<br> <br /> 请输入B选项内容： <br>
							<textarea name="answerB" rows="4" cols="80"></textarea>
							<br> <br /> 请输入C选项内容：<br>
							<textarea name="answerC" rows="4" cols="80"></textarea>
							<br> <br /> 请输入D选项内容： <br>
							<textarea name="answerD" rows="4" cols="80"></textarea>
							<br> <br /> 请选择正确选项： <br> <input type="radio"
								name="correctAnswer" value="1">A<br> <input
								type="radio" name="correctAnswer" value="2">B<br> <input
								type="radio" name="correctAnswer" value="3">C<br> <input
								type="radio" name="correctAnswer" value="4">D<br>
							请输入答案解析： <br>
							<textarea name="answerAnalyze" rows="4" cols="80"></textarea>
							<br> <br /> 请输入该题的分值： <input type="text" name="score"><br>
							<br />
							<button class="btn btn-success">确定</button>

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
						在线考试系统 ?
						<!-- 这里面的 连接是本网站的连接 -->
						<a href="＃" target="_blank">在线考试系统</a> - <a href="."
							target="_blank"></a>
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
	<a href="getTeacherAllSpace.jsp">返回</a>
	<%
		} else {
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="../index.jsp">登录</a>
	<%
		}
	%>






</body>
</html>