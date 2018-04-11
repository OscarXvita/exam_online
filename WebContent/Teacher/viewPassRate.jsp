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
<html>
<head>
<!--<base href="http://localhost:8080/Portal-8/">-->
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
				%>
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



				<a class="btn btn-primary" href="user-register">欢迎您<%=t.getName()%></a>
				<a class="btn btn-success" href="logout">退出</a>

			</div>
		</div>
	</div>
	</header>
<div class="navbar bs-docs-nav" role="banner">
			<div class="container">
				<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
					<ul class="nav navbar-nav">
						<li >
							<a href="teacherIndex.jsp"><i class="fa fa-home"></i>主页</a>
						</li>
						<li>
							<a href="getTeacherAllSpace.jsp"><i class="fa fa-edit"></i>管理题库</a>
						</li>
						<li class="active">
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

	
				<% 
				boolean flag = (boolean) session.getAttribute("state");
				if (flag && type.equals("teacher")) {
					
					String spaceID = request.getParameter("spaceID");
					if (spaceID != null && !spaceID.equals("")) {
						QuestionSpace currentTeacherSpace = new QuestionSpace();
						currentTeacherSpace.setId(Long.parseLong(spaceID));
						ObjectQuestion question = new ObjectQuestion();
						double a = 0.0;
						String correctAnswer = "";
						int i = 0;
						Map<ObjectQuestion, Double> map = new ScoreAnalyzeService()
								.getPassRate(currentTeacherSpace);
						if (map != null) {
	%>
	<table class="table-striped table">
		<thead>
			<tr>
				<td>题号</td>
				<td>题目名称</td>
				<td>分数</td>
				<td>通过率</td>
			</tr>
		</thead>
		<tbody>
			<%
				for (Map.Entry<ObjectQuestion, Double> me : map.entrySet()) {
										question = me.getKey();
										a = me.getValue();
										i++;
										if (question.getCorrectAnswer() == 1) {
											correctAnswer = "A";
										} else if (question.getCorrectAnswer() == 2) {
											correctAnswer = "B";
										} else if (question.getCorrectAnswer() == 3) {
											correctAnswer = "C";
										} else if (question.getCorrectAnswer() == 4) {
											correctAnswer = "D";
										} else {
											correctAnswer = "无";
										}
			%>


			<tr>
				<td><%=i%>
				<td><%
String titile=question.getTitle();
	char[]arr=titile.toCharArray();
	char[]temp=new char[50];
	if(arr.length>50){
		for(int j=0;j<50;j++){
			temp[j]=arr[j];
		}
		titile=String.valueOf(temp);
	}else{
	}

%><%=titile %></td>
				<td><%=question.getScore()%></td>
				
				<td><%=a%></td>
			</tr>

			<%
				}
			%>
			</tbody>
			</table>
			
			
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
			<%
				}
			%>
		
</body>
</html>