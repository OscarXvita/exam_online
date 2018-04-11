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
<title>试题管理</title>

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
						<li class="active">
							<a href="paperManage.jsp"><i class="fa fa-cloud"></i>试题管理</a>
						</li>
						<li>
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
				<%="&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" %>	
					<%="所有题库：" %>
					
					
					
					
					<% 
					List<QuestionSpace> spacelists = new QuestionSpaceService().getQuestionSpaceOfTeacher(t);
					session.setAttribute("SpaceList", spacelists);
					for (int i = 0; i < spacelists.size(); i++) {
	%>

<a href="paperManage.jsp?spaceID=<%=spacelists.get(i).getId()%>"><%="&nbsp&nbsp&nbsp"+spacelists.get(i).getName()%></a>

	
	
	

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
			if(spacelists.get(i).getId()==Long.parseLong(spaceID)){%>
			<br></br>
							<%="&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" %>
			<%="当前题库："+ spacelists.get(i).getName()%>
					<div class="content" style="margin-bottom: 100px;">

			<div class="container" style="margin-top: 40px;">
				
				<div class="row" style="margin-left: 50px;">
					<div class="col-xs-10">
						<div style="border-bottom: 1px solid #ddd;">
							<h3 class="title"><i class="fa fa-cogs"></i> 试题管理</h3>
						</div>	
						<div>

							
							<table class="table-striped table">
								<tr align="center" >
											<td width="25%">题号</td>
											<td width="25%">内容</td>
											<td width="25%">分数</td>
											<td width="25%">操作</td>
								</tr>
		<%	}
		}
		QuestionSpace currentTeacherSpace = new QuestionSpace();
		currentTeacherSpace.setId(Long.parseLong(spaceID));
		Vector<ObjectQuestion> objectQuestionLists = new ObjectQuestionService()
				.getAllQuestionOfSpace(currentTeacherSpace);
		if (objectQuestionLists != null) {
			Iterator<ObjectQuestion> iterList = objectQuestionLists.iterator();
			int i = 0;
			while (iterList.hasNext()) {
				ObjectQuestion o = iterList.next();
				i++;%>

					
								<tr align="center" height="100px">
											<td width="25%" ><%=i %></td>
											<td width="25%" class="question_td" ><a><%String str=o.getTitle();
                           if(str.length()>15){
                           char[]arr=str.toCharArray();
                           char[]temp=new char[15];
                           for(int j=0;j<15;j++){
                        	   temp[j]=arr[j];
                           }
                           str=String.valueOf(temp);
                           out.println(str);
                           }else{
                        	   out.println(str);
                           } %></a></td>
											<td width="25%"><%=o.getScore() %></td>
											
											<td width="25%">
											
											 
												<form method="post" action="modifyQuestion.jsp">
	                                                  <input type="hidden" name="questionID" value=<%=o.getId() %>>
			                                          <input type="hidden" name="questionName" value=<%=o.getTitle() %>>
			  										  <input type="hidden" name="answerA" value=<%=o.getChoiceA() %>>
													  <input type="hidden" name="answerB" value=<%=o.getChoiceB() %>>
													  <input type="hidden" name="answerC" value=<%=o.getChoiceC() %>>
			 										  <input type="hidden" name="answerD"value=<%=o.getChoiceD() %>>
			     									  <input type="hidden" name="correctAnswer" value=<%=o.getCorrectAnswer() %>>
			 										  <input type="hidden" name="answerAnalyze" value=<%=o.getAnswerAnalyze() %>>
			                                          <input type="hidden" name="score" value=<%=o.getScore() %>>
			                                          <button class="change-property btn-sm btn-info"><i class="ace-icon fa fa-pencil bigger-120"></i></button>
	                                              
	                                            </form>
											
											<form method="post" action="delete">
                                             <input type="hidden" name="questionID" value=<%=o.getId() %>>
                                            <button class="delete-question-btn btn-sm btn-danger"><i class="ace-icon fa fa-trash-o bigger-120"></i></button>
                                             </form> 
											</td>
								</tr>
                          <div class="white_content">
                           <%=i%>.<%=o.getTitle()

                           %>
<%="(" + o.getScore() + "分)"%><br /> 选项A:<%=o.getChoiceA()%><br />
选项B:<%=o.getChoiceB()%><br /> 选项C:<%=o.getChoiceC()%><br /> 选项D:<%=o.getChoiceD()%><br />
正确答案：
<%
	int correct = o.getCorrectAnswer();
				switch (correct) {
				case 1:
					out.println("A");
					//out.println("XZXZXXZ");
					break;
				case 2:
					out.println("B");
					break;
				case 3:
					out.println("C");
					break;
				case 4:
					out.println("D");
					break;
				}
				
				
				
			
%>
<br /> 答案解析：<%=o.getAnswerAnalyze()%><br />   <button class="question_btn">关闭</button></div> 		
				<% 
				
				
			}
		}
	
	}
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
                                 <a href="＃" target="_blank">在线考试系统</a> - <a href="." target="_blank">试题管理</a>
							</p>
						</div>
					</div>
				</div>

			</div>

		</footer>
			<script src="resources/js/question.js"></script>
	<% 
	
	
	
	
	
	
	
	
	
	
	
	
	
		} else {
					session.invalidate();
					response.sendRedirect("index.jsp");
				}
	%>
	<%
		}
			%>
			
		<%}
		else{%>
		<%session.invalidate(); %>
		<%="会话过期或者未登录，请重新登录"%>
		<a href="../index.jsp">登录</a>
<% 	}
	%>
</body>
</html>