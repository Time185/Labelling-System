<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="cn.itcast.goods.user.domain.User"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.IOException"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="HuploadifyDiagnose.css"/>
<link rel="stylesheet" type="text/css" href="webuploader.css" />
<link rel="stylesheet" type="text/css" href="style.css" />
<style>
	.width_auto{
		width: 750px;
        margin: 100px auto;
	}
</style>
<script type="text/javascript" src="jquery.js"></script>
<script src="plugin/jszip.js"></script>
<script src="plugin/jszip-utils.js"></script>
<script src="jquery.Huploadify.js"></script>
<style type="text/css">
</style>

</head>

<body>
<%!String name1=""; %>
<%
User user = (User) session.getAttribute("sessionUser");
name1 = user.getLoginname();
System.out.println(name1+"--------name1");
session.setAttribute("name",name1);%>
<div class="width_auto">
    <div id="container">
        <!--头部，相册选择和格式选择-->
        <div id="uploader" >
            <div class="item_container">                             
               <div id="" class="queueList" >
                  <div style="position:relative; font:normal 14px/24px 'MicroSoft YaHei';">
                       <p>说明：仅支持.zip压缩文件的上传，每次上传文件个数不超过5个，文件大小不超过800M</p>                  
                  		<div id="dndArea" class="placeholder">
                        	<div id="upload" style="text-align:middle"></div>     					
     					</div>
     			  </div>
     		   </div>
      		</div>
      	</div>  
      </div>
    <button id="repalce"  class="upload-button">诊断材料检查</button>
    <button class="upload-button" id="btn2" >上传诊断材料</button>		   	   
   <a href="http://10.15.0.10:8080/BB/qiye_admin/HTML_model/diagnose.pdf" target="_Blank"> <button class="upload-button" id="btn3" >查看诊断报告</button>	</a>
    <a href="testServlet?filename=123.zip" ><button class="upload-button" id="btn3" >获取诊断文件</button>	</a>
    	   	   
</div>
<script type="text/javascript">  
    var btn = document.getElementById("repalce");  
    btn.onclick =function(){  
    	document.getElementById("file_upload_1-button").click();
    }  
</script> 
</body>
<script type="text/javascript">
var username='<%=name1%>';

$(function(){
	var up = $('#upload').Huploadify({
		auto:false,
		fileTypeExts:'*.zip',
		multi:false,
		fileSizeLimit:5120000,//允许上传的文件大小，单位KB
		showUploadedPercent:true,
		showUploadedSize:true,
		removeTimeout:10000000,
		uploader:'http://10.15.0.10:8080/BB//DignoseServlet?name='+username,
		onUploadStart:function(file){
			console.log(file.name+'开始上传');
		},
		onInit:function(obj){
			console.log('初始化');
			console.log(obj);
		},
		onUploadComplete:function(file){
			console.log(file.name+'上传完成');
		},
		onCancel:function(file){
			
		},
		onClearQueue:function(queueItemCount){
			console.log('有'+queueItemCount+'个文件被删除了');
		},
		onDestroy:function(){
			console.log('destroyed!');
		},
		onSelect:function(files){
	  		
			console.log(files.name+'加入上传队列');
		},
		onQueueComplete:function(queueData){
			console.log('队列中的文件全部上传完成',queueData);
		}
	});

	$('#btn2').click(function(){
		up.upload('*');
	});
	$('#btn3').click(function(){
		
	});
	$('#btn4').click(function(){
		//up.disable();
		up.Huploadify('disable');
	});
	$('#btn5').click(function(){
		up.ennable();
	});
	$('#btn6').click(function(){
		up.destroy();
	});
});
</script>
</html>