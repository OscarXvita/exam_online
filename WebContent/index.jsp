<!--Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在线考试</title>
<link href="css/bootstrap1.css" rel='stylesheet' type='text/css' />
<link href="css/check.css" rel='stylesheet' type='text/css' />
<!-- Custom Theme files -->
<link href="css/style1.css" rel="stylesheet" type="text/css" media="all" />
<!-- Custom Theme files -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery-1.11.0.min.js"></script>
<!-- Custom Theme files -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- Custom Theme files -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Study Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript">
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 


</script>
<!--Google Fonts-->
<!-- start-smoth-scrolling -->
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event) {
			event.preventDefault();
			$('html,body').animate({
				scrollTop : $(this.hash).offset().top
			}, 1000);
		});
	});
</script>
<!-- //end-smoth-scrolling -->
<script src="js/menu_jquery.js"></script>
</head>
<body>
	<!--header start here-->
	<div class="header">
		<div class="container">
			<div class="header-main">
				<!---->
				<div class="header-logo">
					<script>
						$("span.icon").click(function() {
							$(".top-nav ul").slideToggle(500, function() {
							});
						});
					</script>

				</div>

				<div class="clearfix"></div>
			</div>
			<div class="top-menu">
				<ul>

					<li><a href="index.jsp"> <img src="images/lo1.png" alt="">
					</a></li>

					<li><div class="header-login">
							<div class="top-nav-right"></div>
						</div></li>
				</ul>
			</div>
			<!--script-->
			<div class="bann-bottom">
				<h1>在线考试</h1>


				<div class="bann-main">
					<button class="btn btn-primary" data-toggle="modal"
						data-target="#myModal">登录与注册</button>
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">登录／注册</h4>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-md-8"
											style="border-right: 1px dotted #C2C2C2; padding-right: 30px;">
											<!-- Nav tabs -->
											<ul class="nav nav-tabs">
												<li class="active"><a href="#Login" data-toggle="tab">登录</a></li>
												<li><a href="#Registration" data-toggle="tab">注册</a></li>
											</ul>
											<!-- Tab panes -->


										</div>
									</div>
									<div class="tab-content">
										<div class="tab-pane active" id="Login">
											<form method="post" action="login" class="form-horizontal">
												<div class="form-group">
													<label for="email" class="col-sm-2 control-label">
														用户名</label>
													<div class="col-sm-10">
														<table>
															<td width="400px"><input type="text" name="username"
																class="form-control" id="email1" placeholder="用户名" />
															</td>
															<td><span class="span-red"></span></td>
														</table>
													</div>
												</div>

												<div class="form-group">
													<label for="exampleInputPassword1"
														class="col-sm-2 control-label"> 密码</label>
													<div class="col-sm-10">
														<table>
															<tr>
																<td width="400px"><input type="password"
																	name="password" class="form-control"
																	id="exampleInputPassword1" placeholder="密码" /></td>
																	<td><span class="span-red"></span></td>
															</tr>


														</table>
													</div>
												</div>
												<div class="form-group">
													<label for="exampleInputPassword1"
														class="col-sm-2 control-label"> 验证码</label>
													<div class="col-sm-10">
														<table>
														
															<tr>
																<td  width="270px">
																<input type="text" class="form-control" name="checkCode" placeholder="验证码">
																	
																</td>
																<td>
																
																<input type="image"
																		src="<%=request.getContextPath()%>/validate" /><a href="index.jsp">看不清？</a>
																</td>
																
															</tr>
														</table>
													</div>
													<input type="radio" name="identity" value="用户"
														checked="checked">学生
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
														type="radio" name="identity" value="教师">教师<br>
												</div>
												<div class="row">
													<div class="col-sm-2"></div>
													<div class="col-sm-10">
														<button type="submit" class="btn btn-primary btn-sm">
															提交</button>

													</div>
												</div>
											</form>
										</div>
										<div class="tab-pane" id="Registration">
											<form method="post" action="register" class="form-horizontal">
												<div class="form-group">
													<label for="email" class="col-sm-2 control-label">
														用户名</label>
													<div class="col-sm-10">
														<div class="row">
															<div class="col-md-3">
																<select class="form-control" name="type">
																	<option value="teacher">老师</option>
																	<option value="student">学生</option>

																</select>
															</div>
															<div class="col-md-9">
																<table>
																	<td width="240px"><input type="text" name="name"
																		class="form-control" id="input_name" placeholder="用户名" />
																	</td>
																	<td><span class="span-red"></span></td>
																</table>
															</div>
														</div>
													</div>
												</div>
												<div class="form-group">
													<label for="email" class="col-sm-2 control-label">
														邮箱</label>
													<div class="col-sm-10">
														<table>
															<td width="429px"><input type="text" name="email"
																class="form-control" id="email" placeholder="邮箱" /></td>
															<td><span class="span-red"></span></td>
														</table>
													</div>
												</div>
												<div class="form-group">
													<label for="mobile" class="col-sm-2 control-label">
														电话</label>
													<div class="col-sm-10">
														<table>
															<td width="429px"><input type="text" name="phone"
																class="form-control" id="mobile" placeholder="电话" /></td>
															<td><span class="span-red"></span></td>
														</table>
													</div>
												</div>
												<div class="form-group">
													<label for="password" class="col-sm-2 control-label">
														密码</label>
													<div class="col-sm-10">
														<table>
															<td width="429px"><input type="password"
																name="password" class="form-control" id="password"
																placeholder="密码" /></td>
															<td><span class="span-red"></span></td>
														</table>
													</div>
												</div>
												<div class="form-group">
													<label for="exampleInputPassword1"
														class="col-sm-2 control-label"> 验证码</label>
													<div class="col-sm-10">
														<table>
														
															<tr>
																<td  width="270px">
																<input type="text" class="form-control" name="checkCode" placeholder="验证码">
																	
																</td>
																<td>
																<input type="image"
																		src="<%=request.getContextPath()%>/validate" />
																</td>
															</tr>
														</table>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-2"></div>
													<input type="radio" name="sex" value="男" checked="checked">男&nbsp;&nbsp;&nbsp;&nbsp;
													<input type="radio" name="sex" value="女">女<br>
													<div class="col-sm-10">
														<input type="submit" class="btn btn-primary btn-sm" /> <input
															type="reset" class="btn btn-default btn-sm" />

													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<script src="js/check.js"></script>
	<!--header end here-->
	<!--baner-info start here-->

	<!--banner-info end here-->
	<!--testimonal start here-->

	<!--testimonal end here-->
	<!--we work strat her-->

	<!--we work end here-->
	<!--feature start here-->

	<!--services end here-->
	<!--footer start here-->
</body>
</html>