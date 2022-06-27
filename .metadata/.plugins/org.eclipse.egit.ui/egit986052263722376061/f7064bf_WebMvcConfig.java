package common.config.servlet_context;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.mobile.device.DeviceHandlerMethodArgumentResolver;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import common.interceptor.CustomInterceptor;
import common.utils.excel.Excel2007CommonViewModule;
import common.utils.excel.ExcelCommonViewModule;

@Configuration
@EnableAspectJAutoProxy(proxyTargetClass = true) // 이걸 안해주면 Servlet Context 쪽 bean 에는 aop 트랜잭션이 먹히질 안는다.
@ComponentScan(basePackages = {"pentas"})
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