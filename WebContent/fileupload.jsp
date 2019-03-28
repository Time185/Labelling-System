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
<link rel="stylesheet" type="text/css" href="Huploadify.css"/>
<link rel="stylesheet" type="text/css" href="webuploader.css" />
<link rel="stylesheet" type="text/css" href="style.css" />
<style>
	.width_auto{
		width: 750px;
        margin: 100px auto;
	}
</style>
<script src="plugin/uploadify/jquery-1.11.3.js" type="text/javascript"></script>
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
    <button id="repalce"  class="upload-button" style="text-align:middle" ">点击检查文件</button>
    <button class="upload-button" id="btn2" >点击上传文件</button>		   	   
</div>

<script type="text/javascript">  
	//用来存放服务器端传过来文件库的数据
	var patientName ;
	var a;
	//用来存放不符合规定的文件条目
    var btn = document.getElementById("repalce");  
    btn.onclick =function(){  
    	$.get("PacientFileNameServlet",function(data,status){
   		 patientName = data;
   		a = patientName;
   		});
    	document.getElementById("file_upload_1-button").click();
    	
    };
</script>
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
    		uploader:'http://10.15.0.10:8080/BB//UploadServlet1?name='+username,
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
    		up.cancel('*');
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
</body>
</html>