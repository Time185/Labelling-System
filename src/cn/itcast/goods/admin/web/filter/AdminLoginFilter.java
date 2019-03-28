package cn.itcast.goods.admin.web.filter;

import java.io.IOException;
import java.sql.DriverManager;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class AdminLoginFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		Object admin = req.getSession().getAttribute("admin");
		if(admin == null) {
			request.setAttribute("msg", "����û�е�¼����ҪϹ�޴");
			request.getRequestDispatcher("/adminjsps/login.jsp").forward(request, response);
		} else {
			chain.doFilter(request, response);
		}
	}  

	public void init(FilterConfig fConfig) throws ServletException {
	}
	public void destroy() {	
		    try{
		        DriverManager.deregisterDriver(DriverManager.getDrivers().nextElement());
		    }catch(Exception e){
		        e.printStackTrace();
		    }
		}
}
