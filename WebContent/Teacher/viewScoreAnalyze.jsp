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
		
		
		
		
<title>排名情况</title>
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
	<a href="../index.jsp">登录</a>
	<%
		} else {
	%>
	
	<%
   					 String type = (String) session.getAttribute("type");
					Teacher t = (Teacher) session.getAttribute("teacher");
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
		<center><h2>成绩分析</h2></center>
					<% 
					boolean flag = (boolean) session.getAttribute("state");
					if (flag && type.equals("teacher")) {
							//out.println("欢迎您，" + t.getName() + "教师!");
							String spaceID=request.getParameter("spaceID");
							if(spaceID!=null&&!spaceID.equals("")){
								QuestionSpace currentTeacherSpace= new QuestionSpace();
								currentTeacherSpace.setId(Long.parseLong(spaceID));
								 Map<Student, Integer> map=new ScoreAnalyzeService().getRangeMap(currentTeacherSpace);
								 Student student=new Student();
								 int score=0;
								 int i=0;
								 int outstanding=0;
								 int pass=0;
								 int unPass=0;
								 int good=0;
								 if(map!=null){
									 %>
									 			       <table class="table-striped table">
								<thead>
									
									<tr>
										<td>名次</td>
										<td></td>
										<td>学生姓名</td>
										<td>分数</td>
									</tr>
								</thead>
								<tbody>
									 <% 
									 for(Map.Entry<Student, Integer> me:map.entrySet()){
										 student=me.getKey();
										 score=me.getValue();
										 i++;
										 if(score<=100&&score>=90){
											 outstanding++; 
										 }
										 else if(score>=80&&score<90){
											 good++;
										 }
										 else if(score<80&&score>=60){
											 pass++;
										 }
										 else {
											 unPass++;
										 }
										 
										 %>
							
								
									<tr>
										<td>第<%=i %>名：<td>
										
                                        <td><%=student.getName() %></td>
                                        <!-- 公告的上传时间-->  
										<td><span class="span-info question-number"><%=score %>分</span></td>
                                        <!-- 公告的上传-->  
										
									</tr>
									
								

							
										
										
									<%  }%>
										</tbody>
								<tfoot></tfoot>
							</table><br>
									总人数：<%=i %>人<br>
									 优秀:<%=outstanding %>人<br>
									 良好：<%=good %>人<br>
									 中：<%=pass %>人<br>
									 不及格：<%=unPass %>人<br>
									 
								 <% }
							}
							else{%>
								<%="系统错误，请稍候重试！" %>
								<a href="viewAllTests.jsp">返回</a>
							<% }

	
	}

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
		} else {
	%>
	<%
		session.invalidate();
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="index.jsp">登录</a>
	<%
		}
	%>
</body>
</html>