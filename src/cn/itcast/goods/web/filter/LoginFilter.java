package cn.itcast.goods.web.filter;

import java.io.IOException;
import java.sql.DriverManager;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFilter implements Filter {
	public void destroy() {	
	    try{
	        DriverManager.deregisterDriver(DriverManager.getDrivers().nextElement());
	    }catch(Exception e){
	        e.printStackTrace();
	    }
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		/*
		 * 1. 获取session中的user
		 * 2. 判断是否为null
		 *   > 如果为null：保存错误信息，转发到msg.jsp
		 *   > 如果不为null：放行
		 */
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse response1=(HttpServletResponse) response;
		Object user = req.getSession().getAttribute("sessionUser");
		if(user == null) {
			req.setAttribute("code", "error");//为了显示X图片
			req.setAttribute("msg", "您还没有登录，不能访问本资源");
			req.getRequestDispatcher("/jsps/msg.jsp").forward(req, response);
		} else {
			response1.addHeader("Access-Control-Allow-Origin","*");
			chain.doFilter(request, response1);//放行
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {

	}
}
