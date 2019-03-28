package com.zout;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.itheima.domain.User;

/** 
* 梦洁的代码，标注的保存
 */
@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 上传文件存储目录
    private static final String UPLOAD_DIRECTORY = "2";

    // 上传配置-单位字节
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB

    /**
     * 上传数据及保存文件
     */
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
	}
    protected void doPost(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
    	//System.out.println("--------------- uploadservlet");
    	
        // 1.判断是否为多媒体上传
        if (!ServletFileUpload.isMultipartContent(request)) {
            // 如果不是则停止
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须写有:enctype=multipart/form-data");
            writer.flush();
            return;
        }

        //2.开始配置上传参数-创建fileItem工厂
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
        factory.setSizeThreshold(MEMORY_THRESHOLD);

        // 设置临时存储目录
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        //创建文件上传核心组件
        ServletFileUpload upload = new ServletFileUpload(factory);

        // 设置最大上传文件的阈值
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // 设置最大请求值 (包含文件和表单数据)
        upload.setSizeMax(MAX_REQUEST_SIZE);

        // 中文处理
        upload.setHeaderEncoding("UTF-8"); 

        // 构造临时路径来存储上传的文件
        // 这个路径相对当前应用的目录
        //String uploadPath ="/home/wangning/";
        HttpSession session = request.getSession();       
        String resParentPath = (String) session.getAttribute("resParentPath");
        /*String[] nameStore1=((String) session.getAttribute("name")).split("_");
        System.out.println( nameStore1[0]+ "获取到的路径为" ); 
        String nameStore="/"+nameStore1[0]+"/";
        System.out.println(resParentPath + "获取到的路径为" ); 
        String[] pathApart=resParentPath.split(nameStore);
        String[] pathApart1=pathApart[1].split("/");
        String[] pathApart2=new String[pathApart1.length-1];
        String[] pathtmp=new String[pathApart1.length-1];
        for(int j=0;j<pathApart1.length-1;j++){
        	pathtmp[j]=pathApart1[j+1];
        }
        for(int j=0;j<pathApart1.length-1;j++){
        	if(!pathtmp[j].contains("_mask")){
        	pathtmp[j]=pathApart1[j+1]+"_mask";}
        	pathApart2[j]=pathApart[0]+"/"+nameStore1[0]+"/"+pathApart1[0];
        	for(int k=0;k<pathApart1.length-1;k++){
        		pathApart2[j]=pathApart2[j]+"/"+pathtmp[k];
            }
        	pathtmp[j]=pathApart1[j+1];
        	System.out.println(pathApart2[j]+"                  "+pathApart1.length);
        }
        System.out.println(UPLOAD_DIRECTORY + "upload_Directory");
        //String uploadPath = getServletContext().getRealPath("/")+File.separator+UPLOAD_DIRECTORY;
        for(int j=0;j<pathApart2.length;j++){
        	File uploadDir = new File(pathApart2[j]);
        	if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
        }*/
        String uploadPath = resParentPath;
        System.out.println(uploadPath+"------uploadpath");
        // 如果目录不存在则创建                             
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
        	System.out.println(uploadPath+"mkdir");
            uploadDir.mkdir();
        }
        /*String[] copyPath=new String[300];
        int itemLength=0;*/
        try {

            // 解析请求的内容提取文件数据
            List<FileItem> formItems = upload.parseRequest(request);
            //遍历Items
            if (formItems != null && formItems.size() > 0) {
            	
                // 迭代表单数据

                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        //获取文件保存在服务器的路径
                        //fileName="ll.png";
                        String filePath = uploadPath + File.separator + fileName;
                        //copyPath[itemLength]=filePath;
                        //itemLength++;                        
                        //这个路径已经包含了图片名称，放到file对象中保存。
                        File storeFile = new File(filePath);
                        // 在控制台输出文件的上传路径
                        // 保存文件到硬盘
                        item.write(storeFile);
                        request.setAttribute("message",
                            "文件上传成功!"
                            + "<br>存于："+filePath);
                   
                    }
                }
            }
            
        } catch (Exception ex) {
            request.setAttribute("message", "错误信息: " + ex.getMessage());
        }

        // 跳转到 message.jsp
        getServletContext().getRequestDispatcher("/message.jsp").forward(
                request, response);
    }
}