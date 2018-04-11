<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <%@page import="com.system.service.*"%>
<%@page import="java.util.*"%>
<%@page import="com.system.entity.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<head>
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
			.question_btn{
			}
			.question_td{
			}
			
			 .white_content { 
            display: none; 
            position: absolute; 
            top: 100px; 
            left: 15%; 
            width: 700px; 
            height: 200px; 
            padding: 5px; 
            border: 3px solid #5E42BD; 
            background-color: white; 
            z-index:5000; 
            overflow: auto;
		}
		</style>

<title>查看公告</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
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
	
		
			<li  class="active">
				<a href="viewOldNotice.jsp" title="查看历史公告"><i class="fa fa-volume-up">&nbsp</i><span class="left-menu-item-name"> 查看历史公告</span></a>
			</li>
		
		
	
		
			<li>
				<a href="addNotice.jsp" title="发布新公告"><i class="fa fa-plus-square">&nbsp</i><span class="left-menu-item-name"> 发布新公告</span></a>
			</li>
		
</ul>	
</div>
					<div class="col-xs-10">
						<div style="border-bottom: 1px solid #ddd;">
							<h3 class="title"><i class="fa fa-dashboard"></i> 公告管理</h3>
						</div>	
						<div>
							<table class="table-striped table">
								
								<tr align="center">
											<td width="20%">公告名称</td>
											<td width="20%">具体内容</td>
											<td width="20%">发布时间</td>
											<td width="20%">编辑公告</td>
											<td width="20%">删除公告</td>
								</tr>

<% 
							List<Announce> list=new AnnounceService().getAnnounce(t);
							int i=0;
							Announce notice=new Announce();
							if(list!=null){%>
							<% 
							Iterator<Announce> iterList=list.iterator();
							while(iterList.hasNext()){%>
								<%notice=iterList.next();
								i++;%>
							    <tr align="center">
											<td width="20%"><%=notice.getTitle() %></td>
											<td width="20%"  class="question_td"><a>点击查看</a></td>
											<td width="20%"><%=notice.getTime() %></td>
											<td width="20%">编辑公告</td>
											<td width="20%">
	    	 <form method="post" action="deleteNotice.jsp">
			<input type="hidden" name="noticeID" value=<%=notice.getId() %>>
			<button class="btn btn-success">删除</button>
			</form>
											
				</td>
								</tr>
								 <div class="white_content">
								 <%=notice.getContent() %>
								 <br>
								 <button class="question_btn">关闭</button>
								</div>

								
								
							<% }
							%>
				</table>
						
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
					
							else{%>
								<%="系统繁忙，请稍候重试" %>
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

			}%>
			<a href="notice.jsp">返回</a>
		<% } else {
	%>
	<%
		session.invalidate();
	%>
	<%="会话过期或者未登录，请重新登录"%>
	<a href="../index.jsp">登录</a>
	<%
		}
	%>
	
			<script src="resources/js/question.js"></script>

</body>
</html>