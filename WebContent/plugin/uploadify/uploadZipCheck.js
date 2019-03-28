   // 用来存放不符合规定的文件条目
	var fileError = new Array();	
	//$("#file").on("change", function(evt) {
	$(document).ready(function(){
	
	$("#file01").on("change" ,function(evt) {
	// 清空之前显示的条目
    $("#result").html("");
    // be sure to show the results
    
    $("#result_block").removeClass("hidden").addClass("show");
    // Closure to capture the file information.
    function handleFile(f) {
        // 压缩包名称
        
    	var $title = $("<h4>", {
            text : f.name
        });
    	
        var $fileContent = $("<h5>");
        $("#result").append($title);
        $("#result").append($fileContent);
        var dateBefore = new Date();
        // 加载zip文件
        JSZip.loadAsync(f)                                   // 1) read the Blob
        .then(function(zip) {
             var dateAfter = new Date();
            $title.append($("<span>", {
                "class": "small",
                text:" (loaded in " + (dateAfter - dateBefore) + "ms)"
            })); 
         	
            zip.forEach(function (relativePath, zipEntry) {  // 2) print entries
            
            // 对文件路径进行切割
            var array = zipEntry.name.split('/');
            var arrayLen = 0;
            for(var i in array){
            	arrayLen++;
            }
            // 包含中文
            //if(/.*[\u4e00-\u9fa5]+.*$/.test(zipEntry.name)){  
            	//$fileContent.append("<p style='color:red'>" + zipEntry.name + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;含有中文，无法上传！" + "</p>");
           // 首先判断文件目录结构正确
           
           if(arrayLen == 2 || arrayLen == 3){
           // 含有一级目录（arrayLen==2）或者二级目录（araryLen==3）或者dcom文件（arrayLen==3）
            	//在这里准备检查重名以及是否含有-
            	if(!(/_/.test(array[0]))){
            		// 检查重名
    	            if(arrayLen == 2){ 
    	           		// 判断二级目录为文件夹，而不是文件    	           		
    	            	if(!((/\./).test(array[arrayLen-1]))){
    	            		
    	            	}else{
    	            		$fileContent.append("<p style='color:red'>" +zipEntry.name + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"' + array[arrayLen-1] +'"不是文件夹，请删除后上传！' + "</p>");
    	            		fileError.push("\n " + zipEntry.name +' " ' + array[arrayLen-1] +' " ' + "不是文件夹，请删除后上传");
    	            	}
    	            	
    	            }
    	            // 判断是dcm文件
    	            if(arrayLen == 3 && /.dcm/.test(array[arrayLen-1])){
    	            	// 三级目录中是否含有中文dcm文件
    	            	//if(/.*[\u4e00-\u9fa5]+.*$/.test(array[arrayLen-1]) || /.*[\u4e00-\u9fa5]+.*$/.test(array[arrayLen-2])){
    	            	if(/.*[\u4e00-\u9fa5]+.*$/.test(array[arrayLen-1])) {
    	            		$fileContent.append("<p style='color:red'>" + zipEntry.name + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + array[arrayLen-1] + "中含有中文名称，请修改后上传！" + "</p>");
    	            		fileError.push("\n " + zipEntry.name + ' " ' + array[arrayLen-1]+ ' " ' + "中含有中文名称，请修改后上传！");
    	            	// 判断二级目录是否含有中文
    	            	}else if(/.*[\u4e00-\u9fa5]+.*$/.test(array[arrayLen-2])){
    	            		$fileContent.append("<p style='color:red'>" + zipEntry.name + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + array[arrayLen-2] + "中含有中文名称，请修改后上传！" + "</p>");
    	            		fileError.push("\n " + zipEntry.name + ' " ' + array[arrayLen-2]+ ' " ' +"中含有中文名称，请修改后上传！");
    	            	// 判断二级目录中含有文件，二级目录必须全部为文件夹
    	            	}else if(arrayLen == 3 && (/\./).test(array[arrayLen-2])){
    	            		$fileContent.append("<p style='color:red'>" +zipEntry.name + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"' + array[arrayLen-2] +'"不是文件夹，请删除后上传！' + "</p>");
    	            		fileError.push("\n " + zipEntry.name +' " ' + array[arrayLen-2] +' " ' + "不是文件夹，请删除后上传");
    	            	}
    	            	// 正确的dcm文件
    	            	else{
    	            		$fileContent.append("<p style='color:green'>" + zipEntry.name + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;符合上传要求，请点击上传按钮。" + "</p>");	            		
    	            	}
    	            }
    	            // 判断三级目录下不是dcm文件
    	            else if(arrayLen == 3 && (/[0-9a-zA-Z\u4e00-\u9fa5]/.test(array[arrayLen-1]))){
    	            		$fileContent.append("<p style='color:red'>" +zipEntry.name + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;非dcm文件，请删除后上传。" + "</p>");
    	            		fileError.push("\n " + zipEntry.name + "    非dcm文件，请删除后上传");
    	            }
            	}else{
            		$fileContent.append("<p style='color:red'>" + zipEntry.name + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + array[0]+"中含有下划线，请修改后上传！" + "</p>");
            		fileError.push("\n " + zipEntry.name +"  " + array[0] + "中含有下划线，请修改后上传！");
            	}
            	
           }else{
            	 alert(zipEntry.name + "文件目录结构不符合要求！")
            }
            });	
			if(fileError.length == 0){
				alert("上传文件检查合格，请点击上传文件。");
			}else{
				alert(fileError);
			}
           	fileError = [];
        }, function (e) {
        	$("#result").append($("<div>", {
                "class" : "alert alert-danger",
                text : "Error reading " + f.name + ": " + e.message
            }));
        });
    }

    var files = evt.target.files;
  
    for (var i = 0; i < files.length; i++) {
    	alert(456);
    	alert(files[0]);
        handleFile(files[i],fileError);
    }
});
});