package common.config.root_context;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.RestController;

import common.utils.common.ApplicationContextProvider;

@Configuration
@EnableAsync
@ComponentScan(basePackages = {"common","k_chemicals"},
	excludeFilters = {
			@Filter(type = FilterType.ANNOTATION, value = Controller.class),
			@Filter(type = FilterType.ANNOTATION, value = RestController.class),
			@Filter(type = FilterType.ANNOTATION, value = ControllerAdvice.class)
	}
)
@PropertySources({
	@PropertySource({"classpath:common/config/properties/setting_${action.mode}.properties"})
})
public class CommonConfig {
	
	@Bean
	public PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
		return new PropertySourcesPlaceholderConfigurer();
	}
	
	@Bean
	ApplicationContextProvider applicationContextProvider() {
		return new ApplicationContextProvider();
	}

}
