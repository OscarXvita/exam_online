<%@page import="com.system.service.QuestionSpaceService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.system.entity.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>


<link href="../resources/bootstrap/css/bootstrap-huan.css"
	rel="stylesheet">
<link href="../resources/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet">

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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	if (!(session.isNew() || session.getAttribute("student") == null
			|| request.getParameter("teacherID") == null)) {
		//System.out.println("iddididiididid"+request.getParameter("teacherID"));
%>



<body>
	<table class="table-striped table">
		<thead>

			<tr>
				<td>考试的名字</td>
				<td>考试的开始时间</td>
				<td>考试的结束时间</td>
				<td>考试的类型</td>
				<td></td>
			</tr>
		</thead>
		<tbody>
		<%
			long teacherID = Long.valueOf(request.getParameter("teacherID"));
				Teacher reqTeacher = new Teacher();
				reqTeacher.setId(teacherID);
				List<QuestionSpace> spaceList = new QuestionSpaceService().getQuestionSpaceOfTeacher(reqTeacher);
				if (spaceList != null) {
					for (QuestionSpace space : spaceList) {
		%>
		
			<!-- 公告的标题-->
			<tr>
				<td><%=space.getName()%></td>
				<!-- 考试的开始时间-->
				<td><%=space.getBeginTime()%></td>
				<!-- 考试的结束时间-->
				<td><span class="span-info question-number"><%=space.getEndTime()%></span></td>
				<!-- 考试的类型-->
				<td><span class="span-success question-number-2"><%=space.getType()%></span></td>
				<!-- 开始考试的按钮,以post方法传递参数 -->
				<td>
				<form action="Exam.jsp" method="post">
				<input type="hidden" name="type" value="pr">
				<input type="hidden" name="spaceID" value=<%=space.getId() %>>
				<input type="hidden" name="spaceName" value=<%=space.getName() %>>
				<input type="hidden" name="type" value=<%=space.getType() %>>
				<input type="hidden" name="beginTime" value=<%=space.getBeginTime() %>>
				<input type="hidden" name="endTime" value=<%=space.getEndTime() %>>
				<input type="hidden" name="amount" value=<%=space.getAmount() %>>
				<button  class="btn btn-success btn-sm join-practice-btn" type="submit">开始测试</button>
				</form>
				</td>
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
</body>

<%
	}
%>
</html>