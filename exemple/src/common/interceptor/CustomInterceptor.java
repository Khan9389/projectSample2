package common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import common.json.JsonUtil;
import common.utils.common.PentasMap;
import common.utils.string.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CustomInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		log.debug("Interceptor ===> preHandle");
		log.debug(StringUtil.join("URI ===> ", request.getRequestURI()));
		
//		HttpSession session = request.getSession();
//		
//		
//		String requestURI = StringUtil.defaultString(request.getRequestURI(), "");
//		String ID = StringUtil.defaultString((String) session.getAttribute("USR_ID"));
//		String url = "";
//		if(requestURI.length() >=9 ) {
//			url = requestURI.substring(1, 10);
//			
//			if(StringUtil.equalsAny(url, "groupware") && "".equals(ID)) {
//				response.sendRedirect("/login");
//			}
//		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//		log.debug("Interceptor ===> postHandle");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//		log.debug("Interceptor ===> afterCompletion");
	}
	
}
