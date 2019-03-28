package com.itheima.utils;

import java.io.File;
import java.io.FileWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ResourceBundle;

//import com.sun.jndi.url.iiopname.iiopnameURLContextFactory;

public class MeunTreeUtils {
	static String meun_path;
	static{
		ResourceBundle resource = ResourceBundle.getBundle("peizhi");
		meun_path = resource.getString("meun_path"); 
	}
	//菜单树
	public static String[] firstDir(String filename) {
		String path=meun_path+filename;
		File file=new File(path);
		String[] list = file.list();
		return list;
	}
	public static void main(String[] args) {
		String[] list=firstDir("subset0/subset0");
		System.out.println(list);
		String tmpString;
		for (String string : list) {
			System.out.println(string);
		}
	}

}
