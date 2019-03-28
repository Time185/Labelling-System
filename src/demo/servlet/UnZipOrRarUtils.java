package demo.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Enumeration;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import java.util.ArrayList;
import java.util.List;
 
/**
 * 
 * @author liuBf 
 * ��˵��:��ѹ�ļ������� *
 */
public class UnZipOrRarUtils {
 
 
	/*** �����õ���synchronized ��Ҳ���Ƿ�ֹ���ֲ������� ***/
 
	//public static synchronized void unzip(String zipFileName, String extPlace)
			//throws Exception {
		//unZipFiles(zipFileName, extPlace);
	//}
 
 
	/**
	 * ��ѹzip��ʽ��ѹ���ļ���ָ��λ��
	 * 
	 * @param zipFileName
	 *            ѹ���ļ�
	 * @param extPlace
	 *            ��ѹĿ¼
	 * @throws Exception
	 */
	public boolean unZipFiles(String zipFileName, String extPlace)
			throws Exception {
		System.setProperty("sun.zip.encoding",
		System.getProperty("sun.jnu.encoding"));
		try {
			(new File(extPlace)).mkdirs();
			File f = new File(zipFileName);
			ZipFile zipFile = new ZipFile(zipFileName, "GBK"); // ���������ļ������������
			if ((!f.exists()) && (f.length() <= 0)) {
				throw new Exception("Ҫ��ѹ���ļ�������!");
			}
			String strPath, gbkPath, strtemp;
			File tempFile = new File(extPlace);
			strPath = tempFile.getAbsolutePath();
			Enumeration<?> e = zipFile.getEntries();
			ArrayList<String> judgeName=new ArrayList<String>();
			while (e.hasMoreElements()) {
				ZipEntry zipEnt = (ZipEntry) e.nextElement();
				gbkPath = zipEnt.getName();
				if (zipEnt.isDirectory()) {
					strtemp = strPath + File.separator + gbkPath;
					File dir = new File(strtemp);
					dir.mkdirs();
					continue;
				} else { // ��д�ļ�
					InputStream is = zipFile.getInputStream(zipEnt);
					BufferedInputStream bis = new BufferedInputStream(is);
					gbkPath = zipEnt.getName();
					strtemp = strPath + File.separator + gbkPath;// ��Ŀ¼
					String strsubdir = gbkPath;
					for (int i = 0; i < strsubdir.length(); i++) {
						if (strsubdir.substring(i, i + 1).equalsIgnoreCase("/")) {
							String temp = strPath + File.separator
									+ strsubdir.substring(0, i);
							File subdir = new File(temp);
							if (!subdir.exists())
								subdir.mkdir();
						}
					}
					FileOutputStream fos = new FileOutputStream(strtemp);
					BufferedOutputStream bos = new BufferedOutputStream(fos);
					int c;
					while ((c = bis.read()) != -1) {
						bos.write((byte) c);
					}
					bos.close();
					fos.close();
				}
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
