package common.utils.common;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;

import common.config.properties.SettingProperties;
import common.utils.string.StringUtil;



public class OSValidator {
	
	static SettingProperties settingProperties = (SettingProperties)CmmnUtil.getBean("settingProperties");
	  
	private static final String OS = System.getProperty("os.name").toLowerCase();
	
	  
	//운영체제를 구분해서 경로를 다르게 리턴
	public static String getOsRootPath() { 
		
		
		String osRootPath="";
		
		if(isWindows()) {
			osRootPath = settingProperties.getUploadRootPath_win(); // 파일저장경로
			
		}
		else if(isUnix()) {
			osRootPath = settingProperties.getUploadRootPath_linux(); // 파일저장경로
		}
		
		return osRootPath;
	}	
	
	
	  
	public static final boolean isWindows() { 
		
		if(OS.contains("windows")) {
			
			return true;
		}
		else {
			
			return false;  
		}
	  
	}  
	  
	public static boolean isMac() {  
	  
		if(OS.contains("mac")) {
			
			return true;
		}
		else {
			
			return false;  
		}
	  
	}  
	  
	public static boolean isUnix() {  
		
		if(OS.contains("nix") || OS.contains("nux") || OS.contains("aix")) {
			
			return true;
		}
		else {
			
			return false;  
		}
	  

	  
	}  
	  
	public static boolean isSolaris() {  
		if(OS.contains("sunos")) {
			
			return true;
		}
		else {
			
			return false;  
		}
	
	  
	}  
	
	public static void main(String[]  args) {
		
		
		System.out.println(OSValidator.isWindows());
	}
	  

}
