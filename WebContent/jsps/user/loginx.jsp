<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%session = request.getSession();
session.invalidate();
session=request.getSession(); %>

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
  
  <body style="height: 100%;">
  <div  class="main1" id="main">
        <div class="login1">
	      <div class="login2">
            <div class="loginTopDiv">
              <span class="loginTop">会员登录</span>
            </div>
            <hr class="thickLine" noshade="noshade">
            <hr class="thinLine" >
<!--               <span> -->
<%--                 <a href="<c:url value='/jsps/user/regist.jsp'/>" class="registBtn"></a> --%>
<!--               </span> -->
            <div>
              <form target="_top" action="<c:url value='/UserServlet'/>" method="post" id="loginForm">
                <input type="hidden" name="method" value="login" />
  <table>
                    <tr>
                      <td width="50"></td>
                      <td><label class="error" id="msg">${errors.msg} ${msg }</label></td>
                    </tr>
                    <tr>
                      <td width="50"></td>
                      <td><input class="userInput" type="text" name="loginname" id="loginname" placeholder="请输入用户名" value="${form.loginname }"/></td>
                      <td class="tdError"><label class="errorClass" id="loginnameError">${errors.loginname }</label></td>
                    </tr>
                    <tr>
                      <td height="20">&nbsp;</td>
                      <td><label id="loginnameError" class="error"></label></td>
                    </tr>
                    <tr>
                      <td width="50"></td>
                      <td><input class="passwordInput" type="password" name="loginpass" id="loginpass" value="${user.loginpass}" placeholder="请输入密码"/></td>
                      <td><label class="errorClass" id="reloginpassError">${errors.loginpass}</label></td>
                    </tr>
                    <tr>
                      <td height="20">&nbsp;</td>
                      <td><label id="loginpassError" class="error"></label></td>
                    </tr>
                    <tr>
                      <td width="50"></td>
                      <td>
                        <input class="yzm" type="text" name="verifyCode" id="verifyCode" value="${user.verifyCode }" placeholder="请输入验证码"/>
                        
                        <img id="vCode" src="<c:url value='/VerifyCodeServlet'/>"/>
                        <%-- <input type="submit"  width="100" value="换一张" name="submit" border="10"/>--%>
                        <a class="refresh" href="javascript:change()">
                        <img class="refresh" src="refresh2.png" height="25" width="25" alt="刷新"/>
                        </a>
                      </td>
                       <td><label class="errorClass" id="verifyCodeError">${errors.verifyCode}</label></td>
                    </tr>
                    <tr>
                      <td height="20px">&nbsp;</td>
                      <td><label id="verifyCodeError" class="error"></label></td>
                    </tr>
                    <tr>
					  <td width="50"></td>
					  <td>
						<input type="checkbox" checked="checked">
						<span>记住我</span>
					  </td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td align="left">
                        <input type="submit"  width="200" value="立  即  登  录" name="submit" border="10"
                              style="height:35px;width:250px;color:white; border-radius: 10px;  background-color: #2fa83f"/>
                        <%--<input type="submit" id="submit" width="100" src="<c:url value='/images/login.gif'/>" class="loginBtn"/> --%>
                      </td>
                    </tr>																				
                 </table>
              </form>
            </div>
          </div>
        </div>
      </div>
  </body>
</html>


	