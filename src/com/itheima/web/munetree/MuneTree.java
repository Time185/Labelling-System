package com.itheima.web.munetree;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itheima.utils.MeunTreeUtils;

public class MuneTree extends HttpServlet {
	String first="";
	String sencodString="";
	String _3nd="";
	//记录请求那一级别目录
	String flagString="";
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		//先处理超级链接请求
		String test = req.getParameter("test"); // 
		/**
		System.out.println(test+"test");

		Map<String,String[]> maps=req.getParameterMap();
		for (Map.Entry<String,String[]> entry:maps.entrySet()){
			for (String i : entry.getValue()){
		System.out.println("Key = " + entry.getKey() + ", Value = " + i);
			}
		}
		**/
		String name1=req.getParameter("name1");
		flagString=name1;
		//name1表示点击了那个超级链接
		//System.out.println(l+"name1");
		//req.setAttribute("firstDir", test);
		//response.sendRedirect("upload.jsp");
		String pathString="";
		if (first!="") {
			pathString=first;
			if (sencodString!="") {
				pathString+="/"+sencodString;
				if (_3nd!="") {
					pathString+="/"+_3nd;
				}
			}
		} 
		String[] filenameStrings = null;
		if (pathString!="") {
			filenameStrings=MeunTreeUtils.firstDir(pathString);
		} else {
			System.out.println("目录树路径为空");
		}
		req.getRequestDispatcher("upload_menu.jsp").forward(req, resp);
		
		req.setAttribute("filenames", filenameStrings);
		req.getRequestDispatcher("/upload.jsp").forward(req, resp);
		super.doGet(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
		doGet(req, resp);
	}

}
