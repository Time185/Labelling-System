package test;

import java.util.ResourceBundle;

public class test {

	public static void main(String[] args) {
		ResourceBundle resource = ResourceBundle.getBundle("peizhi");
		String key = resource.getString("source_path"); 
	}

}
