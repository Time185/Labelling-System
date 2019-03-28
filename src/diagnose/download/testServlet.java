package diagnose.download;



import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class testServlet
 */
@WebServlet("/testServlet")
public class testServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println(456);
		// TODO Auto-generated method stub
		
				//��������ļ���
				String filename = request.getParameter("filename");
				System.out.println(filename);
				
				//�����ļ�MIME����
				response.setContentType(getServletContext().getMimeType(filename));
				//����Content-Disposition
				response.setHeader("Content-Disposition", "attachment;filename="+filename);
				//��ȡĿ���ļ���ͨ��response��Ŀ���ļ�д���ͻ���
				//��ȡĿ���ļ��ľ���·��
				//String fullFileName = getServletContext().getRealPath("/download/" + filename);
				String fullFileName = "/home/wangning/diagnose/rj/" + filename;
				//System.out.println(fullFileName);
				//��ȡ�ļ�
				InputStream in = new FileInputStream(fullFileName);
				OutputStream out = response.getOutputStream();
				
				//д�ļ�
				int b;
				while((b=in.read())!= -1)
				{
					out.write(b);
				}
				
				in.close();
				out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
