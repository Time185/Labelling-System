<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/jsps/css/user/login.css'/>">
	<script type="text/javascript" src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/jsps/js/user/login.js'/>"></script>
	<script src="<c:url value='/js/common.js'/>"></script>

    <script type="text/javascript">
	$(function() {/*Map<String(Cookie名称),Cookie(Cookie本身)>*/
		// 获取cookie中的用户名
		var loginname = window.decodeURI("${cookie.loginname.value}");
		if("${requestScope.user.loginname}") {
			loginname = "${requestScope.user.loginname}";
		}
		$("#loginname").val(loginname);
	});
   </script>
   <script type="text/javascript">
    //在点击“换一张”时会调用本方法
        function change() {
            $("#vCode").attr("src", "<c:url value='/VerifyCodeServlet?'/>" + new Date().getTime());//指定<img>元素的src属性值为VerifyCodeServlet，并且追加参数为当前时间毫秒，它是不会重复的值，所以浏览器不会使用缓存，而是访问服务器。
        }
    </script>
   
  </head>
  
  <body background="/images/1.jpg" >
	<div class="main">
	  <div><img src="<c:url value='/images/logo.gif'/>" /></div>
	  <div>
	    <div class="imageDiv"><img class="img" src="<c:url value='/images/zj.png'/>"/></div>
        <div class="login1">
	      <div class="login2">
            <div class="loginTopDiv">
              <span class="loginTop">大智慧标注系统会员登录</span>
              <span>
                <a href="<c:url value='/jsps/user/regist.jsp'/>" class="registBtn"></a>
              </span>
            </div>
            <div>
              <form target="_top" action="<c:url value='/UserServlet'/>" method="post" id="loginForm">
                <input type="hidden" name="method" value="login" />
                  <table>
                    <tr>
                      <td width="50"></td>
                      <td><label class="error" id="msg">${msg }</label></td>
                    </tr>
                    <tr>
                      <td width="50">用户名</td>
                      <td><input class="input" type="text" name="loginname" id="loginname"/></td>
                    </tr>
                    <tr>
                      <td height="20">&nbsp;</td>
                      <td><label id="loginnameError" class="error"></label></td>
                    </tr>
                    <tr>
                      <td>密　码</td>
                      <td><input class="input" type="password" name="loginpass" id="loginpass" value="${user.loginpass }"/></td>
                    </tr>
                    <tr>
                      <td height="20">&nbsp;</td>
                      <td><label id="loginpassError" class="error"></label></td>
                    </tr>
                    <tr>
                      <td>验证码</td>
                      <td>
                        <%--
                        <input class="input yzm" type="text" name="verifyCode" id="verifyCode" value="${user.verifyCode }"/>
                        <img id="vCode" src="<c:url value='/VerifyCodeServlet'/>"/>
                        <a id="verifyCode" href="javascript:_change()">换张图</a>
                         --%>
                        <input class="input yzm" type="text" name="verifyCode" id="verifyCode" value="${user.verifyCode }"/>
                        <img id="vCode" src="<c:url value='/VerifyCodeServlet'/>"/>
                        <%-- <input type="submit"  width="100" value="换一张" name="submit" border="10"/>--%>
                        <a id="verifyCode" href="javascript:change()">换一张</a>
                      </td>
                    </tr>
                    <tr>
                      <td height="20px">&nbsp;</td>
                      <td><label id="verifyCodeError" class="error"></label></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td align="left">
                        <input type="submit"  width="100" value="登录" name="submit" border="10"
                              style="background: url('${pageContext.request.contextPath}/images/login.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
                               height:35px;width:100px;color:white;"/>
                        <%--<input type="submit" id="submit" width="100" src="<c:url value='/images/login.gif'/>" class="loginBtn"/> --%>
                      </td>
                    </tr>																				
                 </table>
              </form>
            </div>
          </div>
        </div>
      </div>
	</div>
  </body>
</html>


	