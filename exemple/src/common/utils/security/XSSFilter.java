package common.utils.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class XSSFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		RequestWrapper requestWrapper = new RequestWrapper((HttpServletRequest)request);
		
		byte[] b = requestWrapper.getB();
		if(b==null) {
			chain.doFilter(request, response);
		} else {
			chain.doFilter(requestWrapper, response);	
		}		
	}

}
