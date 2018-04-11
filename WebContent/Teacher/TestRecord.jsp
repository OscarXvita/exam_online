<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.system.service.*"%>
<%@page import="java.util.*"%>
<%@page import="com.system.entity.*"%>
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
<title>I考试记录</title>
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
					<h1>
						<a href="#"><img alt="" src="resources/images/logo.png"></a>
					</h1>
				</div>
			</div>
			<div class="col-xs-7" id="login-info">

				<a class="btn btn-primary" href=""><%="欢迎您，"+t.getName()+"!" %></a> <a
					class="btn btn-success" href="logout">登出</a>

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
				<li><a href="teacherIndex.jsp"><i class="fa fa-home"></i>主页</a></li>
				<li><a href="getTeacherAllSpace.jsp"><i class="fa fa-file-text-o"></i>管理题库</a></li>
				<li class="active"><a href="TestRecord.jsp"><i class="fa fa-trophy"></i>考试记录</a>
				</li>
				<li><a href="paperManage.jsp"><i class="fa fa-cloud"></i>管理试题</a></li>
				<li><a href="bindedStudent.jsp"><i class="fa fa-user"></i>学生管理</a></li>
				<li><a href="@student.jsp"><i class="fa fa-cubes"></i>@学生</a></li>
				<li><a href="viewOldNotice.jsp"><i class="fa fa-dashboard"></i>公告管理</a></li>
			</ul>
			</nav>
		</div>
	</div>


<%="&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" %>
<%="所有题库：" %>
	<%
					List<QuestionSpace> spacelists = new QuestionSpaceService().getQuestionSpaceOfTeacher(t);
					session.setAttribute("SpaceList", spacelists);
					for (int i = 0; i < spacelists.size(); i++) {
	%>

	<a href="TestRecord.jsp?spaceID=<%=spacelists.get(i).getId()%>"><%="&nbsp&nbsp&nbsp"+spacelists.get(i).getName()%></a>
	<%-- 	<form method="post" action="allRecord.jsp">
	<input type="hidden" name="spaceID" value=<%=spacelists.get(i).getId() %>>
	<input type="submit" name="submit" value=<%=spacelists.get(i).getName() + "-" + spacelists.get(i).getType()%>>
	</form><br> --%>


	<%
		}
	%>
	<%
String spaceID = request.getParameter("spaceID");
	if(spaceID==null||spaceID.equals("")){
		if(spacelists!=null&&spacelists.size()>0){
		spaceID=String.valueOf(spacelists.get(0).getId());}
	
		
	}
if(spaceID!=null&&!spaceID.equals("")){
	for (int i = 0; i < spacelists.size(); i++) {
		if(spacelists.get(i).getId()==Long.parseLong(spaceID)){
			%><br>
			
			<table>
			<tr>
			<td>
			<%="&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" %>
			<%="当前题库："+ spacelists.get(i).getName()%>
			</td>
			<td>
				<form method="post" action="viewScoreAnalyze.jsp">
				<input type="hidden" name="spaceID" value=<%=spaceID %>>
				<button class="btn btn-success">排名</button>
				</form>
			</td>
			<td>
				<form method="post" action="viewPassRate.jsp">
				<input type="hidden" name="spaceID" value=<%=spaceID %>>
				<button class="btn btn-success">通过率</button>
				</form>
			</td>	
			
			</tr>
			
			
			
			</table>
			

	
			<% 
		}
	}
	
	
	%>

	<div class="content" style="margin-bottom: 100px;">

		<div class="container" style="margin-top: 40px;">

			<div class="row" style="margin-left: 50px;">
				<div class="col-xs-10">
					<div style="border-bottom: 1px solid #ddd;">

						<h3 class="title">
							<i class="fa fa-trophy"></i> 考试记录
						</h3>
					</div>

					<% 
	QuestionSpace currentTeacherSpace = new QuestionSpace();
	currentTeacherSpace.setId(Long.parseLong(spaceID));
	Map<Test, Student> map = new TestService().getTestRecord(currentTeacherSpace);
				Test test = new Test();
				Student student = new Student();
				int i = 1;
				int all = 0;
				int checked = 0;
				int score = 0;
				String state = "";
				String str = "";
				if (map != null) {
					%>


					<div class="col-xs-5">
						<table class="table-striped table">
							<tr align="center">
								<h6>未批改的试卷</h6>
							</tr>
							<tr align="center">
								<td width="16%">姓名</td>
								<td width="16%">性别</td>
								<td width="16%">邮箱</td>
								<td width="20%">考试时间</td>
								<td width="16%">分数</td>
								<td width="16%">操作</td>
							</tr>
							<%
		for (Map.Entry<Test, Student> me : map.entrySet()) {
							test = me.getKey();
							student = me.getValue();
							if (student.getGender().equals("0")) {
								//student.setGender("男");
							} else {
								//student.setGender("女");
							}

							if (test.isExam()) {
	%>

							<%
		Map<Integer, Integer> map1 = new TestService().getCheckState(test);
								if (map1 != null) {
									for (Map.Entry<Integer, Integer> m : map1.entrySet()) {
										all = m.getKey();
										checked = m.getValue();
									}
									if (all != 0 && all > checked) {
										str = "批改";
	%>


							<tr align="center">
								<td width="16%"><%=student.getName() %></td>
								<td width="16%"><%=student.getGender().equals("0")?"男":"女" %></td>
								<td width="16%"><%=student.getEmail() %></td>
								<td width="20%"><%=test.getTestTime() %></td>
								<td width="16%"><%=score %></td>
								<form method="post" action="checkTest.jsp">
									<input type="hidden" name="testID" value=<%=test.getTestID()%>>
									<td width="16%"><button class="btn btn-success"><%=str%></button></td>
								</form>

							</tr>










							<% 
				}

	
	
}




%>


							<%
		}}
									%>

						</table>
					</div>
					<% 
					}
			/***************************************/
				
						if (map != null) {
					%>


					<div class="col-xs-5" style="margin-left: 150px;">
						<table class="table-striped table">
							<tr align="center">
								<h6>已批改的试卷</h6>
							</tr>
							<tr align="center">
								<td width="16%">姓名</td>
								<td width="16%">性别</td>
								<td width="16%">邮箱</td>
								<td width="20%">考试时间</td>
								<td width="16%">分数</td>
								<td width="16%">操作</td>
							</tr>
							<%
		for (Map.Entry<Test, Student> me : map.entrySet()) {
							test = me.getKey();
							student = me.getValue();
							if (student.getGender().equals("0")) {
								//student.setGender("男");
							} else {
								//student.setGender("女");
							}

							if (test.isExam()) {
	%>

							<%
		Map<Integer, Integer> map1 = new TestService().getCheckState(test);
								if (map1 != null) {
									for (Map.Entry<Integer, Integer> m : map1.entrySet()) {
										all = m.getKey();
										checked = m.getValue();
									}
									if (all != 0 && all == checked) {
										str = "查看";
	%>


							<tr align="center">
								<td width="16%"><%=student.getName() %></td>
								<td width="16%"><%=student.getGender().equals("0")?"男":"女" %></td>
								<td width="16%"><%=student.getEmail() %></td>
								<td width="20%"><%=test.getTestTime() %></td>
								<td width="16%"><%=test.getTestScore()%></td>
								<form method="post" action="viewStudentTestPaper.jsp">
									<input type="hidden" name="testID" value=<%=test.getTestID()%>>
									<td width="16%"><button class="btn btn-success"><%=str%></button></td>
								</form>

							</tr>










							<% 
				}

	
	
}




%>


							<%
		}}
									%>

						</table>
					</div>
					<% 
					}							
									
									
									
									
		%>
				</div>
				<% 
				%>
			</div>
		</div>

	</div>
	<% 
				}
				%>

	<%

if(spaceID!=null&&!spaceID.equals("")){
	%>

	<div class="content" style="margin-bottom: 100px;">

		<div class="container" style="margin-top: 40px;">

			<div class="row" style="margin-left: 50px;">
				<div class="col-xs-10">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-trophy"></i> 练习记录
						</h3>
					</div>

					<% 
	QuestionSpace currentTeacherSpace = new QuestionSpace();
	currentTeacherSpace.setId(Long.parseLong(spaceID));
	Map<Test, Student> map = new TestService().getTestRecord(currentTeacherSpace);
				Test test = new Test();
				Student student = new Student();
				int i = 1;
				int all = 0;
				int checked = 0;
				int score = 0;
				String state = "";
				String str = "";
				if (map != null) {
					%>


					<div class="col-xs-5">
						<table class="table-striped table">
							<tr align="center">
								<h6>未批改的练习</h6>
							</tr>
							<tr align="center">
								<td width="16%">姓名</td>
								<td width="16%">性别</td>
								<td width="16%">邮箱</td>
								<td width="20%">考试时间</td>
								<td width="16%">分数</td>
								<td width="16%">操作</td>
							</tr>
							<%
		for (Map.Entry<Test, Student> me : map.entrySet()) {
							test = me.getKey();
							student = me.getValue();
							//System.out.println(student.getGender());
							if (student.getGender().equals("0")) {
								
								//student.setGender("男");
							} else {
								//student.setGender("女");
							}

							if (!test.isExam()) {
	%>

							<%
		Map<Integer, Integer> map1 = new TestService().getCheckState(test);
								if (map1 != null) {
									for (Map.Entry<Integer, Integer> m : map1.entrySet()) {
										all = m.getKey();
										checked = m.getValue();
									}
									if (all != 0 && all > checked) {
										str = "批改";
	%>


							<tr align="center">
								<td width="16%"><%=student.getName() %></td>
								<td width="16%"><%=student.getGender().equals("0")?"男":"女" %></td>
								<td width="16%"><%=student.getEmail() %></td>
								<td width="20%"><%=test.getTestTime() %></td>
								<td width="16%"><%=score %></td>
								<form method="post" action="checkTest.jsp">
									<input type="hidden" name="testID" value=<%=test.getTestID()%>>
									<td width="16%"><button class="btn btn-success"><%=str%></button></td>
								</form>

							</tr>










							<% 
				}

	
	
}




%>


							<%
		}}
									%>

						</table>
					</div>
					<% 
					}
			/***************************************/
				
						if (map != null) {
					%>


					<div class="col-xs-5" style="margin-left: 150px;">
						<table class="table-striped table">
							<tr align="center">
								<h6>已批改的练习</h6>
							</tr>
							<tr align="center">
								<td width="16%">姓名</td>
								<td width="16%">性别</td>
								<td width="16%">邮箱</td>
								<td width="20%">考试时间</td>
								<td width="16%">分数</td>
								<td width="16%">操作</td>
							</tr>
							<%
		for (Map.Entry<Test, Student> me : map.entrySet()) {
							test = me.getKey();
							student = me.getValue();
							if (student.getGender().equals("0")) {
								//student.setGender("男");
							} else {
								//student.setGender("女");
							}

							if (!test.isExam()) {
	%>

							<%
		Map<Integer, Integer> map1 = new TestService().getCheckState(test);
								if (map1 != null) {
									for (Map.Entry<Integer, Integer> m : map1.entrySet()) {
										all = m.getKey();
										checked = m.getValue();
									}
									if (all != 0 && all == checked) {
										str = "查看";
	%>


							<tr align="center">
								<td width="16%"><%=student.getName() %></td>
								<td width="16%"><%=student.getGender().equals("0")?"男":"女" %></td>
								<td width="16%"><%=student.getEmail() %></td>
								<td width="20%"><%=test.getTestTime() %></td>
								<td width="16%"><%=test.getTestScore() %></td>
								<form method="post" action="viewStudentTestPaper.jsp">
									<input type="hidden" name="testID" value=<%=test.getTestID()%>>
									<td width="16%"><button class="btn btn-success"><%=str%></button></td>
								</form>

							</tr>










							<% 
				}

	
	
}




%>


							<%
		}}
									%>

						</table>
					</div>
					<% 
					}							
									
									
									
									
		%>
				</div>
				<% 
				%>
			</div>
		</div>

	</div>
	<% 
				}%>
				
						<footer>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="copy">
							<p>
								在线考试系统 ?<!-- 这里面的 连接是本网站的连接 -->
                                 <a href="＃" target="_blank">在线考试系统</a> - <a href="TestRecord.jsp" target="_blank">考试记录</a>
							</p>
						</div>
					</div>
				</div>

			</div>

		</footer>
				
				
				
				<% 
 }						
			else {
					session.invalidate();
					response.sendRedirect("index.jsp");
				}
	%>
	<%
		}
			%>
	<% }
		else{%>
	<%session.invalidate(); %>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="../index.jsp">登录</a>
	<% 	}
	%>
</body>
</html>