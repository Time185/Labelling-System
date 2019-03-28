package cn.itcast.goods.user.domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 用户模块实体类
 * @author qdmmy6
 *
 */
/*
 * 属性哪里来
 * 1. t_user表：因为我们需要把t_user表查询出的数据封装到User对象中
 * 2. 该模块所有表单：因为我们需要把表单数据封装到User对象中
 */
public class User {
	// 对应数据库表
	private String uid;//主键
	private String loginname;//登录名
	private String loginpass;//登录密码
	private String email;//邮箱
	private String iphone; //手机号
	private String data;
	private boolean status;//状态，true表示已激活，或者未激活
	private String activationCode;//激活码，它是唯一值！即每个用户的激活码是不同的！
	
	// 注册表单
	private String reloginpass;//确认密码
	private String verifyCode;//验证码
	
	// 修改密码表单
	private String newpass;//新密码

	public String getReloginpass() {
		return reloginpass;
	}
	public void setReloginpass(String reloginpass) {
		this.reloginpass = reloginpass;
	}
	public String getVerifyCode() {
		return verifyCode;
	}
	public void setVerifyCode(String verifyCode) {
		this.verifyCode = verifyCode;
	}


	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getLoginpass() {
		return loginpass;
	}
	public void setLoginpass(String loginpass) {
		this.loginpass = loginpass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getIphone() {
		return iphone;
	}
	public void setIphone(String iphone) {
		this.iphone = iphone;
	}
	
	public String getDate() throws ParseException {
        Calendar now = Calendar.getInstance();  
        Date d = new Date();  
        //System.out.println(d);  
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        String data = sdf.format(d);  
        //System.out.println("格式化后的日期：" + data);           
         
		return data;
	}
	public void setDate(String date) {
		this.iphone = date;
	}
	
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public String getActivationCode() {
		return activationCode;
	}
	public void setActivationCode(String activationCode) {
		this.activationCode = activationCode;
	}
	public String getNewpass() {
		return newpass;
	}
	public void setNewpass(String newpass) {
		this.newpass = newpass;
	}
	@Override
	public String toString() {
		return "User [uid=" + uid + ", loginname=" + loginname + ", loginpass="
				+ loginpass + ", email=" + email + ", iphone=" + iphone + ", status=" + status
				+ ", activationCode=" + activationCode + ", reloginpass="
				+ reloginpass + ", verifyCode=" + verifyCode + ", newpass="
				+ newpass + "]";
	}

}
