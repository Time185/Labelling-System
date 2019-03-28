package diagnose.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;

import cn.itcast.goods.user.domain.User;

/**
 * 
 */
@SuppressWarnings("unused")
@WebServlet("/DignoseServlet")
public class DignoseServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub	
		System.out.println("zhelishizhenduan");
		String username =request.getParameter("name");
		String[] strs=username.split("_");
		response.setContentType("text/html; charset=UTF-8");
		//username =request.getParameter("name");
		//HttpSession session = request.getSession();
		//System.out.println(session);		
		//User user = (User) session.getAttribute("sessionUser");
		//System.out.println(user);	
		String showError="";
	 //��ȡ�ַ���
		strs[1]="zipStoreDirForNextStepUnzip";
		System.out.println(strs[1]+"*************************************zipStore");
		File hosptialFile = new File(strs[0].toString()); //ҽԺ�ļ���
		// yi yuan ming bu cun zai de hua  ,chaung jian yi yuan ming 
		if(!hosptialFile.exists()){  
			hosptialFile.mkdirs();  
        } 
		System.out.println(hosptialFile.getAbsolutePath() + "*************hosptial");
		File userFile = new File(hosptialFile.getPath()+"/"+strs[1].toString()); //ҽԺ�µ��û��ļ���
		
		if(!userFile.exists()){  
			userFile.mkdirs();  
        }
		System.out.println(userFile.getAbsolutePath() + "*************userFile");
		//post���ļ���ŵ�Ŀ¼
        //File tempDirPath =new File(request.getSession().getServletContext().getRealPath("/")+userFile.getPath());
		File tempDirPath =new File("/home/wangning/diagnose/"+userFile.getPath());
        
        if(!tempDirPath.exists()){  
            tempDirPath.mkdirs();
            System.out.println(tempDirPath.getAbsolutePath() + "*************tempDirPath");
        //���������ļ�����  
        DiskFileItemFactory fac = new DiskFileItemFactory();      
        //����servlet�ļ��ϴ����  
        ServletFileUpload upload = new ServletFileUpload(fac);      
        //�ļ��б�  
        List<FileItem> fileList = null;      
        //����request�Ӷ��õ�ǰ̨���������ļ�  
        try {      
            fileList = upload.parseRequest(request);      
        } catch (FileUploadException ex) {      
            ex.printStackTrace();   
            deleteDir(tempDirPath);
            System.out.println("deleteIf");
            return;      
        }   
        //�������ļ���  
        String imageName = null;
        String compressFileName = null;
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");//��ȡ���uuid����ֹ�ļ�������
        //������ǰ̨�õ����ļ��б�  
        Iterator<FileItem> it = fileList.iterator(); 
       // compressFile = it.next().getName().split(".");
       // System.out.println(compressFile[0]);
        while(it.hasNext()){      
            FileItem item =  it.next(); 
            //���������ͨ���򣬵����ļ���������  
            if(!item.isFormField()){  
            imageName = uuid + item.getName();   //new Date().getTime()+Math.random()*10000+
            System.out.println(item.getName() + "++++++++++++++++++++++++++++++++++++++++123"); 
            compressFileName = item.getName();
                     
            BufferedInputStream in = new BufferedInputStream(item.getInputStream());     
            BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(new File(tempDirPath+"/"+imageName)));  
            Streams.copy(in, out, true);  
                  
            }  
        }
       System.out.println(compressFileName);
       String[] compre = compressFileName.split("\\.");
       System.out.println(compre[0] + "***********************compre[0]");
       String imagename = (tempDirPath.getAbsolutePath()+"/"+imageName).toString();
       // 解压目录
       String unzipName = tempDirPath.getAbsolutePath();
        unzipName = unzipName.replace(strs[1], "");
       String noPostfixname = imageName.substring(0, imageName.lastIndexOf("."));
       String file_name = (tempDirPath.getAbsolutePath()+"/"+noPostfixname).toString(); 
       
       System.out.println(imagename+"--------imagename");
       System.out.println(file_name+"--------file_name");
       file_name = file_name.replace(strs[1] + "/", "");
       System.out.println(strs[1]);
       System.out.println(unzipName+"--------unzipName");
       String deleteFile = unzipName + "/" + strs[1];   
       String deleteCompressFileName = unzipName  + compre[0];
      // System.out.println(deleteCompressFileName + "COMPRESSnAME+++++++++++++++++++++789");
       DignoseUnZipOrRarUtils myzip = new DignoseUnZipOrRarUtils();
       try {
		String strs1=username.split("_")[0]; 
	    String judgePath = "/home/wangning/diagnose/"+strs1;
	    String using = "/home/wangning/diagnose/"+strs1+"/using";
	    File usingFile = new File(using);
	    if (!usingFile.exists()) {                           
	    	usingFile.mkdir();     
	     }
	    File judgeDir = new File(judgePath);
        File[] judgeList = judgeDir.listFiles();
        String[] orgName=new String[judgeList.length];
		for (int j = 0; j < judgeList.length; j++) {
		      if (judgeList[j].isDirectory()) {
		          String fileName = judgeList[j].getName();
		          System.out.println(fileName + "+++++++++++++++++++++++++++++++fileName");
		          String tempFileName=fileName.split("_")[0];				          
		          orgName[j]=tempFileName;
		      }
		}
		Pattern pattern = Pattern.compile("[\u4e00-\u9fa5]");
		Pattern patPunc = Pattern.compile("[`~!@#$^&*()=|{}':;',\\[\\].<>/?_~！@#￥……&*（）——|{}【】‘；：”“'。，、？]$");
        ////String regEx = ;
        //Pattern patPunc = Pattern.compile("[ _`~!@#$%^&*()+-=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]|\n|\r|\t");
		String tmpDir=unzipName+"zipUnzipDirtoStoreTheUnzipedDirectory";	
		System.out.println(tmpDir+"*************************************zip Unzip");
		myzip.unZipFiles(imagename,tmpDir);	
		File tmpFileDir=new File(tmpDir);	
		for (File file : tmpFileDir.listFiles() ) {
			int flag=0;
			 if (file.isDirectory()) {
		          	for(int k=0;k<orgName.length;k++){
		          		if(file.getName().equals(orgName[k])){
		          			showError=showError+file.getName()+"与已有患者名称重名\n:";
		          			System.out.println(showError);
		          			flag=1;
		          			break;
		          		}
		          	}
		      }
			Matcher m1 = pattern.matcher(file.getAbsolutePath());
			if(m1.find()){
				showError=showError+file.getName()+"名称含有中文\n:";
				flag=1;
				}
			Matcher m2 = patPunc.matcher(file.getAbsolutePath());
			if(m2.find()){
				showError=showError+file.getName()+"文件名异常\n:";
				flag=1;
				}
			if(file.getAbsolutePath().contains("-")||file.getAbsolutePath().contains("%")){
				showError=showError+file.getName()+"文件名异常\n:";
				flag=1;
				}
			if(NotOnlyDicom(file)) {
				showError=showError+file.getName()+"含有非DICOM文件\n";
				flag=1;
				}
		     if(!emptyDir(file)){
		    	 System.out.println(file.getName()+"****************************3333");
		    	 for (File file1 :  file.listFiles() ) {
		    		 if(!file1.isDirectory()){
		    			 showError=showError+file.getName()+"文件结构不符合要求\n:";
		    			 flag=1;
		    			 break;
		    		 }
		    		 if(!pureDcm(file1)){
		    			 showError=showError+file.getName()+"文件结构不符合要求\n:";
		    			 flag=1;
		    			 break;
		    		 }	 
		    	 }
		     }
		  
		     if(flag==1) deleteDir(file);
		     flag=0;
		}
		
		/*for (File file : tmpFileDir.listFiles() ) {
			 System.out.println(file.getName()+"****************************11111");
			 int isOk=1;
		     if(!emptyDir(file)){
		    	 System.out.println(file.getName()+"****************************3333");
		    	 for (File file1 :  file.listFiles() ) {
		    		 System.out.println(file1.getName()+"****************************2222");
		    		 if(!pureDcm(file1)){
		    			 showError=showError+file.getName()+"文件结构不符合要求\n:";
		    			 isOk=0;
		    			 break;
		    		 }
		    			 
		    	 }
		     }
		     if(isOk==0) deleteDir(file);
		     isOk=1;
		}
		for (File file : tmpFileDir.listFiles() ) {
			System.out.println(file.getName());
			/*if(emptyDir(file)) {
				showError=showError+file.getName()+"为空文件夹\n";
				System.out.println(showError);
				deleteDir(file);
				continue;			
			}
			else */
				/*continue;			
			}else{
			//changeDir(file);
			//changeDir(file);
				}
		}*/
		String uploadPath1=unzipName+"/maindirforemptydirexceptopn_neverwillbeRegisted";
		File calcuLength=new File(uploadPath1);
		File[] originalLength=calcuLength.listFiles();
		int length=originalLength.length;
		for (File file : tmpFileDir.listFiles() ) {
			copyFile(file,new File(unzipName));
			length++;
			String uploadPath=unzipName+"/maindirforemptydirexceptopn_neverwillbeRegisted/"+file.getName()+"_"+length;
			File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	        	System.out.println(uploadPath+"mkdir");
	            uploadDir.mkdir();
	        }
		}
		//showError=showError+";";
		deleteDir(new File(deleteFile));
		deleteDir(tmpFileDir);
		deleteDir(usingFile);
	    System.out.println(deleteCompressFileName + "deleteFIle+++++++++++++++");
	    response.setContentType("text/html; charset=UTF-8");
	    response.getWriter().print(showError);
	    response.getWriter().close();
	} catch (Exception e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
       /* PrintWriter out = null;  
        try {  
            out = encodehead(request, response);  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        out.write(showError);
        out.close(); */
       
	//}	
        }
	}
	private PrintWriter encodehead(HttpServletRequest request,HttpServletResponse response) throws IOException{  
        request.setCharacterEncoding("utf-8");  
        response.setContentType("text/html; charset=utf-8");  
        return response.getWriter();  
    }  
	
	
	public static void changeDir(File f) throws IOException {
    
            // 获取路径下的所有文件
            File[] files = f.listFiles();
            int m=0,n=0;
            for (int i = 0; i < files.length; i++) {
                // 如果还是文件夹 递归获取里面的文件 文件夹
                if (files[i].isDirectory()) {
                	changeDir(files[i]);
                    m=1;
                } else {
                    n=1;
                }
            }
        if(m==1&&n==1) {
        	String newDir =f.getAbsolutePath()+"/"+f.getName();
        	System.out.println(newDir+"***********************************");
        	File newDirFile=new File(newDir);
        	if (!newDirFile.exists()) {
            	System.out.println(newDirFile+"mkdir");
            	newDirFile.mkdir();
            }
        	for (int i = 0; i < files.length; i++) {
                if (!files[i].isDirectory()) {
                	if(files[i].exists()) {		
                		if(files[i].isFile()) {		
                			System.out.println("是一个文件");
                		}else {				
                			System.out.println("不是一个文件");	
                			}		}else {			
                				System.out.println("不存在");		
                			}
                	System.out.println(files[i].getAbsolutePath()+"***********************************"+newDirFile.getAbsolutePath()+"/"+files[i].getName());
                	fileChannelCopy(files[i].getAbsolutePath(),newDirFile.getAbsolutePath()+"/"+files[i].getName());
                   files[i].delete();
                }  
            }	
        }
        
    }
	public static void fileChannelCopy(String sFile, String tFile) {		
		FileInputStream fi = null;		
		FileOutputStream fo = null;		
		FileChannel in = null;		
		FileChannel out = null;	
		File s = new File(sFile);
		File t = new File(tFile);
		if (s.exists() && s.isFile()) {			
			try {				
				fi = new FileInputStream(s);				
				fo = new FileOutputStream(t);				
				in = fi.getChannel();// 得到对应的文件通道				
				out = fo.getChannel();// 得到对应的文件通道				
				in.transferTo(0, in.size(), out);// 连接两个通道，并且从in通道读取，然后写入out通道			
				} catch (IOException e) {				
					e.printStackTrace();			
					} finally {	
						try {					
							fi.close();					
							in.close();					
							fo.close();					
							out.close();				
							} catch (IOException e) {
								e.printStackTrace();				
					}			
				}	
		}
	}

	@SuppressWarnings("null")
	public static void changeDir2(File f) throws IOException {
	    
        // 获取路径下的所有文件
        File[] files = f.listFiles();
        int m=0,n=0;
        File[] dirChange = null;
        int length=0;
        for (int i = 0; i < files.length; i++) {
            // 如果还是文件夹 递归获取里面的文件 文件夹
            if (pureDir(files[i])) {
            	changeDir2(files[i]);
                m=1;
            } else if(pureDcm(files[i])||emptyFile(files[i])){
            	dirChange[length]=files[i];
                n=1;
                length++;
            }
        }
    if(m==1&&n==1) {
    	for(int j=0;j<length;j++){
    	String newDir =dirChange[j].getAbsolutePath()+"/"+dirChange[j].getName();
    	File newDirFile=new File(newDir);
    	File[] change=dirChange[j].listFiles();
    	for (int i = 0; i < change.length; i++) {
            if (!change[i].isDirectory()) {
               copyFile(change[i],newDirFile);
               change[i].delete();
            } 
        }	
    }
    }
  }
	public static void copyFile(File src,File dest) throws IOException{
		File newFile = new File(dest,src.getName());
		if(!newFile.exists()){
			newFile.mkdirs();
		}
		System.out.println("src******************************"+src.getAbsolutePath());
		System.out.println("dest******************************"+dest.getAbsolutePath());
		File[] files = src.listFiles();
		if(files.length>0){
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
	}
	public boolean deleteDir(File f) {
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
	public static boolean emptyFile(File f){
		File[] dirContent=f.listFiles();
		if(dirContent.length ==0)return true;
		else return false;
	}
	public boolean emptyDir(File f){
		    int m=0;
            File[] files = f.listFiles();
            for (int i = 0; i < files.length; i++) {
                if (!files[i].getAbsolutePath().contains(".")) {
                   if(!emptyDir(files[i])) m=1 ;
                } else {
                	m=1;
                }
            }
          if(m==1)return false;
          else return true;
    }
	public boolean NotOnlyDicom(File f){
        File[] files = f.listFiles();
        int m=0,n=0;
        for (int i = 0; i < files.length; i++) {
            if (files[i].isDirectory()) {
            	NotOnlyDicom(files[i]);
            } else {
            	if(!files[i].getName().contains(".dcm")) {
            		files[i].delete();
            	}
            }

        }
     return false;
  }
	public static boolean pureDir(File f){
        File[] files = f.listFiles();
        int m=0,n=0;
        for (int i = 0; i < files.length; i++) {
            if (!files[i].isDirectory()) {
            	return false;           	 
            }
        }
     return true;
  }
	public static boolean pureDcm(File f){
        File[] files = f.listFiles();
        int m=0,n=0;
        for (int i = 0; i < files.length; i++) {
            if (files[i].isDirectory()) {
            	 return false;
            }
        }
     return true;
  }
	
}
