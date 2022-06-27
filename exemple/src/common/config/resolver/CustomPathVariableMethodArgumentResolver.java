package common.config.resolver;

import java.util.HashMap;
import java.util.Map;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.method.annotation.PathVariableMethodArgumentResolver;

import common.exception.ResourceNotFoundException;


public class CustomPathVariableMethodArgumentResolver extends PathVariableMethodArgumentResolver {

	@Override
	protected void handleResolvedValue(Object arg, String name, MethodParameter parameter,
			ModelAndViewContainer mavContainer, NativeWebRequest request) {
		String key = View.PATH_VARIABLES;
		int scope = RequestAttributes.SCOPE_REQUEST;
		Map<String, Object> pathVars = (Map<String, Object>) request.getAttribute(key, scope);
		if (pathVars == null) {
			pathVars = new HashMap<>();
			request.setAttribute(key, pathVars, scope);
		}
	
	}

	@Override
	protected void handleMissingValue(String name, MethodParameter parameter) throws ServletRequestBindingException {
		throw new ResourceNotFoundException();
	}
}
