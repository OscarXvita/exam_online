<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@page import="com.system.service.*"%>
<%@page import="java.util.*"%>
<%@page import="com.system.entity.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除公告</title>
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
			out.println("欢迎您，" + t.getName() + "教师!");
					String noticeID=request.getParameter("noticeID");
							if(noticeID!=null&&!noticeID.equals("")){
								Announce announce =new Announce();
								announce.setId(Long.parseLong(noticeID));
								boolean a= new AnnounceService().deleteAnnounce(announce);{
									if(a){
										System.out.println("删除成功！");%><br>
										<jsp:forward page="viewOldNotice.jsp"></jsp:forward>
										
									<% }
									else{
										System.out.println("删除失败！");%>
										<jsp:forward page="error.jsp"></jsp:forward>
									<% }
								}
							}
							else{
								System.out.println("系统繁忙，请稍候重试");%>
								<jsp:forward page="error.jsp"></jsp:forward>
								
							<% }
					
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