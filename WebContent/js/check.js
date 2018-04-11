	var aSpan=document.getElementsByTagName("span");
	var oInput1=document.getElementById("email1");
	var oInput2=document.getElementById("exampleInputPassword1");
	var oInputName=document.getElementById("input_name");
	var oInputEmail=document.getElementById("email");
	var oInputMobile=document.getElementById("mobile");
	var oInputPassword=document.getElementById("password");

	
	 oInput1.onfocus=function(){
				aSpan[0].innerHTML="请输入邮箱";
	};
	 oInput2.onfocus=function(){
				aSpan[1].innerHTML="请输入密码";
	};
	oInputName.onfocus=function(){
				aSpan[2].innerHTML="请输入用户名";
	};
	oInputEmail.onfocus=function(){
				aSpan[3].innerHTML="请输入邮箱";
	};
	oInputMobile.onfocus=function(){
				aSpan[4].innerHTML="请输入电话";
	};
	oInputPassword.onfocus=function(){
				aSpan[5].innerHTML="请输入密码";
	};
	
	 oInput1.onblur=function(){
				if(oInput1.value == ""){
					aSpan[0].innerHTML="账户不能为空";
				}else if(oInput1.value.length > 60 ||oInput1.value.length < 9){
					aSpan[0].innerHTML="请保持在9-60个字符以内";
				}else if(9<= oInput1.value.length <=60){
				   var email = oInput1.value;    
						//以字母或数字开头，跟上@,字母数字以.com结尾
				   var expr =  /^([0-9]|[a-z])+@([0-9]|[a-z])+(\.[c][o][m])$/i;
				   if(!expr.test(email))
				   {
				 		aSpan[0].innerHTML="输入的邮箱格式有误";
				   }else{
						aSpan[0].innerHTML="";
				   }
				}
	};
	 oInput2.onblur=function(){
				if(oInput2.value == ""){
					aSpan[1].innerHTML="密码不能为空";
				}else{
						aSpan[1].innerHTML="";
				}
	};
	oInputName.onblur=function(){
				if(oInputName.value == ""){
					aSpan[2].innerHTML="用户名不能为空";
				}else{
						aSpan[2].innerHTML="";
				}
	};
	oInputEmail.onblur=function(){
				if(oInputEmail.value == ""){
					aSpan[3].innerHTML="邮箱不能为空";
				}else if(oInputEmail.value.length > 60 ||oInputEmail.value.length < 9){
					aSpan[3].innerHTML="请保持在9-60个字符以内";
				}else if(9<= oInputEmail.value.length <=60){
				   var email = oInputEmail.value;    
						//以字母或数字开头，跟上@,字母数字以.com结尾
				   var expr =  /^([0-9]|[a-z])+@([0-9]|[a-z])+(\.[c][o][m])$/i;
				   if(!expr.test(email))
				   {
				 		aSpan[3].innerHTML="输入的邮箱格式有误";
				   }else{
						aSpan[3].innerHTML="";
				   }
				}
	};
	oInputMobile.onblur=function(){
			   var phone = oInputMobile.value;     
			//匹配到一个非数字字符e 
			   var expr =  /\D/i;
			   if(expr.test(phone))
			   {
				   aSpan[4].innerHTML="不能输入非数字字符";
			   }else if(oInputMobile.value == ""){
					aSpan[4].innerHTML="电话不能为空";
				}else{
				   aSpan[4].innerHTML="";
				}
	};
	oInputPassword.onblur=function(){
			if(oInputPassword.value == ""){
					aSpan[5].innerHTML="密码不能为空";
				}else{
						aSpan[5].innerHTML="";
			}
	};