<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>DICOM Web Viewer</title>
<meta charset="UTF-8">
<meta name="description" content="Medical viewer using DWV (DICOM Web Viewer) and jQery Mobile.">
<meta name="keywords" content="DICOM,HTML5,JavaScript,medical,imaging,DWV">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="theme-color" content="#2F3BA2"/>
<link rel="manifest" href="resources/manifest.json">
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="ext/jquery-mobile/jquery.mobile-1.4.5.min.css" />
<link type="text/css" rel="stylesheet" href="node_modules/nprogress/nprogress.css" />
<style type="text/css" >
.ui-popup .ui-controlgroup { background-color: #252525; }
.colourLi > .ui-input-text { text-align: center; }
.colourLi > .ui-input-text input { min-height: 2em; width: 7em; display:inline-block }
.lwColourLi > .ui-input-text { text-align: center; }
.lwColourLi > .ui-input-text input { min-height: 2em; width: 7em; display:inline-block }
.ffColourLi > .ui-input-text { text-align: center; }
.ffColourLi > .ui-input-text input { min-height: 2em; width: 7em; display:inline-block }
/* jquery-mobile strip not visible enough */
.table-stripe tbody tr:nth-child(odd) td,
.table-stripe tbody tr:nth-child(odd) th {
  background-color: #eeeeee; /* non-RGBA fallback  */
  background-color: rgba(0,0,0,0.1);
}
</style>
<!-- mobile web app -->
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="Wed, 26 Feb 2008 08:21:57 GMT">
<meta name="mobile-web-app-capable" content="yes" />
<link rel="shortcut icon" sizes="16x16" href="resources/icons/dwv-16.png" />
<link rel="shortcut icon" sizes="32x32" href="resources/icons/dwv-32.png" />
<link rel="shortcut icon" sizes="64x64" href="resources/icons/dwv-64.png" />
<link rel="shortcut icon" sizes="128x128" href="resources/icons/dwv-128.png" />
<link rel="shortcut icon" sizes="256x256" href="resources/icons/dwv-256.png" />
<!-- apple specific -->
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<link rel="apple-touch-icon" sizes="16x16" href="resources/icons/dwv-16.png" />
<link rel="apple-touch-icon" sizes="32x32" href="resources/icons/dwv-32.png" />
<link rel="apple-touch-icon" sizes="64x64" href="resources/icons/dwv-64.png" />
<link rel="apple-touch-icon" sizes="128x128" href="resources/icons/dwv-128.png" />
<link rel="apple-touch-icon" sizes="256x256" href="resources/icons/dwv-256.png" />
<!-- Third party (dwv) -->
<script type="text/javascript" src="node_modules/i18next/i18next.min.js"></script>
<script type="text/javascript" src="node_modules/i18next-xhr-backend/i18nextXHRBackend.min.js"></script>
<script type="text/javascript" src="node_modules/i18next-browser-languagedetector/i18nextBrowserLanguageDetector.min.js"></script>
<script type="text/javascript" src="node_modules/jszip/dist/jszip.min.js"></script>
<script type="text/javascript" src="node_modules/konva/konva.min.js"></script>
<script type="text/javascript" src="node_modules/magic-wand-js/js/magic-wand-min.js"></script>
<!-- Third party (viewer) -->
<script type="text/javascript" src="node_modules/jquery/dist/jquery.min.js"></script>
<script type="text/javascript" src="ext/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="node_modules/nprogress/nprogress.js"></script>
<script type="text/javascript" src="ext/flot/jquery.flot.min.js"></script>
<!-- decoders -->
<script type="text/javascript" src="node_modules/dwv/decoders/pdfjs/jpx.js"></script>
<script type="text/javascript" src="node_modules/dwv/decoders/pdfjs/util.js"></script>
<script type="text/javascript" src="node_modules/dwv/decoders/pdfjs/arithmetic_decoder.js"></script>
<script type="text/javascript" src="node_modules/dwv/decoders/pdfjs/jpg.js"></script>
<script type="text/javascript" src="node_modules/dwv/decoders/rii-mango/lossless-min.js"></script>
<!-- dwv -->
<script type="text/javascript" src="node_modules/dwv/dist/dwv.js"></script>

<!-- Launch the app -->
<script type="text/javascript" >
      //The location of state.json and uploadServlet
            var needStoreIf=0;
      var loadImageIf=0;
      var lastlabel="";
      var loadlabel=0;
      var sliceNow=-1;
      var jsontostore =[];
      var commentsList=[];
      
      var loadErrorForCannotOk="请耐心等待界面顶端蓝色进度条加载完毕，如两分钟还未加载完毕，请返回选择其他文件夹进行标注";
      var sliceChangeIf=0;
      var alertOnlyOnce=0;
      var loadReady=0;
      var readyApp;
      var realDicomNumber=0;
      var random = Math.random().toString();
      var loadIf ="<%=session.getAttribute("loadIf")%>";
      if (loadIf=="1"){
    	  loadIf=1;
      }else{
    	  loadIf=0;
      }
      //var loadIf= 1;
      var jsonUrl="<%=session.getAttribute("jsonPath")%>"+"|"+random;
      var commentsJsonUrl="<%=session.getAttribute("commentsJsonPath")%>"+"|"+random;
      <%System.out.println(session.getAttribute("jsonPath")+"-----------index");%>
      var uploadServletUrl="http://10.15.0.10:8080/BB/UploadServlet";
      var dicomList=["http://10.15.0.10:8080/BB/2/1.dcm"
    	  ];
      var   dicomList=new Array();
      <% 
      String[] res=(String[])session.getAttribute("resPATH");
      System.out.println(res.length);
      %>
     <%   for(int i=0;i <res.length;i++){   %>

          dicomList[ <%=i%> ]= "<%=res[i]%>";
    <%   }   %>
    <% String name="";
    System.out.println("res[0]"+res[0]);
    String[] nameArray=res[0].split("test");
    String[] name1=(String[])nameArray[1].split("/");
    for(int i=2;i<name1.length-1;i++)
  	  {
  	  name=name+name1[i]+">>"; 
  	  }%>
  	var name="当前位置 : " + "<%=name%>";
</script>
<script type="text/javascript" src="src/register-sw.js"></script>
<script type="text/javascript" src="src/appgui.js"></script>
<script type="text/javascript" src="src/applauncher.js"></script>

<script type="text/javascript">

function storeToJson(){
	 needStoreIf=1;
	 loadImageIf=1;
	 loadReady=1;
	 //var lastlabel="";
	 //var loadlabel=1;
	 var comments = document.getElementById("commentsNowSlice");
	 var row1 = {};
	 row1.id= sliceNow;
	 row1.comments =comments.value;
	 var count=0;
	 for (var i=0;i<jsontostore.length;i++)
	 {
		 if (jsontostore[i].id==sliceNow){
			 jsontostore[i].comments=comments.value;
			 count=1;
		 }
	 }
	 if(count==0){
	 jsontostore.push(row1);
	 }
 }
var commentsUrl = commentsJsonUrl.split("|")[0];
$.getJSON(commentsUrl, function(json){
	    $.each(json,function(infoIndex,info){
	        var row1 = {};
	   	    row1.id= info["id"];
	   	    row1.comments =info["comments"];
	   	    jsontostore.push(row1);	  
	      })
})	
</script>
</head>

<body>

<!-- Main page -->
<div data-role="page" data-theme="b" id="main">

<!-- pageHeader #dwvversion -->
<div id="pageHeader" data-role="header" style="height:60px;">
<h1>大智慧医疗在线标注系统 <span class="dwv-version"></span></h1>
<a href="javascript:" onclick="window.location.href='http://10.15.0.10:8080/BB/qiye_admin/HTML_model/index.jsp';" data-icon="carat-l" class="ui-btn-left"
  data-transition="slide" data-i18n="basics.back">back</a>
<a href="#help_page" data-icon="carat-r" class="ui-btn-right"
  data-transition="slide" data-i18n="basics.help">Help</a>
</div><!-- /pageHeader -->
<div align="center" style="display:none;" id="errorPage"><h1 align="center"  
style="color:red ; font-size:50px">请点击左上角返回按键</h1></div>
<!-- DWV -->
<div id="dwv">

<div id="pageMain" data-role="content" style="padding:2px;">

<!-- Toolbar -->
<div class="localtion"></div>
<div class="toolbar" style="float:left;width:10%"  ></div>

<!-- Auth popup -->
<div data-role="popup" id="popupAuth">
<a href="#" data-rel="back" data-role="button" data-icon="delete"
  data-iconpos="notext" class="ui-btn-right" data-i18n="basics.close">Close</a>
<div style="padding:10px 20px;">
<h3 data-i18n="io.GoogleDrive.auth.title">Google Drive Authorization</h3>
<p data-i18n="io.GoogleDrive.auth.body">Please authorize DWV to access your Google Drive.
<br>This is only needed the first time you connect.</p>
<button id="gauth-button" class="ui-btn" data-i18n="io.GoogleDrive.auth.button">Authorize</button>
</div>
</div><!-- /popup -->

<!-- Open popup -->
<div data-role="popup" id="popupOpen">
<a href="#" data-rel="back" data-role="button" data-icon="delete"
  data-iconpos="notext" class="ui-btn-right" data-i18n="basics.close">Close</a>
<div style="padding:10px 20px;">
<h3 data-i18n="basics.open">Open</h3>
<div id="dwv-loaderlist"></div>
</div>
</div><!-- /popup -->
<table border="0" style="margin-left:10px;float:left;">
  <tr>
    <th>当前切片标注信息</th>
  </tr>
  <td><textarea rows="50" cols="30" style="background-color:rgb(101, 103, 105);color:write;" onchange="storeToJson()" id="commentsNowSlice">
Correct!
</textarea></td>
</table>
<!-- Layer Container -->
<div class="layerContainer">
<div class="dropBox"></div>
<canvas class="imageLayer">Only for HTML5 compatible browsers...</canvas>
<div class="drawDiv"></div>
<div class="infoLayer">
<div class="infotl info"></div>
<div class="infotc infoc"></div>
<div class="infotr info"></div>
<div class="infocl infoc"></div>
<div class="infocr infoc"></div>
<div class="infobl info"></div>
<div class="infobc infoc"></div>
<div class="infobr info"></div>
</div><!-- /infoLayer -->
</div><!-- /layerContainer -->

<!-- History -->
<div class="history" title="History" style="display:none;"></div>

</div><!-- /content -->

<div data-role="footer">
<div data-role="navbar" class="toolList">
</div><!-- /navbar -->
</div><!-- /footer -->

</div><!-- /page main -->

</div><!-- /dwv -->

<!-- Tags page -->
<div data-role="page" data-theme="b" id="tags_page">

<div data-role="header">
<a href="#main" data-icon="back" data-transition="slide"
  data-direction="reverse" data-i18n="basics.back">Back</a>
<h1 data-i18n="basics.dicomTags">DICOM Tags</h1>
</div><!-- /header -->

<div data-role="content">
<!-- Tags -->
<div id="dwv-tags" title="Tags"></div>
</div><!-- /content -->

</div><!-- /page tags_page-->

<!-- Draw list page -->
<div data-role="page" data-theme="b" id="drawList_page">

<div data-role="header">
<a href="#main" data-icon="back" data-transition="slide"
  data-direction="reverse" data-i18n="basics.back">Back</a>
<h1 data-i18n="basics.drawList">Draw list</h1>
</div><!-- /header -->

<div data-role="content">
<!-- DrawList -->
<div id="dwv-drawList" title="Draw list"></div>
</div><!-- /content -->

</div><!-- /page draw-list_page-->


<!-- Help page -->
<div data-role="page" data-theme="b" id="help_page">

<div data-role="header">
<a href="#main" data-icon="back" data-transition="slide"
  data-direction="reverse" data-i18n="basics.back">Back</a>
<h1 data-i18n="basics.help">Help</h1>
</div><!-- /header -->

<div data-role="content">
<!-- Help -->
<div id="dwv-help" title="Help"></div>
</div><!-- /content -->

</div><!-- /page help_page-->

</body>
</html>
