<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆注册</title>
</head>
<body>
<center>
<form method="post" action="login">
用户名：<input type="text" name="username"><br><br/>
密 &nbsp;码：&nbsp; <input type="password" name="password"><br><br/>
<input type="radio" name="identity" value="用户">用户&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="identity" value="教师">教师<br>
<input type="submit" name="submit" value="登录"><br><br/><br/>
<a href="studentRegister.jsp">新用户？现在注册</a><br/>
<a href="teacherRegister.jsp">老师请走绿色通道</a>
</form>

</center>

</body>
</html>