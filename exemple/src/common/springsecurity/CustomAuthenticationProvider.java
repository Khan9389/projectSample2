package common.springsecurity;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import common.dao.CmmnDao;
import common.utils.common.CmmnUtil;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	CmmnDao cmmnDao;
	
	@Autowired(required = false)
	HttpServletRequest request;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		HttpSession session = request.getSession();
		CmmnUtil.clearLoginSession(session);
		
		String mbrId = request.getParameter("mbrId");
		String inputMbrPw = request.getParameter("inputMbrPw");
		
		MemberVO memberVO = cmmnDao.selectOne("login.setMbrInfo", mbrId);
        if(memberVO == null) {
        	throw new BadCredentialsException("로그인 실패");
        }
        
        List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
        roles.add(new SimpleGrantedAuthority("ROLE_USER"));
        
        memberVO.setInputMbrPw(inputMbrPw);
        
		return new UsernamePasswordAuthenticationToken(memberVO, inputMbrPw, roles);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
