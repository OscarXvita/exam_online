<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.system.service.*"%>
<%@page import="java.util.*"%>
<%@page import="com.system.entity.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
	if (!session.isNew()) {
		if (session.getAttribute("student")==null){
%>
<%
	out.println("会话过期或者未登录，请重新登录");
%>
<%
	} else {
%>
<%
	String type = (String) session.getAttribute("type");
			Student s = (Student) session.getAttribute("student");
			boolean flag = (boolean) session.getAttribute("state");
			if (flag && type.equals("student")) {
				//out.println("欢迎您，" + s.getName() + "学生!");
				List<Teacher> teachers = new ViewTeacherService().getBindedTeachers(s);
				Teacher t = new Teacher();
				if (teachers != null && teachers.size() >= 0) {
					Iterator<Teacher> iterList = teachers.iterator();
%>


<html>
<head>
<!--<base href="http://localhost:8080/Portal/">-->
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>主页</title>
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
.question-number {
	color: #5cb85c;
	font-weight: bolder;
	display: inline-block;
	width: 30px;
	text-align: center;
}

.question-number-2 {
	color: #5bc0de;
	font-weight: bolder;
	display: inline-block;
	width: 30px;
	text-align: center;
}

.question-number-3 {
	color: #d9534f;
	font-weight: bolder;
	display: inline-block;
	width: 30px;
	text-align: center;
}

a.join-practice-btn {
	margin: 0;
	margin-left: 20px;
}

.content ul.question-list-knowledge {
	padding: 8px 20px;
}

.knowledge-title {
	background-color: #EEE;
	padding: 2px 10px;
	margin-bottom: 20px;
	cursor: pointer;
	border: 1px solid #FFF;
	border-radius: 4px;
}

.knowledge-title-name {
	margin-left: 8px;
}

.point-name {
	width: 200px;
	display: inline-block;
}

.col-xs-3 {
	width: 22%;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
	<div class="container">
		<div class="row">
			<div class="col-xs-5">
				<div class="logo">
					<h1>
						<a href="#"> <!-- 此处为logo的图片 --> <img alt=""
							src="../resources/images/logo.png">
						</a>
					</h1>
				</div>
			</div>
			<div class="col-xs-7" id="login-info">



				<!--此处为接口，用来显示相关的用户和退出的信息，暂定用户为kim-->



				<a class="btn btn-primary" href="">欢迎您<%=s.getName()%></a>
				<a class="btn btn-success" href="logout">退出</a>

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
							<a href="Home.jsp"><i class="fa fa-home"></i>主页</a>
						</li>
						<li>
							<a href="Practice.jsp"><i class="fa fa-edit"></i>试题练习</a>
						</li>
						<li>
							<a href="Test.jsp"><i class="fa fa-dashboard"></i>在线考试</a>
						</li>
						<li>
							<a href="@teacher.jsp"><i class="fa fa-cogs"></i>@老师</a>
						</li>
                         <li>
							<a href="BindingTeacher.jsp"><i class="fa fa-dashboard"></i>绑定老师</a>
						</li>
                        <li>
							<a href="Feedback.jsp"><i class="fa fa-dashboard"></i>成绩反馈</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>

	<!-- Navigation bar ends -->

	<!-- Slider starts -->

	<div class="full-slider">
		<!-- Slider (Flex Slider) -->

		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="flexslider">
						<div class="flex-caption">
							<!-- Left column -->
							<div class="col-l">
								<p style="text-indent: 2em;">
									考试是每个学生必须要经历的一件事情，而我们的网站就给你提供了这样的一个平台，在这里你可以随意的进行测试，一旦你绑定了
									你的老师你就可以获得导航栏里面的所有的功能，你可以和老师进行交流，一旦你绑定了这个老师。</p>
								<p style="text-indent: 2em;">
									我们在这个网站上面应用了很多现在说学的知识，包括jsp，java和一些很基础的东西，例如html，js等等。</p>
							</div>
							<!-- Right column -->
							<div class="col-r">

								<!-- Use the class "flex-back" to add background inside flex slider -->

								<!-- <img alt="" src="../resources/images/ad.png"> -->
								<p>如果您对软件有任何反馈和建议，加入我们的QQ群一起讨论吧</p>

								<!-- Button -->
								<a class="btn btn-default btn-cta" href=""><i
									class="fa fa-arrow-circle-down"></i> 马上加入我们吧</a>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="content" style="padding: 30px 0 0 0;">
		<table class="table-striped table">
			<thead>

				<tr>
					<td>公告标题</td>
					<td>公告内容</td>
					<td>上传时间</td>
					<td>上传的老师</td>
					<td></td>
				</tr>
			</thead>
			<tbody>
				<%
	while (iterList.hasNext()) {
						t = iterList.next();
						List<Announce> list = new AnnounceService().getAnnounce(t);
						session.setAttribute("announceList", list);
						//System.out.println("list.size()====="+list.size());
						//	System.out.println("list"+list!=null);
						if (list != null && list.size() > 0) {
							
							Iterator<Announce> iterList2 = list.iterator();
													Announce notice = new Announce();
													int i = 0;
													while (iterList2.hasNext()) {
														notice = iterList2.next();
														i++;
						%>

				<!-- 公告的标题-->
				<tr>
					<td><%=notice.getTitle() %></td>
					<!-- 公告的内容-->
					<td>
					<%
					String content=notice.getContent();
					char[]arr=content.toCharArray();
					char[]arr2=new char[10];
					if(arr.length>10){
						for(int j=0;j<10;j++){
							arr2[j]=arr[j];
						}
						content=String.valueOf(arr2)+"......";
						
					}
					
					
					%>
					<%=content %>
</td>
					<!-- 公告的上传时间-->
					<td><span class="span-info question-number"><%=notice.getTime() %></span></td>
					<!-- 公告的上传-->
					<td><span class="span-success question-number-2"><%=t.getName() %></span></td>
					<td><a href="AnnounceContent.jsp?announceID=<%=notice.getId() %>"
						class="btn btn-success btn-sm join-practice-btn">查看</a></td>
				</tr>

<%} %>
		<%
		}
	%>
		<%
		}
	%>
			</tbody>
			<tfoot></tfoot>
		</table>
		<!-- 此处为公告板 -->

	</div>

	<div class="content"
		style="padding: 30px 0 100px 0; background-color: rgb(246, 249, 250);">

		<div class="content" style="padding: 30px 0 100px 0;">
			<div class="container">

				<div style="margin-top: 20px;">
					<ul class="news-list">

						<li class="news-list-item clearfix"></li>
					</ul>
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
						<a href="＃" target="_blank">在线考试系统的主页</a> - <a href="."
							target="_blank">主页</a>
					</p>
				</div>
			</div>
		</div>

	</div>

	</footer>
	

	<%
		}
	%>
	<%
		}
	%>
	<%
		}
	%>

	<%
		}
	%>
</body>
</html>