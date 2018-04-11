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


<%
	if(!(session.isNew()||session.getAttribute("student")==null||request.getParameter("spaceID")==null)){
		Student student=(Student)session.getAttribute("student");
		QuestionSpace space=new QuestionSpace();
		space.setId(Long.parseLong(request.getParameter("spaceID")));
		space.setName(request.getParameter("spaceName"));
		space.setAmount(Integer.parseInt(request.getParameter("amount")));
		space.setType(request.getParameter("type"));
		space.setBeginTime(request.getParameter("beginTime"));
		space.setEndTime(request.getParameter("endTime"));
		Test testInstance = new Test();
		com.system.util.TimeUtil ti = new com.system.util.TimeUtil();
		String testTime = ti.getTime();
		java.sql.Date myTestTime=ti.parseStringToDate(testTime);
		testInstance.setTestTime(testTime);
		testInstance.setExam(false);
		String type=request.getParameter("type");
		//System.out.println("type"+type);
		if(type.equals("ex")){
			//System.out.println("exam");
			testInstance.setExam(true);
			
		}
		long testID = new TestService().beginTest(testInstance, space, student);//准备开始考试，向服务器发送请求，返回考号
		testInstance.setTestID(testID);
	
	
		if(testID!=-1L){
%>
<head>
<meta charset="utf-8" />

<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>ExamStack</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="apple-mobile-web-app-capable" content="yes">
<link rel="shortcut icon"
	href="http://www.examstack.com:8080/Portal-2.0.0/resources/images/favicon.ico" />
<link href="../resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
<link href="../resources/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="../resources/css/exam.css" rel="stylesheet" type="text/css">
<link href="../resources/css/style.css" rel="stylesheet">
<style type="text/css">
input[type="radio"] {
	font-size: 100px;
}
</style>
<title><%=space.getName() %></title>
</head>
<body>
		<header>
			<div class="container">
				<div class="row">
					<div class="col-xs-5">
						<div class="logo">
							<h1><a href="#"><img alt="" src="resources/images/logo.png"></a></h1>
						</div>
					</div>
					<div class="col-xs-7" id="login-info">
					
						
							<div id="login-info-user">
								
								<a  id="system-info-account" target="_blank">考试中-<%=student.getName() %></a>
								<span>|</span>
								<a href="logout"><i class="fa fa-sign-out"></i> 退出考试</a>
							</div>
						
						
					
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
							<a href="Home.jsp"><i class="fa fa-home"></i>主页</a>
						</li>
						<li>
							<a href="Practice.jsp"><i class="fa fa-edit"></i>试题练习</a>
						</li>
						<li class="active">
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

		<div class="content" style="margin-bottom: 100px;">

			<div class="container">
				<div class="row">
				
					<div class="col-xs-2" style="padding-right: 0px;padding-bottom:15px;">
						<div class="def-bk" id="bk-exam-control">

							<div class="def-bk-content" id="exam-control">

								<div id="question-time" class="question-time-normal">
									<div style="height:140px;text-align: center;">
										<i id="time-icon" class="fa fa-clock-o"> </i>
									</div>

									  <div>
									    <span id="t_h">00时</span>
									    <span id="t_m">00分</span>
									    <span id="t_s">00秒</span>
									  </div>
									<script>
										var end;
									  	var EndTime= new Date();
										end = EndTime.getTime()+60*60*1000;
									  function GetRTime(){   
									    var NowTime = new Date();
									    var t =end - NowTime.getTime();
									    var h=0;
									    var m=0;
									    var s=0;
									    if(t>=0){
									      h=Math.floor(t/1000/60/60%24);
									      m=Math.floor(t/1000/60%60);
									      s=Math.floor(t/1000%60);
									    }
									 
									    document.getElementById("t_h").innerHTML = h + "时";
									    document.getElementById("t_m").innerHTML = m + "分";
									    document.getElementById("t_s").innerHTML = s + "秒";
									  }
									  setInterval(GetRTime,0);
									</script>

								</div>
								
								<div id="exam-info" style="display:none;">
									<span id="answer-hashcode"></span>
								</div>
							</div>

						</div>

					</div>
					<div class="col-xs-10" style="padding-right: 0px;">
						<div class="def-bk" id="bk-exampaper">

							<div class="expand-bk-content" id="bk-conent-exampaper">
								<div id="exampaper-header">
									<div id="exampaper-title">
										<i class="fa fa-send"></i>
										<span id="exampaper-title-name"> <%=space.getName() %> </span>
										<span style="display:none;" id="exampaper-id">1</span>
									</div>
									<div id="exampaper-desc-container">
										<div id="exampaper-desc" class="exampaper-filter">
										
										</div>
									</div>
									
								</div>
								<!-- 这些不知道是什么鬼 -->
								<input type="hidden" id="start-time" value="">
								<input type="hidden" id="hist-id" value="71">
								<input type="hidden" id="paper-id" value="7">
								<input type="hidden" id="exam-id" value="14">
								<!-- 这些不知道是什么鬼END -->
								<!-- 好像试题的显示从这里开始 -->
								<form class="question-body" action="handInPaper" method="post">
								<%
								Vector<ObjectQuestion>questionVector=new ObjectQuestionService().getAllQuestionOfSpace(space);
								if(questionVector!=null&&questionVector.size()>=space.getAmount()&&questionVector.size()>0&&space.getAmount()>0){
									//获取不同的随机数
									//System.out.println("amountamount"+space.getAmount());
								//	System.out.println("vectorsizevectorsize"+questionVector.size());
									List<Integer>rdmList=new RandomManage().getRandom(space.getAmount(), questionVector.size());
								
									if(rdmList!=null){
										//将题目内容加入这个list中
										List<ObjectQuestion>questionList=new ArrayList<ObjectQuestion>();
										List<Long>idList=new ArrayList<Long>();
										
										for(int rdm:rdmList){
											questionList.add(questionVector.get(rdm-1));
											idList.add(questionVector.get(rdm-1).getId());
										}
										//准备循环插入题目:
										
										Iterator<ObjectQuestion>iter=questionList.iterator();
										int counter=0;
										while(iter.hasNext()){
											counter++;
											ObjectQuestion tempQestion =iter.next();
								%>
								<ul id="exampaper-body">
									<li class="question qt-singlechoice">
										<div class="question-title">
											<div class="question-title-icon"></div>
											<span class="question-no"><%=counter %></span>
											<span class="question-type" style="display: none;">singlechoice</span>
											<span class="knowledge-point-id" style="display: none;">0</span>
											<span class="question-type-id" style="display: none;">1</span>
											<span>[单选题]</span>
											<span class="question-point-content">
											<span>(</span>
											<span class="question-point"><%=tempQestion.getScore() %></span>
											<span>分)</span></span>
											<span class="question-id" style="display:none;">70</span>
										</div>
										
											<p class="question-body-text"><%=tempQestion.getTitle() %></p>
											<ul class="question-opt-list">
												<li class="question-list-item"><input type="radio" value="1" name=<%=tempQestion.getId() %> class="question-input">A: <%=tempQestion.getChoiceA() %></li>
												<li class="question-list-item"><input type="radio" value="2" name=<%=tempQestion.getId() %> class="question-input">B: <%=tempQestion.getChoiceB() %></li>
												<li class="question-list-item"><input type="radio" value="3" name=<%=tempQestion.getId() %> class="question-input">C: <%=tempQestion.getChoiceC() %></li>
												<li class="question-list-item"><input type="radio" value="4" name=<%=tempQestion.getId() %> class="question-input">D: <%=tempQestion.getChoiceD() %></li>
												
											</ul>
										
									</li>
								</ul>
								<%}//System.out.println("error1") ;%>
								
							
								
								
								
								<div id="question-submit">
									<button class="btn-success btn" style="width:100%;" type="submit">
										我要交卷
									</button>
								</div>
								<!-- 隐藏ID的提交处 -->
								<input 	type="hidden" name="spaceID" value=<%=space.getId() %>>
								<input  type="hidden" name="studentID" value=<%=student.getId() %>>
								<input 	type="hidden" name="testID"	value=<%=testInstance.getTestID() %>>
								<%String idStr=new RandomManage().encoding(idList); %>
								<input  type="hidden" name="idStr" value=<%=idStr %>>
								<input type="hidden"  name="isExam" value=<%=testInstance.isExam() %>>
								<%} //System.out.println("error3") ;%>
								<%} //System.out.println("error2") ;%>
								</form>
								<div id="exampaper-footer">
									<div id="question-navi">
										<div id="question-navi-controller">
											<i class="fa fa-arrow-circle-down"></i>
											<span>答题卡</span>
										</div>
										<div id="question-navi-content">
										</div>
									</div>

								</div>
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
								ExamStack Copyright © <a href="http://www.examstack.com/" target="_blank">ExamStack</a> - <a href="../." target="_blank">主页</a> | <a href="http://www.examstack.com/" target="_blank">关于我们</a> | <a href="http://www.examstack.com/" target="_blank">FAQ</a> | <a href="http://www.examstack.com/" target="_blank">联系我们</a>
							</p>
						</div>
					</div>
				</div>

			</div>

		</footer>

		<!-- Slider Ends -->

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="..resources/js/jquery/jquery-1.9.0.min.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="..resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="..resources/js/all.js?v=0712"></script>
		<script type="text/javascript" src="..resources/js/paper-examing.js"></script>

		

	</body>
<% 
	}
%>
<%	
		}
%>
</html>