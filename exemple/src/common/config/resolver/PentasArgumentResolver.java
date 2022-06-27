package common.config.resolver;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.MethodParameter;
import org.springframework.ui.Model;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.support.RequestContextUtils;

import common.utils.common.CmmnUtil;
//import common.utils.common.Device;
import common.utils.common.ExcelDownConfig;
import common.utils.common.ExcelUpInfo;
import common.utils.common.MultipartFileList;
import common.utils.common.PageInfo;
import common.utils.common.PentasMap;
import common.utils.json.JsonUtil;
import common.utils.string.StringUtil;

public class PentasArgumentResolver implements HandlerMethodArgumentResolver {

	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		Class<?> parameterType = parameter.getParameterType();
		if(MultipartFileList.class.isAssignableFrom(parameterType) 
				|| ExcelUpInfo.class.isAssignableFrom(parameterType)
				|| Map.class.isAssignableFrom(parameterType)
				|| Model.class.isAssignableFrom(parameterType)
				|| HttpServletRequest.class.isAssignableFrom(parameterType)
				|| HttpServletResponse.class.isAssignableFrom(parameterType)
				|| Principal.class.isAssignableFrom(parameterType)
//				|| Device.class.isAssignableFrom(parameterType)
				|| HttpSession.class.isAssignableFrom(parameterType)
				) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		
		Class<?> parameterType = parameter.getParameterType();
		
		if(MultipartFileList.class.isAssignableFrom(parameterType)) {	
			List<MultipartFile> fileList = webRequest.getNativeRequest(MultipartRequest.class).getFiles("fileList");
			MultipartFileList multipartFileList = new MultipartFileList();
			for(MultipartFile file : fileList) {
				multipartFileList.add(file);
			}
			return multipartFileList;
		} else if(Map.class.isAssignableFrom(parameterType)) {
			if(PageInfo.class.isAssignableFrom(parameterType)) {
				HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);
				
				String params =  CmmnUtil.getRequestBody(request);
				
				params = StringUtil.encodeXSS(params);
				
				
				Map map = (Map) JsonUtil.fromJsonStr(PentasMap.class, params).get("pageInfo");
				Set mapkeys = map.keySet();
				PageInfo pageInfo = new PageInfo();
				for(Object mapkey : mapkeys) {
					pageInfo.put(mapkey, map.get(mapkey));
				}
				return pageInfo;
			} else if(ExcelDownConfig.class.isAssignableFrom(parameterType)) {
				HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);
				
				String params = request.getParameter("config");
				
				params = StringUtil.encodeXSS(params);
				
				
				return JsonUtil.fromJsonStr(ExcelDownConfig.class, params);
			} else if(FlashMap.class.isAssignableFrom(parameterType)) {
				HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);
				return RequestContextUtils.getOutputFlashMap(request);
			} else if(PentasMap.class.isAssignableFrom(parameterType)) {
				HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);
				String params = request.getParameter("params");
				if(params != null) {
					
					params = StringUtil.encodeXSS(params);
					
					return JsonUtil.fromJsonStr(PentasMap.class, params);
				} else {
					String requestBody = CmmnUtil.getRequestBody(request);
					if(StringUtil.isEmpty(requestBody)) {
						return new PentasMap();
					} else {
						
						requestBody = StringUtil.encodeXSS(requestBody);
						
						return JsonUtil.fromJsonStr(PentasMap.class, requestBody);
					}
				}
			} else {
				return mavContainer.getModel();
			}
		}  else if(ExcelUpInfo.class.isAssignableFrom(parameterType)) {
			MultipartRequest mr = webRequest.getNativeRequest(MultipartRequest.class);
			MultipartFile excelFile = mr.getFiles("excelFile").get(0);
			return CmmnUtil.getExcelContents(excelFile);
		}  else if(Model.class.isAssignableFrom(parameterType)) {
			return mavContainer.getModel();
		} else if(HttpServletRequest.class.isAssignableFrom(parameterType)) {
			return webRequest.getNativeRequest(HttpServletRequest.class);
		} else if(HttpServletResponse.class.isAssignableFrom(parameterType)) {
			return webRequest.getNativeResponse(HttpServletResponse.class);
		} else if(Principal.class.isAssignableFrom(parameterType)) {
			return webRequest.getUserPrincipal();
//		} else if(Device.class.isAssignableFrom(parameterType)) {
//			HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);
//			String deviceType = StringUtil.defaultString((String) request.getSession().getAttribute("deviceType"), "pc");
//			Device device = new Device();
//			device.setType(deviceType);
//			return device;
		} else if(HttpSession.class.isAssignableFrom(parameterType)) {
			return webRequest.getNativeRequest(HttpServletRequest.class).getSession();
		} 
		return null;
	}

}
