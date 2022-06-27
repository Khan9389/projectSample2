package common.config.servlet_context;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.mobile.device.DeviceHandlerMethodArgumentResolver;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;
import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import common.config.handler.PentasReturnValueHandler;
import common.config.resolver.CustomPathVariableMethodArgumentResolver;
import common.config.resolver.PentasArgumentResolver;
import common.interceptor.CustomInterceptor;
import common.utils.excel.Excel2007CommonViewModule;
import common.utils.excel.ExcelCommonViewModule;

@Configuration
@ComponentScan(basePackages = {"xyz"},
includeFilters = {
		@Filter(type = FilterType.ANNOTATION, value = Controller.class),
		@Filter(type = FilterType.ANNOTATION, value = RestController.class),
		@Filter(type = FilterType.ANNOTATION, value = ControllerAdvice.class)
},
excludeFilters = {
		@Filter(type = FilterType.ANNOTATION, value = Service.class),
		@Filter(type = FilterType.ANNOTATION, value = Repository.class),
}
)
public class WebMvcConfig extends WebMvcConfigurationSupport {

	@Autowired
	CustomInterceptor customInterceptor;
	
	@Override
	protected void addInterceptors(InterceptorRegistry registry) {
		registry
			.addInterceptor(customInterceptor)
			.addPathPatterns("/**")
			.excludePathPatterns("/static_resources/**")
			.excludePathPatterns("/upload/**"); // interceptor 예외처리대상
	}
	
	@Override
	protected void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry
			.addResourceHandler("/static_resources/**")
			.addResourceLocations("/static_resources/");
		registry
			.addResourceHandler("/upload/**")
			.addResourceLocations("/upload/");
	}
	
	@Override
	public RequestMappingHandlerAdapter requestMappingHandlerAdapter() {
		
		RequestMappingHandlerAdapter adapter = super.requestMappingHandlerAdapter();
		List<HandlerMethodArgumentResolver> argumentResolvers = adapter.getCustomArgumentResolvers();
		argumentResolvers.add(0, new PentasArgumentResolver());
		argumentResolvers.add(1, new CustomPathVariableMethodArgumentResolver());
		
		
		// Annotation-based argument resolution 
//		argumentResolvers.add(new RequestParamMethodArgumentResolver(getBeanFactory(), false)); 
//		argumentResolvers.add(new RequestParamMapMethodArgumentResolver()); 
//		argumentResolvers.add(new PathVariableMethodArgumentResolver()); 
//		argumentResolvers.add(new PathVariableMapMethodArgumentResolver()); 
//		argumentResolvers.add(new MatrixVariableMethodArgumentResolver()); 
//		argumentResolvers.add(new MatrixVariableMapMethodArgumentResolver()); 
//		argumentResolvers.add(new ServletModelAttributeMethodProcessor(false)); 
//		argumentResolvers.add(new RequestResponseBodyMethodProcessor(getMessageConverters(), this.requestResponseBodyAdvice)); 
//		argumentResolvers.add(new RequestPartMethodArgumentResolver(getMessageConverters(), this.requestResponseBodyAdvice)); 
//		argumentResolvers.add(new RequestHeaderMethodArgumentResolver(getBeanFactory())); 
//		argumentResolvers.add(new RequestHeaderMapMethodArgumentResolver()); 
//		argumentResolvers.add(new ServletCookieValueMethodArgumentResolver(getBeanFactory())); 
//		argumentResolvers.add(new ExpressionValueMethodArgumentResolver(getBeanFactory())); 
//		argumentResolvers.add(new SessionAttributeMethodArgumentResolver()); 
//		argumentResolvers.add(new RequestAttributeMethodArgumentResolver()); 
		
		// Type-based argument resolution 
//		argumentResolvers.add(new ServletRequestMethodArgumentResolver()); 
//		argumentResolvers.add(new ServletResponseMethodArgumentResolver()); 
//		argumentResolvers.add(new HttpEntityMethodProcessor(getMessageConverters(), this.requestResponseBodyAdvice)); 
//		argumentResolvers.add(new RedirectAttributesMethodArgumentResolver()); 
//		argumentResolvers.add(new ModelMethodProcessor()); 
//		argumentResolvers.add(new MapMethodProcessor());
//		argumentResolvers.add(new ErrorsMethodArgumentResolver()); 
//		argumentResolvers.add(new SessionStatusMethodArgumentResolver()); 
//		argumentResolvers.add(new UriComponentsBuilderMethodArgumentResolver());
		
		adapter.setArgumentResolvers(argumentResolvers);
		
		List<HandlerMethodReturnValueHandler> returnValueHandlers = adapter.getCustomReturnValueHandlers();
		returnValueHandlers.add(0, new PentasReturnValueHandler());
		adapter.setReturnValueHandlers(returnValueHandlers);
		
		return adapter;
	}

	@Bean
	public DeviceHandlerMethodArgumentResolver deviceHandlerMethodArgumentResolver() {
	    return new DeviceHandlerMethodArgumentResolver();
	}
	
	@Override
	protected void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
		argumentResolvers.add(deviceHandlerMethodArgumentResolver());
	}
	
	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver bean = new CommonsMultipartResolver();
		bean.setDefaultEncoding("UTF-8");
		return bean;
	}
	
	@Bean(name = "excelView")
	public ExcelCommonViewModule excelCommonViewModule() {
		return new ExcelCommonViewModule();
	}
	
	@Bean(name = "excel2007View")
	public Excel2007CommonViewModule excel2007CommonViewModule() {
		return new Excel2007CommonViewModule();
	}
	
	@Bean
	public BeanNameViewResolver beanNameViewResolver() {
		BeanNameViewResolver beanNameViewResolver = new BeanNameViewResolver();
		beanNameViewResolver.setOrder(0);
		return beanNameViewResolver;
	}
	
	@Bean
	public InternalResourceViewResolver viewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setRedirectHttp10Compatible(false);
		viewResolver.setPrefix("/WEB-INF/jsp/");
		viewResolver.setSuffix(".jsp");
		viewResolver.setContentType("text/html; charset=UTF-8");
		viewResolver.setOrder(1);
		return viewResolver;
	}
}