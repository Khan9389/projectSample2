package common.config.web_init;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.mobile.device.DeviceResolverRequestFilter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.multipart.support.MultipartFilter;
import org.springframework.web.servlet.DispatcherServlet;

import common.config.servlet_context.WebMvcConfig;
import common.listner.CustomSessionListner;
import common.utils.security.XSSFilter;

public class JavaWebApplicationInitializer implements WebApplicationInitializer {
	
	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		// root context 설정 
		AnnotationConfigWebApplicationContext rootAppContext = new AnnotationConfigWebApplicationContext();
		rootAppContext.scan("common.config.root_context");
		servletContext.addListener(new ContextLoaderListener(rootAppContext));
		servletContext.addListener(new CustomSessionListner()); // 세션 생성 및 소멸 리스너
		servletContext.addListener(new RequestContextListener()); // spring security 의 authenticationprovider 에서도 request 를 가져올수 있게 하기 위해
		
		// servlet context 설정
		AnnotationConfigWebApplicationContext servletAppContext = new AnnotationConfigWebApplicationContext();
		servletAppContext.register(WebMvcConfig.class);
		DispatcherServlet dispatcherServlet = new DispatcherServlet(servletAppContext);
		dispatcherServlet.setThrowExceptionIfNoHandlerFound(true); // 등록되지 않은 url로 접근할 시 NoHandlerFoundException 을 발생
		ServletRegistration.Dynamic servlet = servletContext.addServlet("dispatcher", dispatcherServlet);
		servlet.setLoadOnStartup(1);
		servlet.addMapping("/");
		
		// encodingFilter 설정
		FilterRegistration.Dynamic encodingFilter = servletContext.addFilter("encodingFilter", CharacterEncodingFilter.class);
		encodingFilter.setInitParameter("encoding", "UTF-8");
		encodingFilter.addMappingForServletNames(null, false, "dispatcher");
		
		// 스프링시큐리티용 설정
		FilterRegistration.Dynamic securityFilter = servletContext.addFilter("springSecurityFilterChain", DelegatingFilterProxy.class);
		securityFilter.addMappingForUrlPatterns(null, false, "/*");
		
		// 멀티파트 필터
		FilterRegistration.Dynamic multipartFilter = servletContext.addFilter("multipartFilter", MultipartFilter.class);
		multipartFilter.setInitParameter("multipartResolverBeanName", "multipartResolver");
		multipartFilter.addMappingForUrlPatterns(null, false, "/*");
		
		// Cross-Site Scripting 필터
		FilterRegistration.Dynamic xssFilter = servletContext.addFilter("xssFilter", XSSFilter.class);
		xssFilter.addMappingForUrlPatterns(null, false, "/*");
		
		// 접속기기 해석필터
		FilterRegistration.Dynamic devicefilter = servletContext.addFilter("deviceResolverRequestFilter", DeviceResolverRequestFilter.class);
		devicefilter.addMappingForUrlPatterns(null, false, "/*");
	}

}
