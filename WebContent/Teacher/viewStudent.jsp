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
<title>查看绑定成功的学生</title>
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
							out.println("欢迎您，" + t.getName() + "教师!");
							Vector<Student> allStudent=new BindingService().getAllStudent(t);
							List<Student> bindingStudent=new BindingService().getApplyStudent(t);
							Vector<Student> allStudents=new ConsultService().getAllStudents();
							if(allStudent!=null&&allStudents!=null&&bindingStudent!=null){
								Vector<Student> bindedStudent=new ManageStudent().getStudent(allStudent, bindingStudent);
								if(bindedStudent!=null){
									Iterator<Student> iterList=bindedStudent.iterator();%>
									<br>点击前面的框解除绑定：<br>
									<form method="post" action="cancelBinding">
									<%while(iterList.hasNext()){%>
									<% Student s=iterList.next();%>
									<input type="checkbox" name="cancelBindingStudent" value=<%=s.getEmail() %>><%=s.getName() %><br>
									<% }%>
									<input type="submit" name="submit" value="解除绑定">
									</form>

											
					          <%Vector<Student> allStudent1=new BindingService().getAllStudent(t);
					          Vector<Student> unBindedStudent=new ManageStudent().getStudent(allStudents, allStudent1);
					          if(unBindedStudent!=null){
									Iterator<Student> iterList2=unBindedStudent.iterator();%>
									<br>未绑定的学生：<br>
									<br>点击前面的框进行绑定：<br>
									<form method="post"  action="teacherBindingStudent">
									<%while(iterList2.hasNext()){%>
										<% Student s2=iterList2.next();%>
										<input type="checkbox" name="acceptStudents" value=<%=s2.getEmail() %>><%=s2.getName() %><br>
									<% }%>
									<input type="submit" name="submit" value="绑定">
									</form>
									<%
								}
								else{%>
									<%="系统繁忙，请稍候重试!" %>
									<a href="teacherIndex.jsp">返回主页</a>
									
									
									
									
									
									
								<%}}
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
	<a href="index.jsp">登录</a>
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
	<a href="index.jsp">登录</a>
	<%
		}
	%>
</body>
</html>