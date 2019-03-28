<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.itheima.utils.HTML_td"%>
<%@page import="com.mysql.cj.util.StringUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.regex.Pattern" %>
<%@page import="java.util.regex.Matcher" %>
<%@page import="java.util.List"%> 
<%@page import="java.util.Arrays"%> 
<%@page import="com.sun.media.jfxmedia.events.NewFrameEvent"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="cn.itcast.goods.user.domain.User"%>
<%@page import="com.itheima.utils.CompratorByLastModified"%>
<%@page import="com.itheima.utils.CompratorByName"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.File"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%!String websit = "http://10.15.0.10:8080/BB/jsps/test.jsp?";%>
<%!int fontSize = 0;%>
<%!int number = 0;%>
<%!String name;%>
<%!File[] filechild = null;//作用是为了统计标注文件 %>
<%!int pictureNum = 0; //用来记录标记文件的个数%>
<%!int noPictureNum = 0; //用来记录未标记文件的个数 %>
<%!int dcmNum = 0; //用来记录未标记dcm文件的个数 %>
<!DOCTYPE html>
<html>
<head>
<title>大智慧标注系统</title>
<style type="text/css">
.pointer{cursor:pointer;}
#top, #bottom {
	clear: both;
	width: 200%;
	height: AUTO;
	padding: 20px 0;
}
</style>
</head>
<style type="text/css">
/* CSS Document */
/*灰白相间*/ 
table tr:nth-child(odd){
background-color: #A9A9A9;
}

table tr:nth-child(even){
background-color: #fff;
}
 
body {
 font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #fff;
 background: #fff;
}
  
#mytable {
 align:"center"
 width: 400px;
 padding: 0;
 margin: 0;
 
}
/*表格标题放置格式*/
caption {
 padding: 0 0 5px 0;
 width: 100px;  
 font: italic 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 text-align: right;
}

td {
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 
 font-size:11px;
 padding: 8px 8px 8px 12px;
 color: black;
}
 td.alt1 {
 border-left: 3px solid #434D43;
 border-top: 0;
 background: white; url(images/bullet2.gif) no-repeat;
 font:  10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: black;
 font-size:18px;
 padding: 6px 20px 6px 20px;
 text-decoration:none;
 text-align:center;
 text-overflow:ellipsis;
 word-break:keep-all;
 white-space:nowrap;
}

 td.alt2 {
 border-left: 3px solid #434D43;
 border-top: 0;
 background: gray; url(images/bullet2.gif) no-repeat;
 font:  10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: black;
 font-size:18px;
 padding: 6px 20px 6px 20px;
 text-decoration:none;
 text-align:center;
 text-overflow:ellipsis;
 word-break:keep-all;
 white-space:nowrap;
}
tr.even{
background-color: darkgrey;
}
 
td.alt {
 border-left: 3px solid #434D43;
 border-top: 0;
 background: #e5e5e5; url(images/bullet2.gif) no-repeat;
 font:  10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: black;
 font-size:18px;
 padding: 6px 30px 6px 30px;
 text-decoration:none;
  text-overflow:ellipsis;
 word-break:keep-all;
 white-space:nowrap;
}

th.spec {
 border-left: 1px solid #C1DAD7;
 border-top: 0;
 background: #fff url(images/bullet1.gif) no-repeat;
 font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
}
 
th.specalt {
 border-left: 1px solid #C1DAD7;
 border-top: 0;
 background: #f5fafa url(images/bullet2.gif) no-repeat;
 font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #797268;
}
/*---------for IE 5.x bug*/
html>body td{ font-size:22px;}
</style>
<body bgcolor="#87CEEB">
<script type="text/javascript" src="./jquery.js"></script> 
<script type="text/javascript">var mytable="mytable1"; </script> 
<script type="text/javascript">
function onSearch(obj){//js函数开始
  setTimeout(function(){//因为是即时查询，需要用setTimeout进行延迟，让值写入到input内，再读取
    var storeId = document.getElementById(mytable);//获取table的id标识
    var rowsLength = storeId.rows.length;//表格总共有多少行
    var key = obj.value;//获取输入框的值
    var searchCol = 1;//要搜索的哪一列，这里是第一列，从0开始数起
    var searchCol1 = 0;
    var eddIf=0;
    for(var i=2;i<rowsLength;i++){//按表的行数进行循环，本例第一行是标题，所以i=1，从第二行开始筛选（从0数起）
      var searchText = storeId.rows[i].cells[searchCol].innerHTML;//取得table行，列的值
      var searchText1 = storeId.rows[i].cells[searchCol].innerHTML;//取得table行，列的值
      if(searchText.match(key)||searchText1.match(key)){//用match函数进行筛选，如果input的值，即变量 key的值为空，返回的是ture，
        storeId.rows[i].style.display='';//显示行操作，
      }else{
        storeId.rows[i].style.display='none';//隐藏行操作
      }
    }
  },200);//200为延时时间
}
</script>

<div style="text-align:center">
		
		
			<%!String parameter[] = { "000", "000", "000", "000", "000", "000" };
			%>
			<%!int i;%>
			<%!String path = "/home/wangning/asd";%>
			<%!String otherDoctor;%>
			<%!int chosenIf=0;%>
			<%!int chosenFlag=0;%>
			<%!String[] chosenName = new String[2];%>
			<%!public ArrayList<String> reName(String fileDir, String name) {
		// TODO Auto-generated method stub
		File oldFile = new File(fileDir);
		ArrayList res =new ArrayList<String>();
		System.out.println("修改前文件名：" + oldFile.getAbsolutePath());
		String rootPath = oldFile.getParent();
		String oldName = oldFile.getName();
		if (!oldName.contains("_")) {
			if (oldFile.isFile()) {
				String lastName = oldName.substring(oldName.length() - 4, oldName.length());
				String dealName = oldName.substring(0, oldName.length() - 4);
				File newFile = new File(rootPath + File.separator + dealName + "_m" + lastName);
				System.out.println("修改后名字：" + newFile.getAbsolutePath());
				if (oldFile.renameTo(newFile)) {
					try{
					copyFile(new File("/home/wangning/rename/"),newFile);
					deleteDir(new File(newFile.getAbsolutePath()+"/rename"));
					}catch(Exception e){
						System.out.println(e);
					}
					System.out.println("修改成功！");
				} else {
					System.out.println("失败！");
				}
			} else if (oldFile.isDirectory()) {
				File newFile = new File(rootPath + File.separator + oldFile.getName() + "_" + name);

				System.out.println("修改后名字：" + newFile.getAbsolutePath());
				res.add(newFile.getAbsolutePath());
				res.add(oldFile.getName() + "_" + name);
				if (oldFile.renameTo(newFile)) {
					try{
						copyFile(new File("/home/wangning/rename/"),newFile);
						deleteDir(new File(newFile.getAbsolutePath()+"/rename"));
						}catch(Exception e){
							System.out.println(e);
						}
					System.out.println("修改成功！");
				} else {
					System.out.println("失败！");
				}
			}

		} else {
			System.out.println("此项不需要修改");
		}
		return res;
	}%>
			<%
			response.setContentType("text/html;charset=UTF-8");
			//request.setCharacterEncoding("UTF-8");
			//table的序号
			int index=0;
			int labeled=0;
				User user;
				//File noMarkFile;
				user = (User) session.getAttribute("sessionUser");
				name = user.getLoginname();
				session.setAttribute("name", name);
				System.out.println("失败******！"+session.getAttribute("returnUrl"));
				int x = name.indexOf("_");
				String thisHospital = name.substring(0, x);
				String thisDoctor = name.substring(x + 1, name.length());
				//System.out.println(thisHospital);
				path = path + "/" + thisHospital;
				System.out.println("失败！"+path);
			//delete contains chinese file	
			/*final String deleteChineseString = "/home/wangning/asd" + "/" + thisHospital;
			System.out.println(deleteChineseString + "deleteChineseString+++++++++++++++++++");
			File deleteChineseName = new File(deleteChineseString);
			File[] deleteChinese = deleteChineseName.listFiles();
			Pattern pattern = Pattern.compile("[\u4e00-\u9fa5]");
			for(File fileDelete : deleteChinese){
				Matcher m = pattern.matcher(fileDelete.getAbsolutePath());
				if(m.find()){
					deleteDir(fileDelete);
				}else{
					continue;
				}
				
			}*/
			    String returnUrl= "http://10.15.0.10:8080/BB/jsps/test.jsp?";
			    String returnUrl1=returnUrl;
			    String para5="000";
				for (i = 0; i <= 5; i++) {
					//parameter[i] = URLDecoder.decode(request.getParameter("param" + i), "UTF-8");
					parameter[i] = request.getParameter("param" + i);
					if ("000".equals(parameter[i]))
						break;
					if(i==5) para5=parameter[i];
					if(i>0){
					returnUrl=returnUrl+"param"+(i-1)+"="+ URLEncoder.encode(parameter[i-1],"UTF-8")+"&";}
					returnUrl1=returnUrl1+"param"+i+"="+parameter[i]+"&";
					System.out.println("********************"+parameter[i]+"uiuiuiuiuiuiui00000000000");
					path = path + "/" + parameter[i];
					System.out.println(path +"-----              i------------"+i);
				}
				int backLayer=i;
				if(backLayer>0){
				for(int k=backLayer-1;k<5;k++){
					returnUrl=returnUrl+"param"+k+"=000&";
				}
				for(int k=backLayer;k<5;k++){
					returnUrl1=returnUrl1+"param"+k+"=000&";
				}
				returnUrl=returnUrl+"param5=000";
				returnUrl1=returnUrl1+"param5="+para5;
				}else returnUrl=" http://10.15.0.10:8080/BB/jsps/test.jsp?param0=000&param1=000&param2=000&param3=000&param4=000&param5=000";
				session.setAttribute("returnUrl",returnUrl); 
				session.setAttribute("backPath",path); 
				System.out.println(returnUrl+"**************************************");
				backLayer=0;
				String returnUrl2=returnUrl;
				returnUrl="";
				String asdHospital = "/home/wangning/asd" + "/" + thisHospital;		
				File uploadDir = new File(path);
		        if (!uploadDir.exists()) {
		        	System.out.println( "------path---uploadDir.exists()----");
		        	response.sendRedirect("http://10.15.0.10:8080/BB/jsps/test.jsp?param0=000&param1=000&param2=000&param3=000&param4=000&param5=000");	
		        	path=asdHospital;
		        	chosenIf=1;
		        }
		        else if (!(asdHospital.equals(path))) {
					if (!(path.contains("_"))) {
						File tmpChosenFile=new File(path);
						chosenName[0]=tmpChosenFile.getName().toString();
						chosenName[1]=getSequence(tmpChosenFile).toString();
						//chosenIf=2;
						System.out.println(chosenName[0]+ "------chosenName***************-------" +chosenName[1]);
						session.setAttribute("chosenIf",chosenName[0]);
						ArrayList<String> res = reName(path, thisDoctor);
						if (res != null) {
							path = res.get(0);
							parameter[0]=res.get(1);
							response.sendRedirect("http://10.15.0.10:8080/BB/jsps/test.jsp?param0="+chosenName[0]+"_"+thisDoctor+"&param1=000&param2=000&param3=000&param4=000&param5=000");
						}
						tmpChosenFile=null;
						System.out.println(res.toString() + "------path-------" + path);
					}
				}
		        String sessionChosenIf="";
				sessionChosenIf=(String)session.getAttribute("chosenIf");
				System.out.println(sessionChosenIf+"pppppppppppppppppppppppppppppppppppp00000000"+chosenIf);
		        if(sessionChosenIf!=null&&parameter[0].split("_")[0].equals(sessionChosenIf)){
					String tmpPath=asdHospital+"/"+sessionChosenIf+"_"+thisDoctor;
					File tmpChosenFile=new File(tmpPath);
					chosenName[0]=sessionChosenIf;
					chosenName[1]=getSequence(tmpChosenFile).toString();
					chosenIf=2;
					chosenFlag++;
					System.out.println(sessionChosenIf+"pppppppppppchosenFlagmmmmmmmmmmmmmmmmmmmmmmmmmmmmmppppppppppppppppppppppppp11111111"+chosenFlag);
					//session.removeAttribute("chosenIf");
				}
			%>

			<%!File file = null;%>
			<%!String updatePath = "";%>
			<%!File[] childs = null;%>
			<%!int j = 0, m = 0;%>
			<%!String short_name = "0123456789";%>


			<%  
				file = new File(path);
			    try{
				copyFile(new File("/home/wangning/rename/"),file);
				deleteDir(new File(file.getAbsolutePath()+"/rename"));
				}catch(Exception e){
					System.out.println(e);
				}
				childs = file.listFiles();
				System.out.println(childs.length+"*****************************************11111");
				//Arrays.sort(childs,new CompratorByLastModified());
				if(parameter[0].equals("000")){
				Arrays.sort(childs,new CompratorByName());}
				//从工具类获取文件夹有多少文件
				HTML_td dirmsg_map=new HTML_td(childs);
				HashMap numdir_hash=dirmsg_map.getNumDir();
				Map<String,Integer> marknum_hash=dirmsg_map.getMarkNum();
				Map<String,Integer> yesnum_hash=dirmsg_map.getYesNum();
				Map<String,String> timemodify_hash=dirmsg_map.getTime();
				//判断是否为文件
				if(childs!=null&&childs[0].getAbsolutePath().contains(".")){
					String githubRaw = "http://10.15.0.10:8080/test";
					String[] resArray=new String[childs.length];
					String temp="/home/wangning/asd";
					for(int ii=0,jj=0;ii<childs.length;ii++,jj++){
						String absPath=childs[ii].getAbsolutePath();
						if(jj == 0){						
							String resParentPath = absPath.substring(0, (int)(absPath.length() - childs[0].getName().length() - 1));
							System.out.println(resParentPath + "*******************");
							resParentPath = resParentPath + "_mask";
							
							File  tagDicomPath = new File(resParentPath);
							if(tagDicomPath.exists()){
								String jsonPath=resParentPath+File.separator+"state.json";
								String commentsJsonPath = resParentPath+"/comments.json";
								jsonPath=jsonPath.replace(temp,"http://10.15.0.10:8080/test");
								jsonPath=jsonPath.replace("/", "/");
								session.setAttribute("resParentPath",resParentPath);
								System.out.println(jsonPath+"----------------res");
								session.setAttribute("jsonPath",jsonPath);
								commentsJsonPath=commentsJsonPath.replace(temp,"http://10.15.0.10:8080/test");
								commentsJsonPath=commentsJsonPath.replace("/", "/");
								session.setAttribute("commentsJsonPath",commentsJsonPath);
								System.out.println(commentsJsonPath + "****************---------");
								session.setAttribute("loadIf", "1");
							}else{
								String jsonPath=resParentPath+File.separator+"state.json";
								String commentsJsonPath = resParentPath+"/comments.json";
								jsonPath=jsonPath.replace(temp,"http://10.15.0.10:8080/test");
								jsonPath=jsonPath.replace("/", "/");
								session.setAttribute("resParentPath",resParentPath);
								System.out.println(jsonPath+"----------------res");
								session.setAttribute("jsonPath",jsonPath);
								commentsJsonPath=commentsJsonPath.replace(temp,"http://10.15.0.10:8080/test");
								commentsJsonPath=commentsJsonPath.replace("/", "/");
								session.setAttribute("commentsJsonPath",commentsJsonPath);
								session.setAttribute("loadIf", "1");
							}
							
						}
						absPath=absPath.replace(temp, "");
				 	   
						resArray[ii]=githubRaw+absPath.replace("/", "/").trim();
						System.out.println(resArray[ii]+"-----------res"+"**************"+i);
					}
					session.setAttribute("resPATH", resArray);
					//response.sendRedirect("http://10.15.0.10:8080/BB/DWV/index.jsp");
					%>
					<script>
					
					parent.window.location.href='http://10.15.0.10:8080/BB/DWV/index.jsp'
					</script>
					<%
				}
				
				updatePath=path;
				path = "/home/wangning/asd";

				for (j = 0; j <= 5; j++) {

					if ("000".equals(parameter[j])) {
						System.out.println(j+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
						break;
					}
				}
			%>			
			<%
			int flag=0;
			if (parameter[1] == "000"){
				flag=0;
			%>
			<script>mytable="mytable1"; 
			var choosenIf='<%=chosenIf%>';
			if(choosenIf=='1') alert("该患者文件夹已经被其他医生选择"+"\n请重新选择患者文件夹");
			<%
			if(chosenIf==1){
				System.out.println("pppppppppppppppppppppppppppppppppppp"+chosenIf);
				chosenName = new String[2];
				chosenIf=0;}
			%>
			</script>
			<table id="mytable1" cellspacing="0" style="width:100%;">
			<tr><td style="background: rgba(0,0,0,1);color:#fff;text-align:left;" colspan='7'>当前位置>>大智慧医疗标注平台
			<div style="float:right"><img class="icon1" src="sousuo.PNG" /> <div style="float:right"><input style="width:300px;height:20px;" name="key" type="text" id="key" onkeydown="onSearch(this)" placeholder="请输入患者名称">
			</div></div>
			</td></tr>
				<tr >
				<td align="center">序号</td>
				<td align="center">患者名称</td>
				<td align="center">文件夹数</td>
				<td align="center">已标记</td>
				<td align="center">状态</td>
				<td align="center">更新时间</td>
				<td align="center">操作</td>
				</tr><%
			}else{
				flag=1;
				String dirIf="DICOM总数";
				String nameShow="  ";
				System.out.println("*********************"+childs.length);
				if(!(childs!=null&&childs[0].getAbsolutePath().contains(".dcm"))){
					File[] grandChildren=childs[0].listFiles();
					if(!(grandChildren!=null&&grandChildren[0].getAbsolutePath().contains("."))){
					dirIf="文件夹数";
					}
				}
				for(int k=0;k<j;k++){
					String pointer="";
					if(k!=0) pointer=">>";
					nameShow=nameShow+pointer+parameter[k];
				}
				%>
				<script>mytable="mytable2";
				var choosenIf='<%=chosenIf%>';
			    if(choosenIf=='2') alert("您选择了患者文件夹:"+'<%=chosenName[0]%>'+"\n序号是:                      "+'<%=chosenName[1]%>');
				<%
				String sessionChosenIf1="";
				sessionChosenIf1=(String)session.getAttribute("chosenIf");
		        if(chosenIf==chosenFlag){
					chosenIf=0;
					chosenFlag=0;
					session.removeAttribute("chosenIf");
				}
				%>
				</script>
				<table id="mytable2" cellspacing="0" style="width:100%">
				<tr><td style="background: rgba(0,0,0,1);color:#fff;text-align:left;" colspan='7'><%="当前位置>>大智慧医疗标注平台      当前患者名称："+nameShow %>
				<div style="float:right"><img class="icon1" src="sousuo.PNG" /> <div style="float:right"><input style="width:300px;height:20px;" name="key" type="text" id="key" onkeydown="onSearch(this)" placeholder="请输入文件夹名称">
				</div></div>
				</td></tr>
				
				<tr align="center">
				<td >序号</td>
				<td >患者文件夹</td>
				<td ><%=dirIf %></td>
				<td >已标记数</td>
				<td >状态</td>
				<td >更新时间</td>
				<td >操作</td>
				</tr>
				
				<%
			}
				for (i = 0, m = 0; i < childs.length; i++, m++) {
				 if(childs[i].getName().contains("_mask")){					 
				     int flag_=0;
					 String mask=childs[i].getAbsolutePath();
					 String nomask=mask.split("_mask")[0];
					 file = new File(nomask);
					 File[] nomaskchilds = file.listFiles();
					 
					 if(nomaskchilds!=null&&nomaskchilds[0].getAbsolutePath().contains(".")){
						 int numdir_=(int)numdir_hash.getOrDefault(nomask,0);
						 int marknum_=(int)numdir_hash.getOrDefault(nomask+"_mask",0);
						 System.out.println(numdir_+"yesOK"+marknum_); 
						 if(numdir_==(marknum_-1)){
							 System.out.println("yesOK"+marknum_); 
						 
							 File fileYes=new File(nomask+"_yes");
					         File fileMask=new File(mask);
					         if (!fileYes.exists()) {
					        	 System.out.println("yesOK"+marknum_);                              
					        	 fileYes.mkdir();
					        	 childs = file.listFiles();
					        	 copyFile(fileMask,fileYes);
					        	 flag_=1;
					      
						 }				
				         }					 
						 
					 }
					 System.out.println(updatePath+"*********updatePath************2"+childs.length);
					 String upper=mask.split("/"+childs[i].getName())[0]+"_mask";
					 if(!(upper.contains(thisDoctor+"_"))){
					 File fileYes=new File(upper);
			         File fileMask=new File(mask);
			         if (!fileYes.exists()) {                             
			        	 fileYes.mkdir();
			        	 //childs = file.listFiles();
			        	 copyFile(fileMask,fileYes);
			        	 flag_=1;
			         }
			         }
					    if(flag_==1){
					    	file=null;
					         childs=null;
					         file = new File(updatePath);
							    try{
								copyFile(new File("/home/wangning/rename/"),file);
								deleteDir(new File(file.getAbsolutePath()+"/rename"));
								}catch(Exception e){
									System.out.println(e);
								}				    
								childs = file.listFiles();
								if(parameter[0].equals("000")){
									Arrays.sort(childs,new CompratorByName());}
								//从工具类获取文件夹有多少文件
								dirmsg_map=new HTML_td(childs);
								numdir_hash=dirmsg_map.getNumDir();
								marknum_hash=dirmsg_map.getMarkNum();
								yesnum_hash=dirmsg_map.getYesNum();
								timemodify_hash=dirmsg_map.getTime();
								System.out.println(updatePath+"*********updatePath1************"+childs.length);
					    }
						continue;
					} 
					if(childs[i].getName().contains("_yes")){continue;}
                                        if(childs[i].getName().length()>20){continue;}
					if(childs[i].getName().contains(".dcm")){continue;}
					parameter[j]=childs[i].getName();					
										if (m == 0) {
			%>			
				<%
					}
						//System.out.println("i = " + i);
						//第一级目录的判断
						if (parameter[1] == "000") {
							if ((childs[i].getName().contains("_"+thisDoctor))&&(childs[i].getName().split("_")[1].equals(thisDoctor))) {
								//包含_的
								String splitNow="_"+thisDoctor;
								short_name = childs[i].getName().split(splitNow)[0];
				%>
				<% 
				int numdir_=(int)numdir_hash.getOrDefault(childs[i].getAbsolutePath(),0);
				int marknum_=maskFile(childs[i].getAbsolutePath());
				System.out.println(childs[i].getAbsolutePath() + "\\\\\\\\\\\\\\]]]]]]]]]]");
				int yesnum_=yesFile(childs[i].getAbsolutePath());
				numdir_=numdir_-marknum_;
				numdir_=numdir_-yesnum_;
				if(numdir_>0){
				%>
				<tr align="center">
				<td ><%=getSequence(childs[i]) %></td>
				<td ><%=short_name %></td>
				<td ><%=numdir_%></td>
				<td ><%=marknum_%></td>
				<%
				
				String webUrl=websit + "param0=" +URLEncoder.encode(parameter[0], "UTF-8")+ "&" + "param1=" + parameter[1] + "&" + "param2="
						+ parameter[2] + "&" + "param3=" + parameter[3] + "&" + "param4=" + parameter[4] + "&"
						+ "param5=" + parameter[5];
				System.out.println(webUrl+"1111111111111111111111111111111");
				String state=getState2(yesnum_,marknum_,numdir_);
		        String selectedColor="color:black";
		        if(state.equals("标记中")) selectedColor="color:red";
		        else if(state.equals("已标记"))selectedColor="color:green";
				%>
				<td align="center" style="<%=selectedColor %>;"><%=state %></td>
				<td ><%=timemodify_hash.get(childs[i].getAbsolutePath()) %></td>
				<td ><a style="color:#66ff22;text-decoration:none;"
					href=<%=webUrl%>><button class="pointer" style="background-color: green;color: white;width:60px;height:28px"><font >查看</font></button></a>
				</td>
				</tr>
				<%//未标注的第一级目录
				}} else if (!(childs[i].getName().contains("_"))) {
				%>
				<% 
				int numdir_=(int)numdir_hash.getOrDefault(childs[i].getAbsolutePath(),0);
				int marknum_=(int)numdir_hash.getOrDefault(childs[i].getAbsolutePath()+"_mask",0);
				int yesnum_=yesnum_hash.getOrDefault(childs[i].getAbsolutePath(),0);
				numdir_=numdir_-marknum_;
				numdir_=numdir_-yesnum_;
				if(numdir_>0){
				%>
				<tr align="center">
				<td ><%=getSequence(childs[i]) %></td>
				<td ><%=childs[i].getName()%></td>
				<td ><%=numdir_%></td>
				<td ><%=yesnum_%></td>
				<%
				System.out.println(URLEncoder.encode(parameter[0], "UTF-8")+"22222222222222222222222222222");
				String state=getState(numdir_,yesnum_);
		        String selectedColor="color:black";
		        if(state.equals("标记中")) selectedColor="color:red";
		        else if(state.equals("已标记"))selectedColor="color:green";
				%>
				<td align="center" style="<%=selectedColor %>;"><%=state %></td>
				<td ><%=timemodify_hash.get(childs[i].getAbsolutePath()) %></td>
					<td ><a 
					href=<%=websit + "param0=" + URLEncoder.encode(parameter[0], "UTF-8")  + "&" + "param1=" + parameter[1] + "&" + "param2="
								+ parameter[2] + "&" + "param3=" + parameter[3] + "&" + "param4=" + parameter[4] + "&"
								+ "param5=" + parameter[5]%>><button class="pointer" style="background-color: black;color: white;width:60px;height:28px"><font >选择</font></button></a></td>			
					<%
						}
					%>
					
					
					
					</tr><%

				}}else {//从第二级开始的展示结果
								/* if(!childs[i].getName().contains("mask")){ */
					
					int dirNext=1;
					String dirIf="标注";
					if(!(childs!=null&&childs[i].getAbsolutePath().contains("."))){
						File[] grandChildren=childs[i].listFiles();
						if(!(grandChildren!=null&&grandChildren[0].getAbsolutePath().contains("."))){
						dirIf="查看";
						dirNext=0;
						}
					}
					short_name = childs[i].getName();
								if (dirNext==0) {
									short_name = childs[i].getName();
					%>	
					
								<% 
				int numdir_=(int)numdir_hash.getOrDefault(childs[i].getAbsolutePath(),0);
				int marknum_=maskFile(childs[i].getAbsolutePath());
				int yesnum_=yesFile(childs[i].getAbsolutePath());
				System.out.println(short_name+"***************yesnnum********33333333333333333333**************"+yesnum_);
				numdir_=numdir_-marknum_-yesnum_;
				if(numdir_>0){
				%>				
				<tr align="center">
				<td align="center"><%=index++ %></td>
				<td align="center"><%=short_name %></td>
				<td align="center"><%=numdir_ %></td>
				<td align="center"><%=yesnum_ %></td>
				<%
				System.out.println(URLEncoder.encode(parameter[0], "UTF-8")+"33333333333333333333333333333");
				String state=getState2(yesnum_,marknum_,numdir_);
		        String selectedColor="color:black";
		        if(state.equals("标记中")) selectedColor="color:red";
		        else if(state.equals("已标记")){
		        	selectedColor="color:green";
		        	String str=childs[i].getAbsolutePath();
		        	File file = new File(str);
		   		    File[] nomaskchilds = file.listFiles();
	   		        File fileyes=new File(str+"_yes");
		   		    for(File file1:nomaskchilds){	   				 
		   				 if (file1.getName().contains("_yes")) {
		   					 copyFile(file1,fileyes);
		   				 } 				   			 
		        }
		        }
				%>
				<td align="center" style="<%=selectedColor %>;"><%=state %></td>
				<td align="center"><%=timemodify_hash.get(childs[i].getAbsolutePath()) %></td>
				<td align="center"><a style="color:#66ff22;text-decoration:none;"
					href=<%=websit + "param0=" + URLEncoder.encode(parameter[0], "UTF-8")  + "&" + "param1=" + parameter[1] + "&" + "param2="
								+ parameter[2] + "&" + "param3=" + parameter[3] + "&" + "param4=" + parameter[4] + "&"
								+ "param5=" + parameter[5]%>><button class="pointer" style="background-color: green;color: white;width:60px;height:28px"><font >查看</font></button></a>
				</td>
				<%
				}} else {
				%>
								<% 
								System.out.println("childs.length1*******************************************"+childs[i].getAbsolutePath());				
				int numdir_=(int)numdir_hash.getOrDefault(childs[i].getAbsolutePath(),0);
				int marknum_=(int)numdir_hash.getOrDefault(childs[i].getAbsolutePath()+"_mask",0);
				int yesnum_=yesnum_hash.getOrDefault(childs[i].getAbsolutePath(),0);
				String timeShow="";
				if(marknum_>0) { marknum_-=2; timeShow="_mask";}
				if(yesnum_>0)marknum_=numdir_;
				System.out.println("childs.length1*******************************************"+returnUrl);
				System.out.println("3333"+parameter[0] +"3333333"+parameter[1]+"3333333"+parameter[2]+"333333333333*"+
						"******333"+parameter[3]+"3333*******"+numdir_);
				if(numdir_>0){
					System.out.println("childs.length2*******************************************"+childs.length);
				%>
				<td align="center"><%=index++ %></td>
				<td align="center"><%=childs[i].getName()%></td>
				<td align="center"><%=numdir_%></td>
				<td align="center"><%=marknum_%></td>
				<%
				System.out.println(URLEncoder.encode(parameter[0], "UTF-8")+"444444444444444444444444444444444");
				String state=getState(numdir_,marknum_);			
		        String selectedColor="color:black";
		        if(state.equals("标记中")) selectedColor="color:red";
		        else if(state.equals("已标记")){
		        	selectedColor="color:green";
		        }
				%>
				<td align="center" style="<%=selectedColor %>;"><%=state %></td>
				<td align="center"><%=timemodify_hash.get(childs[i].getAbsolutePath()+timeShow) %></td>
				<td align="center"><a style="color:#66ff22;text-decoration:none;"
					href=<%=websit + "param0=" + URLEncoder.encode(parameter[0], "UTF-8") + "&" + "param1=" + parameter[1] + "&" + "param2="
								+ parameter[2] + "&" + "param3=" + parameter[3] + "&" + "param4=" + parameter[4] + "&"
								+ "param5=" + parameter[5]%>><button class="pointer" style="background-color: green;color: white;width:60px;height:28px"><font >标注</font></button></a>
					</td><%} %>
					</tr>
					
					<%
						}
								if (m == 5)
									m = -1;
							}
						}
						m = 0;
						file = null;
						childs = null;
						for (i = 0; i <= 5; i++) {
							parameter[i] = "000";
						}
					%>
					
		</table>
		
		<%
	if (flag==1){%>
	
	            <div style="margin-top:2%">
				<input type="button" class="pointer" style="background-color: green;color: white;width:100px;height:28px" name="Submit" onclick="javascript:window.location.href='<%=returnUrl2 %>'" value="返回上一页">				
				</div>
				<% 
			}%>
		
	</div>
	
	<%!
	public  String getState2(int yesTotal, int maskTotal,int fileTotal) {
		String state="";
		if(maskTotal == 0) {
			state = "未标记";
		}else if(yesTotal==fileTotal) {
			state = "已标记";
		}else  {
			state = "标记中";
		}
		return state;
	}
	public  String getState(int fileTotal, int maskTotal) {
		String state="";
		if(maskTotal == 0) {
			state = "未标记";
		}else if(maskTotal < fileTotal) {
			state = "标记中";
		}else  {
			state = "已标记";
		}
		return state;
	}%>
	<%!public boolean deleteDir(File f) {
		if(!f.exists()) {
			return false;
		}else if(f.isFile()) {
			return f.delete();
		}else {
			for (File file : f.listFiles() ) {
				deleteDir(file);
			}
		}
		return f.delete();
	}
	public static void copyFile(File src,File dest) throws IOException{
		File newFile = new File(dest,src.getName());
		if(!newFile.exists()){
			newFile.mkdirs();
		}
		File[] files = src.listFiles();
		for (File file : files) {

			if(file.isFile()){
				FileInputStream fis = new FileInputStream(file);
				FileOutputStream fos = new FileOutputStream(new File(newFile,file.getName()));
				byte[] b = new byte[1024];
				int len;
				while((len  = fis.read(b)) !=-1){
					fos.write(b, 0, len);
				}
				fos.close();
				fis.close();
			}else if(file.isDirectory()){
				copyFile(file, newFile);
			}
		}
	}%>
	<%!public static Integer yesFile(String yesStr){
		int returnVal=0;
		File newFile = new File(yesStr);
		File[] files = newFile.listFiles();
		for (File file : files) {
             if(file.getName().contains("_yes")) 
            	 returnVal++;			
		}
		return returnVal;
	}%>
	<%!public static Integer maskFile(String yesStr){
		int returnVal=0;
		File newFile = new File(yesStr);
		File[] files = newFile.listFiles();
		for (File file : files) {
             if(file.getName().contains("_mask")) 
            	 returnVal++;			
		}
		return returnVal;
	}%>
	<%!public static String getSequence(File f1){
		String name=f1.getName();
		if(name.contains("_"))name=name.split("_")[0];
		String path1=f1.getAbsolutePath().split("/"+f1.getName())[0];
		String path2=path1+"/maindirforemptydirexceptopn_neverwillbeRegisted";
		File[] notFile=(new File(path2)).listFiles();
		for(int i=0;i<notFile.length;i++){
			String[] tmpName=notFile[i].getName().split("_");
		if(name.equals(tmpName[0])) return tmpName[1];
		}
		return "1000000000000000";
	}%>
</body>
</html>