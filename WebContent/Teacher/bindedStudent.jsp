<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@page import="com.system.service.*"%>
<%@page import="java.util.*"%>
<%@page import="com.system.entity.*"%>
<%@page import="com.system.dataManagement.*"%>
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
<title>学生管理</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8");%>
<%response.setCharacterEncoding("UTF-8"); %>
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
						<li class="active">
							<a href="bindedStudent.jsp"><i class="fa fa-user"></i>学生管理</a>
						</li>
						<li>
							<a href="@student.jsp"><i class="fa fa-cubes"></i>@学生</a>
						</li>
						<li>
							<a href="viewOldNotice.jsp"><i class="fa fa-dashboard"></i>公告管理</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>

		<!-- Navigation bar ends -->

		<!-- Slider starts -->

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
	
		
			<li class="active" >
				<a href="bindedStudent.jsp" title="已绑定"><i class="fa fa-users">&nbsp</i><span class="left-menu-item-name"> 已绑定</span></a>
			</li>
		
		
	
		
		
	
		
		
	
		
			<li >
				<a href="unbindedStudent.jsp" title="未绑定"><i class="fa fa-cubes">&nbsp</i><span class="left-menu-item-name"> 未绑定</span></a>
			</li>
		
		
	
		
		
	
</ul>
					</div>
					<div class="col-xs-10" id="right-content">
						<div class="page-header">
							<h1><i class="fa fa-bar-chart-o"></i> 学员管理 </h1>
						</div>
						<div class="page-content">
							<div id="teacher-list">
								<br>点击前面的框解除绑定：<br>
									<form method="post" action="cancelBinding">
							<table class="table-striped table">
					               <tr align="center">
					               <td width="25%">打勾</td>
												<td width="25%">学员姓名</td>
												<td width="25%">性别</td>
												<td width="25%">邮箱</td>
												
									</tr>
				<%
							Vector<Student> allStudent=new BindingService().getAllStudent(t);
							List<Student> bindingStudent=new BindingService().getApplyStudent(t);
							Vector<Student> allStudents=new ConsultService().getAllStudents();
							if(allStudent!=null&&allStudents!=null&&bindingStudent!=null){
								Vector<Student> bindedStudent=new ManageStudent().getStudent(allStudent, bindingStudent);
								if(bindedStudent!=null){
									Iterator<Student> iterList=bindedStudent.iterator();%>			

									<%while(iterList.hasNext()){%>
									<% Student s=iterList.next();%>

									
									
																		
									
									<tr align="center">
									          <td width="25%">  <input type="checkbox" name="cancelBindingStudent" value=<%=s.getEmail() %>></td>
												<td width="25%"><%=s.getName() %></td>
												<td width="25%"><%=s.getGender() %></td>
												<td width="25%"><%=s.getEmail() %></td>
												
									</tr>
									
									<% }%>

								</table>
										<button class="btn btn-success">解除绑定</button>
									</form>
							</div>
							<div id="page-link-content">
								<ul class="pagination pagination-sm">
									
								</ul>
							</div>

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
                                 <a href="＃" target="_blank">在线考试系统</a> - <a href="." target="_blank">学生管理</a>
							</p>
						</div>
					</div>
				</div>

			</div>

		</footer>









											
					          <%
	
			}
								else{%>
									<%="系统繁忙，请稍候重试!" %>
									<a href="teacherIndex.jsp">返回主页</a>
									
							
						<%}}
							else{%>
								<%="系统繁忙，请稍候重试!" %>
								<a href="teacherIndex.jsp">返回主页</a>
							<%}
	
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

			}%>
			<a href="teacherIndex.jsp">返回</a>
		<%}
		else {
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