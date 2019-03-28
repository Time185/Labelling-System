<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页左侧导航</title>
<!-- <link rel="stylesheet" type="text/css" href="css/public.css" />  -->
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/public.js"></script>
</head>

<body bgcolor="BLACK">
	<!-- 左边节点 -->
	<script>
	var log='<%=session.getAttribute("returnUrl")%>';
    function ChangeCss(obj){
    	var alist = document.getElementsByTagName('a');
    	for(var i=0;i<alist.length;i++){
    		alist[i].style.color="green";
    	}
    	obj.style.color="white"
    }
    //if(log=="http://10.15.0.10:8080/BB/fileupload.jsp"){document.getElementById("a2").style.color="white";document.getElementById("a1").style.dispaly="none";}
	</script>
	<div class="container">

		<div >			
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin10.png" />&nbsp;<font color="white">欢迎</font>&nbsp;&nbsp;<font color="white">${sessionScope.sessionUser.loginname }</font>
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><a  
					href="http://10.15.0.10:8080/BB/jsps/test.jsp?param0=000&param1=000&param2=000&param3=000&param4=000&param5=000"
					onclick="ChangeCss(this)"
						target="main"
						style="color:white" id="a1">标注</a>
				</dd>
				<dd>
					<img class="coin11" src="img/coin111.png" /><a  href="http://10.15.0.10:8080/BB/fileupload.jsp"
					onclick="ChangeCss(this)"
						target="main"
						style="color:green" id="a2">上传</a>
				</dd>
				<dd>
					<img class="coin11" src="img/coin111.png" /><a  href="http://10.15.0.10:8080/BB/fileupload01.jsp"
					onclick="ChangeCss(this)"
						target="main"
						style="color:green" id="a2">诊断</a>
				</dd>
				<dd>
					<img class="coin11" src="img/coin111.png" /><a  href="javascript:parent.window.location.href='../../jsps/user/loginx.jsp'"
					onclick="ChangeCss(this)"
						target="_parent"
						style="color:green">退出</a>
				</dd>
			</dl>
		</div>

	</div>
</body>
</html>
