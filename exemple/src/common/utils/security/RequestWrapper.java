package common.utils.security;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import common.utils.string.StringUtil;

/**
 * XSS 필터링 기능을 수행한다.
 */
public final class RequestWrapper extends HttpServletRequestWrapper {
	private byte[] b;
	public RequestWrapper(HttpServletRequest servletRequest) throws IOException {
		super(servletRequest);
		if (servletRequest.getContentType() != null && servletRequest.getContentType().indexOf("json") > -1) {
			b = cleanXSS(getBody(servletRequest)).getBytes();
		}
	}
	
	public byte[] getB() {
		return b;
	}
	
	@Override
	public String[] getParameterValues(String parameter) {

		String[] values = super.getParameterValues(parameter);
		if (values == null) {
			return null;
		}
		int count = values.length;
		String[] encodedValues = new String[count];
		for (int i = 0; i < count; i++) {
			encodedValues[i] = cleanXSS(values[i]);
		}
		return encodedValues;
	}

	@Override
	public String getParameter(String parameter) {
		String value = super.getParameter(parameter);
		if (value == null) {
			return null;
		}
		return cleanXSS(value);
	}

	public String getHeader(String name) {
		String value = super.getHeader(name);
		if (value == null){
			return null;
		}
		return cleanXSS(value);

	}

	private static String cleanXSS(String value) {		
		//String Util을 이용하여 XSS 처리를 수행한다.
		
		return StringUtil.encodeXSS(value);
	}
	
	@Override
	public ServletInputStream getInputStream() throws IOException {
		ByteArrayInputStream bis = new ByteArrayInputStream(b);
		return new ServletInputStreamImpl(bis);

	}

	class ServletInputStreamImpl extends ServletInputStream {
		private InputStream is;
		public ServletInputStreamImpl(InputStream bis) {
			is = bis;
		}

		public int read() throws IOException {
			return is.read();
		}

		public int read(byte[] b) throws IOException {
			return is.read(b);
		}

		@Override
		public boolean isFinished() {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public boolean isReady() {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public void setReadListener(ReadListener readListener) {
			// TODO Auto-generated method stub
			
		}

	}

	public static String getBody(HttpServletRequest request) throws IOException {

		BufferedReader input = new BufferedReader(new InputStreamReader(request.getInputStream()));
		StringBuilder builder = new StringBuilder();
		String buffer;
		while (true) {
			buffer = input.readLine();
			if(buffer == null) {
				break;
			}
			if (builder.length() > 0) {
				builder.append("\n");
			}
			builder.append(buffer);
		}
		
		//input.close();
		return builder.toString();
	}
	
	
	
}

