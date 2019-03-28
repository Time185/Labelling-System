package com.itheima.utils;


import java.io.File;
import java.util.Comparator;

public class CompratorByName implements Comparator<File> {
	public int compare(File f1, File f2) {
		String name1=f1.getName();
		if(name1.contains("_"))name1=name1.split("_")[0];
		String name2=f2.getName();
		if(name2.contains("_"))name2=name2.split("_")[0];
		String path1=f1.getAbsolutePath().split("/"+f1.getName())[0];
		String path2=path1+"/maindirforemptydirexceptopn_neverwillbeRegisted";
		File[] notFile=(new File(path2)).listFiles();
		int m=0,n=0;
		for(int i=0;i<notFile.length;i++){
			String[] tmpName=notFile[i].getName().split("_");
		if(name1.equals(tmpName[0])) m=Integer.valueOf(tmpName[1]);
		if(name2.equals(tmpName[0])) n=Integer.valueOf(tmpName[1]);
		}
		int diff= m-n;
		if (diff < 0)
			return -1;// 倒序正序控制
		else if (diff == 0)
			return 0;
		else
			return 1;// 倒序正序控制
	}

	public boolean equals(Object obj) {
		return true;
	}
}

