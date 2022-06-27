package common.utils.common;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.management.ManagementFactory;
import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.Socket;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.Normalizer;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.ApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.base.Throwables;

import common.exception.UserBizException;
import common.springsecurity.MemberVO;
import common.utils.mybatis_paginator.domain.PageList;
import common.utils.mybatis_paginator.domain.Paginator;
import common.utils.string.StringUtil;
import common.utils.uuid.UuidUtil;
import ch.qos.logback.core.helpers.ThrowableToStringArray;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CmmnUtil {
		
	public static List<String> sortStringList(final List<String> strList){
		return null;
	}
	
	/**
	 * response의 헤더중 Content-Disposition 지정하기
	 * @param filename
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public static void setContectDispositionResponse(String filename, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = encodeString4Browser(request, filename);
		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
	}
	
	/**
	 * 예외에서 상세내용을 리턴
	 * @param ex
	 * @return
	 */
	public static String getExceptionStackTrace(Exception ex) {
		return Throwables.getStackTraceAsString(ex);
	}
	
	/**
	 * bean명으로 bean을 가져오는 함수
	 * @param beanId
	 * @return
	 */
	public static Object getBean(String beanId) {
		ApplicationContext applicationContext = ApplicationContextProvider.getApplicationContext();
		if(applicationContext == null) {
			throw new NullPointerException("Spring의 Application이 초기화가 안됨");
		}
		return applicationContext.getBean(beanId);
	}
	
	/**
	 * 브라우저 종류 파악하기
	 * @param request
	 * @return
	 */
	public static String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if(header.contains("MSIE") || header.contains("Trident")) {
			return "MSIE";
		} else if(header.contains("Chrome")) {
			return "Chrome";
		} else if(header.contains("Opera")) {
			return "Opera";
		}
		return "Firefox";
	}
	
	public static String encodeString4Browser(HttpServletRequest request, String str) throws IOException {
		String browser = getBrowser(request);
		
		String rslt = null;
		if("MSIE".equals(browser)) {
			rslt = URLEncoder.encode(str, "UTF-8").replaceAll("\\+", "%20");
		} else if("Firefox".equals(browser)) {
			rslt = StringUtil.join("\"", new String(str.getBytes("UTF-8"), "8859_1"), "\"");
		} else if("Opera".equals(browser)) {
			rslt = StringUtil.join("\"", new String(str.getBytes("UTF-8"), "8859_1"), "\"");
		} else if("Chrome".equals(browser)) {
			StringBuffer sb = new StringBuffer();
			for(int i=0; i<str.length(); i++) {
				char c = str.charAt(i);
				if(c > '~') {
					sb.append(URLEncoder.encode(Character.toString(c), "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			rslt = sb.toString();
		} else {
			throw new IOException("Not supported browser");
		}
		return rslt;
	}	
	
	public static String getYyyyMMddHHmmssSSS(){
		long dateTime = System.currentTimeMillis();	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.KOREA);
		return sdf.format(dateTime);
	}
	
	/**
	 * 현재시간을 리턴
	 * @return
	 */
	public static String currentTime() {
		long dateTime = System.currentTimeMillis();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		return sdf.format(dateTime);
	}
	
	/**
	 * 숫자 콤마찍기
	 * @param num
	 * @return
	 */
	public static String numberCommas(Object obj) {
		
		String num;
		if(obj instanceof Integer) {
			num = Integer.toString((int)obj);
		} else {
			num = (String) obj;
		}
		
		Long inValues = Long.parseLong(num);
		DecimalFormat Commas = new DecimalFormat("#,###");
		String result_int = (String) Commas.format(inValues);
		return result_int;
	}
	
	
//	public static boolean isMobile(HttpServletRequest request){
//		return new UAgentInfo(request).isMobile();
//	}
//	
//	public static boolean isAndroid(HttpServletRequest request){
//		return new UAgentInfo(request).isAndroid();
//	}
//	
//	public static boolean isIphone(HttpServletRequest request){
//		return new UAgentInfo(request).isIphone();
//	}
	
	/**
	 * 오늘날자를 기준으로 입된 날자와의 차이를 일단로 리턴
	 * @param endDate yyyy-MM-dd
	 * @return
	 */
	public static int diff(String endDate) {
		final String DATE_PATTERN = "yyyy-MM-dd";
        final int MILLI_SECONDS_PER_DAY = 24 * 60 * 60 * 1000;
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        Date today = new Date();
        Date endDateDate;
		try {
			endDateDate = sdf.parse(endDate);
			return (int) ((today.getTime() - endDateDate.getTime()) / MILLI_SECONDS_PER_DAY);
		} catch (ParseException e) {
			return 9999;
		}
        
	}
	
	/**
	 * 
	 * @param date yyyy-MM-dd 형식으로 입력 
	 * @return
	 */
	public static String calcDate(String date, int add_offset) {
		Calendar cal = Calendar.getInstance();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        try {
            cal.setTime(df.parse(date));
        } catch (ParseException e) {
            log.error(CmmnUtil.getExceptionStackTrace(e));
            return null;
        }
        cal.add(Calendar.DATE, add_offset);
    	String yyyy = Integer.toString(cal.get(Calendar.YEAR));
    	String mm = Integer.toString(cal.get(Calendar.MONTH)+1);
    	String dd = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
        
		return StringUtil.join(yyyy, '-', StringUtil.leftPad(mm, 2, '0') , '-', StringUtil.leftPad(dd, 2, '0'));
	}
	
	
	/**
	 * 오늘 날짜 문자열 취득.
	 * ex) 20090101
	 * @return
	 */
	public static String getTodayString() {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

		return format.format(new Date());
	}
	
	public static String getTodayFormedString() {
		String yyyyMMdd = getTodayString();
		return StringUtil.join(yyyyMMdd.substring(0, 4), '-', yyyyMMdd.substring(4, 6), '-', yyyyMMdd.substring(6));
	}
	
	/**
	 * 오늘 날짜 시분초 문자열 취득.
	 * ex) 011635001
	 * @return
	 */
	public static String getCurTime() {
		SimpleDateFormat format = new SimpleDateFormat("HHmmssSSS", Locale.getDefault());

		return format.format(new Date());
	}
	
	/**
	 * 현재 컴퓨터의 mac주소를 하이픈 포함해서 가져옴(17자리)
	 * <br> 주의 : java 1.6 이상부터 사용이 가능함
	 * <br> 예시 : E8-03-9A-68-D2-7F
	 * @return 하이픈(-)이 포함된 17자리 mac주소
	 */
	public static String getServerMacHyphen(){
		// 기본값 mac주소를 세팅
		String macAddr = "";

		// 실제 mac주소 세팅
		try {
			// byte형식의 mac주소 
			InetAddress ip = InetAddress.getLocalHost();
			NetworkInterface network = NetworkInterface.getByInetAddress(ip);
			byte[] mac = network.getHardwareAddress();
			
			// byte코드를 String 자료형의 16진수로 변환
			StringBuilder sb = new StringBuilder();
			for(int i = 0; i < mac.length; i++){
				sb.append(String.format("%02X%s", mac[i], (i < mac.length -1 ) ? "-" : ""));
			}
			
			macAddr = sb.toString();
		} catch (Exception e) {
			// 오류가 발생하면 mac주소를 기본값으로 세팅함
			macAddr = "";
		}
		
		return macAddr.replace("-", "");
	}

	/**
	 * 클라이언트 아이피 주소 획득
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		
		String ip = request.getHeader("X-Forwarded-For");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}        
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-Real-IP"); 
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-RealIP"); 
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("REMOTE_ADDR");
        }
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		
		return ip;
	}
	
	/**
	 * 요청 request 가  local 인지 여부
	 * @param request
	 * @return
	 */
	public static boolean isLocalPc(HttpServletRequest request) {
		String ip = getIpAddr(request);
		if(StringUtil.equals("0:0:0:0:0:0:0:1", ip) || StringUtil.equals("127.0.0.1", ip)) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
     * Object type 변수가 비어있는지 체크
     * 
     * @param obj 
     * @return Boolean : true / false
     */
    public static Boolean isEmpty(Object obj) {
        if (obj instanceof String) return obj == null || "".equals(obj.toString().trim());
        else if (obj instanceof List) return obj == null || ((List<?>) obj).isEmpty();
        else if (obj instanceof Map) return obj == null || ((Map<?, ?>) obj).isEmpty();
        else if (obj instanceof Object[]) return obj == null || Array.getLength(obj) == 0;
        else return obj == null;
    }

    
	/**
	 * DevMap 리스트를 key 값에 의거해서 정렬하는 함수
	 * @param mapList
	 * @param key 비교한 키값
	 * @param isAscent 오름차순으로 정렬여부
	 * @return
	 */
	public static List<PentasMap> sortDevMapList_StringValue(final List<PentasMap> mapList, final String key, boolean isAscent){
		Collections.sort(mapList, new Comparator<PentasMap>() {
			@Override
			public int compare(PentasMap map1, PentasMap map2) {
				String v1 = map1.getString(key);
				String v2 = map2.getString(key);
				return ((Comparable<String>) v2).compareTo(v1);
			}
		});
		if(isAscent) {
			Collections.reverse(mapList);
		}
		return mapList;
	}
	
	public static List<PentasMap> sortDevMapList_DoubleValue(final List<PentasMap> mapList, final String key, boolean isAscent){
		Collections.sort(mapList, new Comparator<PentasMap>() {
			@Override
			public int compare(PentasMap map1, PentasMap map2) {
				double v1 = map1.getDouble(key);
				double v2 = map2.getDouble(key);
				
				if(v1 > v2) {
					return -1;
				} else if(v1 < v2) {
					return 1;
				} else {
					return 0;
				}
			}
		});
		if(isAscent) {
			Collections.reverse(mapList);
		}
		return mapList;
	}
	
	/**
	 * 맵 리스트인 target 에서 key 값에 매칭되는 값이 value 와 일치하는 맵들의 리스트를 리턴한다.
	 * @param target
	 * @param key
	 * @param value
	 * @return
	 */
	public static List<PentasMap> getMatchedList(List<PentasMap> target, Object key, Object value){
		List<PentasMap> rslt = new ArrayList<PentasMap>();
		for(PentasMap map : target) {
			if(value.equals(map.get(key))) {
				rslt.add(map);
			}
		}
		return rslt;
	}
	
	/**
	 * 맵 리스트인 target 에서 key 값에 매칭되는 값이 value 와 일치하지않는 맵들의 리스트를 리턴한다.
	 * @param target
	 * @param key
	 * @param value
	 * @return
	 */
	public static List<PentasMap> getNotMatchedList(List<PentasMap> target, Object key, Object value){
		List<PentasMap> rslt = new ArrayList<PentasMap>();
		for(PentasMap map : target) {
			if(!value.equals(map.get(key))) {
				rslt.add(map);
			}
		}
		return rslt;
	}
	
	/**
	 * 맵 리스트인 target 에서 key 값에 매칭되는 값이 value 와 일치하는 첫번째 검색되는 맵을 리턴한다.
	 * @param target
	 * @param key
	 * @param value
	 * @return
	 */
	public static PentasMap getFirstFromList(List<PentasMap> target, Object key, Object value){
		if(target == null) {
			return null;
		}
		String valType = whatIs(value);
		
		if("String".equals(valType) && StringUtil.isEmpty((String)value)) {
			return null;
		} else if(value == null) {
			return null;
		}
		
		if("Integer".equals(valType)) {
			value = Integer.toString((int)value);
		}
		
		Object tmp;
		for(PentasMap map : target) {
			if("Integer".equals(whatIs(map.get(key)))) {
				tmp = Integer.toString((int)map.get(key));
			} else {
				tmp = map.get(key);
			}
			if(value.equals(tmp)) {
				return map;
			}
			
			
		}
		
		return null;
	}
	
	public static void convertIfEmpty(PentasMap map, String str) {
		if(map == null) return;
		Set<Object> keys = map.keySet();
		for(Object key : keys) {
			if(isEmpty(map.get(key))) {
				map.put(key, str);
			}
		}
	}
	
	public static String getFirstMatchedKey(PentasMap map, String value) {
		
		Set<Object> keylist = map.keySet();
		for(Object key : keylist) {
			if(map.get(key).equals(value)) {
				return (String)key;
			}
		}
		
		return null;
	}
	
	public static String whatIs(Object obj) {
	    if (obj instanceof Integer) {
	        return "Integer";
	    } else if(obj instanceof String) {
	    	return "String";
	    } else if(obj instanceof Float) {
	    	return "Float";
	    }
	    return "non";
	}
	
	public static String genOrderNo(){
		StringBuffer sb = new StringBuffer();
		sb.append(getTodayString().substring(4));
		sb.append('-');
		for (int i = 0; i < 4; i++) {
			sb.append((char) ((Math.random() * 26) + 65));
		}
		sb.append('-');
		sb.append(StringUtil.leftPad(Integer.toString((int) (Math.random()*1000 + 1)), 4, '0'));
		return sb.toString();
	}

	public static void modifyElementIndex(List<PentasMap> list, int idx, PentasMap element) {
		if(element.isEmpty()) return;
		
		Set<Object> keyList = element.keySet();
		int cnt;
		PentasMap target = new PentasMap();
		for(int i=(list.size()-1); i>=0; i--){
			cnt = 0;
			for(Object key : keyList) {
				if(list.get(i).get(key).equals(element.get(key))) {
					++cnt;
				}
			}
			if(cnt == keyList.size()) {
				target = list.get(i);
				list.remove(i);
				break;
			}
		}
		if(!target.isEmpty()) {
			if(idx >= list.size()) {
				list.add(target);
			} else {
				list.add(idx, target);
			}
		}
	}
	

	
	public static void safeClose(Socket s) {
		if(s != null && !s.isClosed()) {
			try {
				s.close();
			} catch(IOException e) {
				log.error(getExceptionStackTrace(e));
				s = null;
			}
		}
	}
	
	public static void safeClose(PrintWriter pw) {
		if(pw != null) {
			try {
				pw.close();
			} catch(Exception e) {
				log.error(getExceptionStackTrace(e));
				pw = null;
			}
		}
	}
	
	public static void safeClose(HttpURLConnection hc) {
		if(hc != null) {
			try {
				hc.disconnect();
			} catch(Exception e) {
				log.error(getExceptionStackTrace(e));
				hc = null;
			}
		}
	}
	
	public static void safeClose(BufferedReader br) {
		if(br != null) {
			try {
				br.close();
			} catch(IOException e) {
				log.error(getExceptionStackTrace(e));
				br = null;
			}
		}
	}
	
	public static void safeClose(InputStream is) {
		try {
			if(is != null) {
				is.close();
			}
		} catch(IOException e) {
			log.error(getExceptionStackTrace(e));
			is = null;
		}
	}
	
	public static void safeClose(OutputStream os) {
		try {
			if(os != null) {
				os.close();
			}
		} catch(IOException e) {
			log.error(getExceptionStackTrace(e));
			os = null;
		}	
	}
	
	public static String mapToString(Map map) {
		StringBuffer sb = new StringBuffer();
		
		Set<Object> keys = map.keySet();
		for(Object key : keys) {
			sb.append(' ');
			sb.append(key.toString());
			sb.append('=');
			sb.append(map.get(key));
			sb.append(' ');
		}
		
		return sb.toString();
	}
	
	public static Object callObjectMethodParamObj(Object object, String strCallMethod, List lParam) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		Class objClass = object.getClass();
		
		int nParam = 0;
		
		if(lParam == null) {
			nParam = 0;
		} else {
			nParam = lParam.size();
		}
		
		Class paramClass[] = new Class[nParam];
		Object objParam[] = new Object[nParam];
		
		for(int i=0; i<nParam; i++) {
			paramClass[i] = lParam.get(i).getClass();
			objParam[i] = lParam.get(i);
		}
		
		Method objMethod = objClass.getMethod(strCallMethod, paramClass);
		
		if(objMethod.getReturnType() == void.class) {
			objMethod.invoke(object, objParam);
			return void.class;
		} else {
			return objMethod.invoke(object, objParam);					
		}
	}
	
	public static String byteAry2String(byte[] byteAry, int offset, int length, String strCharSet) {
		
		try {
			byte[] baTmp = new byte[length];
			System.arraycopy(byteAry, offset, baTmp, 0, length);
			if(strCharSet == null) {
				return new String(baTmp);
			} else {
				return new String(baTmp, strCharSet);
			}
		} catch (IOException e) {
			log.error(getExceptionStackTrace(e));
			return null;
		}
	}
	
	public static String extract(byte[] bytes, String charset, int offset, int length) {
		String res = null;
		try {
			byte[] value = new byte[length];
			for(int i=0; i<length; i++) {
				value[i] = bytes[offset + i];
			}
			if(charset == null) {
				res = new String(value);
			} else {
				res = new String(value, charset);
			}
			return res;
		} catch (UnsupportedEncodingException e) {
			log.error(CmmnUtil.getExceptionStackTrace(e));
			return null;
		}
	}
	
	public static String getPid() {
		String pid;
		pid = ManagementFactory.getRuntimeMXBean().getName();
		pid = pid.substring(0, pid.indexOf('@'));
		return pid;
	}
	
	public static String lPadByte(String src, int lenByte, String pad, String charSet) throws UnsupportedEncodingException {
		
		if(pad.getBytes(charSet).length != 1) {
			throw new UserBizException("채우기용 문자는 1바이트만 가능합니다.");
		}
		
		StringBuffer result = new StringBuffer();
		int templen = lenByte - src.getBytes(charSet).length;
		int nTemp;
		
		if(templen < 0) {
			int nCnt = 0;
			char[] chary = src.toCharArray();
			for(char ch : chary) {
				nTemp = nCnt + String.valueOf(ch).getBytes(charSet).length;
				if(nTemp > lenByte) {
					StringBuffer sbtmp = new StringBuffer();
					for(int i=0; i<(lenByte-nCnt); i++) {
						sbtmp.append(pad);
					}
					return sbtmp.toString() + result.toString();
				} else {
					nCnt = nTemp;
					result.append(ch);
				}
			}
			return result.toString();
		} else {
			for(int i=0; i<templen; i++) {
				result.append(pad);
			}
			result.append(src);
			return result.toString();
		}
	}
	
	public static String rPadByte(String src, int lenByte, String pad, String charSet) throws UnsupportedEncodingException {
		
		if(pad.getBytes(charSet).length != 1) {
			throw new UserBizException("채우기용 문자는 1바이트만 가능합니다.");
		}
		
		StringBuffer result = new StringBuffer();
		int templen = lenByte - src.getBytes(charSet).length;
		int nTemp;
		if(templen < 0) {
			int nCnt = 0;
			char[] chary = src.toCharArray();
			for(char ch : chary) {
				nTemp = nCnt + String.valueOf(ch).getBytes(charSet).length;
				if(nTemp > lenByte) {
					for(int i=0; i<(lenByte-nCnt); i++) {
						result.append(pad);
					}
					break;
				} else {
					nCnt = nTemp;
					result.append(ch);
				}
			}
			return result.toString();
		} else {
			result.append(src);
			for(int i=0; i<templen; i++) {
				result.append(pad);
			}
			return result.toString();
		}
	}
	
	public static PentasMap getMap_StrData1_StrData2_StrData3(String strData) throws UnsupportedEncodingException {
		PentasMap rslt = new PentasMap() {{put("strData1",""); put("strData2",""); put("strData3",""); }};
		
		if(strData == null || "".equals(strData)) {
			return rslt;
		}
		
		byte[] baOrigin = strData.getBytes("utf-8");
		char[] caOrigin = strData.toCharArray();
		byte[] baTemp;
		char[] caTemp;
		int lengthCaTemp;
		int lengthTemp;
		
		int nUnitLength = 4000;
		int temp1;
		int temp2;
		
		if(baOrigin.length > nUnitLength) {
			lengthTemp = nUnitLength;
		} else {
			lengthTemp = baOrigin.length;
			rslt.put("strData1", new String(caOrigin));
			return rslt;
		}
		
		baTemp = new byte[lengthTemp];
		System.arraycopy(baOrigin, 0, baTemp, 0, lengthTemp);
		caTemp = (new String(baTemp, "utf-8")).toCharArray();
		lengthCaTemp = caTemp.length;
		if(caOrigin[lengthCaTemp - 1] == caTemp[lengthCaTemp - 1]) {
			
		} else if(caOrigin[lengthCaTemp - 2] == caTemp[lengthCaTemp - 2]) {
			caTemp = new char[lengthCaTemp - 1];
			System.arraycopy(caOrigin, 0, caTemp, 0, lengthCaTemp - 1);
		} else if(caOrigin[lengthCaTemp - 3] == caTemp[lengthCaTemp - 3]) {
			caTemp = new char[lengthCaTemp - 2];
			System.arraycopy(caOrigin, 0, caTemp, 0, lengthCaTemp - 2);
		} else {
			caTemp = new char[lengthCaTemp - 3];
			System.arraycopy(caOrigin, 0, caTemp, 0, lengthCaTemp - 3);
		}
		rslt.put("strData1", new String(caTemp));
		
		temp1 = caOrigin.length;
		temp2 = caTemp.length;
		caTemp = new char[temp1 - temp2];
		System.arraycopy(caOrigin, temp2, caTemp, 0, temp1 - temp2);
		caOrigin = caTemp;
		baOrigin = (new String(caOrigin)).getBytes("utf-8");
		
		if(baOrigin.length > nUnitLength) {
			lengthTemp = nUnitLength;
		} else {
			lengthTemp = baOrigin.length;
			rslt.put("strData2", new String(caOrigin));
			return rslt;
		}
		
		baTemp = new byte[lengthTemp];
		System.arraycopy(baOrigin, 0, baTemp, 0, lengthTemp);
		caTemp = (new String(baTemp, "utf-8")).toCharArray();
		lengthCaTemp = caTemp.length;
		if(caOrigin[lengthCaTemp - 1] == caTemp[lengthCaTemp - 1]) {
			
		} else if(caOrigin[lengthCaTemp - 2] == caTemp[lengthCaTemp - 2]) {
			caTemp = new char[lengthCaTemp - 1];
			System.arraycopy(caOrigin, 0, caTemp, 0, lengthCaTemp - 1);
		} else if(caOrigin[lengthCaTemp - 3] == caTemp[lengthCaTemp - 3]) {
			caTemp = new char[lengthCaTemp - 2];
			System.arraycopy(caOrigin, 0, caTemp, 0, lengthCaTemp - 2);
		} else {
			caTemp = new char[lengthCaTemp - 3];
			System.arraycopy(caOrigin, 0, caTemp, 0, lengthCaTemp - 3);
		}
		rslt.put("strData2", new String(caTemp));
		
		temp1 = caOrigin.length;
		temp2 = caTemp.length;
		caTemp = new char[temp1 - temp2];
		System.arraycopy(caOrigin, temp2, caTemp, 0, temp1 - temp2);
		caOrigin = caTemp;
		baOrigin = (new String(caOrigin)).getBytes("utf-8");
		
		
		if(baOrigin.length > nUnitLength) {
			lengthTemp = nUnitLength;
		} else {
			lengthTemp = baOrigin.length;
			rslt.put("strData3", new String(caOrigin));
			return rslt;
		}
		
		baTemp = new byte[lengthTemp];
		System.arraycopy(baOrigin, 0, baTemp, 0, lengthTemp);
		caTemp = (new String(baTemp, "utf-8")).toCharArray();
		lengthCaTemp = caTemp.length;
		if(caOrigin[lengthCaTemp - 1] == caTemp[lengthCaTemp - 1]) {
			
		} else if(caOrigin[lengthCaTemp - 2] == caTemp[lengthCaTemp - 2]) {
			caTemp = new char[lengthCaTemp - 1];
			System.arraycopy(caOrigin, 0, caTemp, 0, lengthCaTemp - 1);
		} else if(caOrigin[lengthCaTemp - 3] == caTemp[lengthCaTemp - 3]) {
			caTemp = new char[lengthCaTemp - 2];
			System.arraycopy(caOrigin, 0, caTemp, 0, lengthCaTemp - 2);
		} else {
			caTemp = new char[lengthCaTemp - 3];
			System.arraycopy(caOrigin, 0, caTemp, 0, lengthCaTemp - 3);
		}
		rslt.put("strData3", new String(caTemp));
		
		return rslt;
	}
	
	public static void traceOriginalException(Throwable t) {
		String[] throwbles = ThrowableToStringArray.convert(t);
		for(String str : throwbles) {
			log.error(str.replaceAll("\t", "    "));
		}
	}
	
	public static String normalizeNFC(String src) {
		return Normalizer.normalize(src, Normalizer.Form.NFC);
	}
	
	public static int toInteger(String str) {
		if(str == null) {
			return 0;
		} else if("".equals(str.trim())){
			return 0;
		} else {
			return Integer.parseInt(str.replaceAll(",", ""));
		}
	}
	
	public static String getRequestBody(HttpServletRequest request) throws IOException {
		 
        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;
        InputStream inputStream = null;
 
        try {
            inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            } else {
                stringBuilder.append("");
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
        	CmmnUtil.safeClose(bufferedReader);
        	CmmnUtil.safeClose(inputStream);
        }
 
        body = stringBuilder.toString();
        return body;
    }
	
	private static Object getCellValue(Cell cell) {
		
		if(cell != null){
			switch (cell.getCellType()) {
			case STRING:
				return cell.getStringCellValue().trim();
			case NUMERIC:
				DecimalFormat decimalFormat = new DecimalFormat("0");
				return decimalFormat.format(cell.getNumericCellValue()).trim();
			case BOOLEAN:
				return cell.getBooleanCellValue();
			case BLANK:
				return "";
			default:
				return null;

			}
		} else {
			return null;
		}
	}

	public static ExcelUpInfo getExcelContents(MultipartFile excelFile) {
		
		String orgFileNm = excelFile.getOriginalFilename();
		String fileExt = orgFileNm.substring(orgFileNm.lastIndexOf(".") + 1); // 파일확장자
		if("xlsx".equals(fileExt)) {
			return parseExcel2007(excelFile);
		} else if("xls".equals(fileExt)) {
			return parseExcel(excelFile);
		}
		return null;
	}
	
	public static ExcelUpInfo parseExcel(MultipartFile excelFile){

		String filePath = StringUtil.join(System.getProperty("java.io.tmpdir"), UuidUtil.getUuidOnlyString());
		
		try(FileOutputStream fo = new FileOutputStream(new File(filePath));
				FileInputStream fi = new FileInputStream(new File(filePath));
				){
			fo.write(excelFile.getBytes());
			
			HSSFWorkbook workbook = new HSSFWorkbook();
			Iterator<Row> rowIterator = workbook.getSheetAt(0).iterator();
			Iterator<Cell> cellIterator;
				
			ExcelUpInfo rowList = new ExcelUpInfo();
			while(rowIterator.hasNext()) {					
				PentasMap rowinfo = new PentasMap();
				cellIterator =  rowIterator.next().cellIterator();
				
				int i = 0;
				while(cellIterator.hasNext()) {
					rowinfo.put(i, getCellValue(cellIterator.next()));
					i++;
				}
				rowList.add(rowinfo);
			}
			return rowList;
		} catch (IOException e) {
			log.error(getExceptionStackTrace(e));
			throw new UserBizException("엑셀정보를 가져오는중 에러가 발생했습니다.");
		}
	}
	
	public static ExcelUpInfo parseExcel2007(MultipartFile excelFile){
		String filePath = StringUtil.join(System.getProperty("java.io.tmpdir"), UuidUtil.getUuidOnlyString());
		
		try(FileOutputStream fo = new FileOutputStream(new File(filePath));
				FileInputStream fi = new FileInputStream(new File(filePath));
				){
			fo.write(excelFile.getBytes());
			
			XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fi);
			Iterator<Row> rowIterator = xssfWorkbook.getSheetAt(0).iterator();
			Iterator<Cell> cellIterator;
			
			ExcelUpInfo rowList = new ExcelUpInfo();
			while(rowIterator.hasNext()) {					
				PentasMap rowinfo = new PentasMap();
				cellIterator =  rowIterator.next().cellIterator();
				
				int i = 0;
				while(cellIterator.hasNext()) {
					rowinfo.put(i, getCellValue(cellIterator.next()));
					i++;
				}
				rowList.add(rowinfo);
			}

			return rowList;
		} catch (IOException e) {
			log.error(getExceptionStackTrace(e));
			throw new UserBizException("엑셀정보를 가져오는중 에러가 발생했습니다.");
		}
	}
	
	public static void shellCmd(String command) {
		log.info(">>> 명령어 : " + command);
		Runtime runtime = Runtime.getRuntime();
		Process process;
		try {
			process = runtime.exec(command);
		} catch (IOException e1) {
			log.error(CmmnUtil.getExceptionStackTrace(e1));
			return;
		}
		try(InputStream is = process.getInputStream();
				InputStreamReader isr = new InputStreamReader(is);
				BufferedReader br = new BufferedReader(isr);){

	        String line;
	        while((line = br.readLine()) != null) {
//	                       log.info(line);
	        }
		} catch (Exception e) {
			log.error(CmmnUtil.getExceptionStackTrace(e));
		} finally {
			try {
				process.waitFor();
			} catch (InterruptedException e) {
				log.error(CmmnUtil.getExceptionStackTrace(e));
			}
			process.destroy();
			
		}
        
	}
	
	public static String convertSqlInQuery(List<String> category) {
		StringBuilder sb = new StringBuilder();
		for(String str : category) {
			sb.append("'").append(str).append("',");
		}
		sb.deleteCharAt(sb.length()-1);
		return sb.toString();
	}
	
	public static void setLoginSession(HttpSession session, MemberVO memberVO) {
		session.setAttribute("USR_ID", memberVO.getId());
		session.setAttribute("USR_LOGID", memberVO.getUsrLogId());
		session.setAttribute("USR_PRMS", memberVO.getUsrPrms());
        session.setAttribute("USR_NAME", memberVO.getUsrName());
	}
	
	public static void clearLoginSession(HttpSession session) {
		session.setAttribute("USR_ID", null);
		session.setAttribute("USR_LOGID", null);
		session.setAttribute("USR_PRMS", null);
		session.setAttribute("USR_NAME", null);
	}
	
	public static int getStartCurNum(PageList<PentasMap> pageList) {
		Paginator paginator = pageList.getPaginator();
		int page = paginator.getPage();
		int totalCount = paginator.getTotalCount();
		int limit = paginator.getLimit();
		
		return totalCount - ((page-1) * limit);
	}
	
	/**
	 * 날짜 관련 검증 유틸.
	 * @param startDt 			조회 시작일
	 * @param endDt 			조회 종료일
	 * @param futureDates 		오늘 이후 조회 허용여부
	 * @return
	 */
	public static boolean validateDates(String startDt, String endDt, boolean futureDates) {
		if (startDt == null || startDt.isEmpty()) {
			throw new UserBizException("시작일을 입력해주세요.");
		}
		if (endDt == null || endDt.isEmpty()) {
			throw new UserBizException("종료일을 입력해주세요.");
		}
		
		int startDtInt = Integer.parseInt(startDt.replaceAll("-", ""));
		int endDtInt = Integer.parseInt(endDt.replaceAll("-", ""));
		if (startDtInt > endDtInt) {
			throw new UserBizException("시작일은 종료일보다 이전이어야합니다.");
		}
		
		if (!futureDates) {
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
			int todayDt = Integer.parseInt(format.format(new Date()));
			if (startDtInt > todayDt || endDtInt > todayDt) {
				throw new UserBizException("조회일은 오늘보다 이전이어야합니다.");
			}
		}
		
		return true;
	}
}
