package common.config.handler;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import org.springframework.core.MethodParameter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.mvc.method.annotation.RequestResponseBodyMethodProcessor;

import common.utils.common.PentasMap;
import common.utils.json.JsonUtil;
import common.utils.mybatis_paginator.domain.PageList;
import common.utils.mybatis_paginator.domain.Paginator;

public class PentasReturnValueHandler implements HandlerMethodReturnValueHandler {

	@Override
	public boolean supportsReturnType(MethodParameter returnType) {
		Class<?> parameterType = returnType.getParameterType();
		if(PageList.class.isAssignableFrom(parameterType) 
				|| List.class.isAssignableFrom(parameterType)
				|| PentasMap.class.isAssignableFrom(parameterType)
				|| String.class.isAssignableFrom(parameterType)
				|| "void".equals(parameterType.getName())
				) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public void handleReturnValue(Object returnValue, MethodParameter returnType, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest) throws Exception {
		
		Class<?> parameterType = returnType.getParameterType();
		
		if(returnType.hasMethodAnnotation(ResponseBody.class)) {
			StringHttpMessageConverter converter = new StringHttpMessageConverter();
			converter.setDefaultCharset(Charset.forName("utf-8"));
			
			mavContainer.setRequestHandled(false);
			
	    	List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    	converters.add(converter);
	    	
	    	RequestResponseBodyMethodProcessor handler = new RequestResponseBodyMethodProcessor(converters);
	    	
	    	if(String.class.isAssignableFrom(parameterType)) {
		    	handler.handleReturnValue(returnValue, returnType, mavContainer, webRequest);
	    	} else {
		    	handler.handleReturnValue(JsonUtil.toJsonStr(returnValue), returnType, mavContainer, webRequest);
	    	}
	    	
		} else if(PageList.class.isAssignableFrom(parameterType)) {
			
			PageList pageList = (PageList) returnValue;
			Paginator pageInfo = pageList.getPaginator();
			
			PentasMap rslt = new PentasMap();
			rslt.put("list", pageList);
			rslt.put("pageInfo", pageInfo);
	
			returnValue = JsonUtil.toJsonStr(rslt);
			
			StringHttpMessageConverter converter = new StringHttpMessageConverter();
			converter.setDefaultCharset(Charset.forName("utf-8"));
			
			mavContainer.setRequestHandled(false);
			
	    	List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    	converters.add(converter);
	    	
	    	RequestResponseBodyMethodProcessor handler = new RequestResponseBodyMethodProcessor(converters);
	    	handler.handleReturnValue(returnValue, returnType, mavContainer, webRequest);
		} else if(List.class.isAssignableFrom(parameterType)) {
			List rslt = (List) returnValue;
			returnValue = JsonUtil.toJsonStr(rslt);
			
			StringHttpMessageConverter converter = new StringHttpMessageConverter();
			converter.setDefaultCharset(Charset.forName("utf-8"));
			
			mavContainer.setRequestHandled(false);
			
	    	List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    	converters.add(converter);
	    	
	    	RequestResponseBodyMethodProcessor handler = new RequestResponseBodyMethodProcessor(converters);
	    	handler.handleReturnValue(returnValue, returnType, mavContainer, webRequest);
		} else if(PentasMap.class.isAssignableFrom(parameterType)) {
			
			returnValue = JsonUtil.toJsonStr(returnValue);
			
			StringHttpMessageConverter converter = new StringHttpMessageConverter();
			converter.setDefaultCharset(Charset.forName("utf-8"));
			
			mavContainer.setRequestHandled(false);
			
	    	List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    	converters.add(converter);
	    	
	    	RequestResponseBodyMethodProcessor handler = new RequestResponseBodyMethodProcessor(converters);
	    	handler.handleReturnValue(returnValue, returnType, mavContainer, webRequest);
	    	
		} else if(String.class.isAssignableFrom(parameterType)) {
			mavContainer.setView(returnValue);
		} else if("void".equals(parameterType.getName())) {
			
			StringHttpMessageConverter converter = new StringHttpMessageConverter();
			converter.setDefaultCharset(Charset.forName("utf-8"));
			
			mavContainer.setRequestHandled(false);
			
	    	List<HttpMessageConverter<?>> converters = new ArrayList<HttpMessageConverter<?>>();
	    	converters.add(converter);
	    	
	    	RequestResponseBodyMethodProcessor handler = new RequestResponseBodyMethodProcessor(converters);
	    	handler.handleReturnValue("", returnType, mavContainer, webRequest);
		}
		
		
	}

}