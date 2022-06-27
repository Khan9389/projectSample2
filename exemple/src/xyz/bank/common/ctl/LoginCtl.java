package xyz.bank.common.ctl;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mobile.device.Device;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.FlashMap;

import common.springsecurity.MemberVO;
import common.utils.common.CmmnUtil;
import common.utils.string.StringUtil;

@Controller
public class LoginCtl {
	
	public static final Map<String, String> login_sessions = new HashMap<>();
	
//	@GetMapping("/login")
//	public String openPage(HttpSession session, Device device) {
//		CmmnUtil.clearLoginSession(session);
//		SecurityContextHolder.clearContext();
//
//		if(device.isMobile()) {
//			return "groupware/mo/login";
//		} else {
//		return "/";
//		//}
//	}
//	
	@GetMapping("/afterLoginProc")
	public String afterLoginProc(HttpSession session, HttpServletRequest request, FlashMap flashMap) {
		
		MemberVO memberVO = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(!StringUtil.equals(memberVO.getMbrPw(), memberVO.getInputMbrPw())) {
			flashMap.put("loginStat", "LOGIN_FAIL");
			return "redirect:/";
		}
		
		CmmnUtil.setLoginSession(session, memberVO);
		
//		Enumeration se = session.getAttributeNames();
//		
//		while(se.hasMoreElements()){
//			String getse = se.nextElement()+"";
//		}
		
		if(memberVO.getMbrTyp().equals("A")) {
			return "redirect:/admin/cusMng";
		}
		
		
        return "redirect:/";
    }
	
	@RequestMapping("/loginFail")
    public String loginFail(HttpSession session, HttpServletRequest request, FlashMap flashMap) {
		CmmnUtil.clearLoginSession(session);
        
        flashMap.put("loginStat", "LOGIN_FAIL");
        return "redirect:/";
    }
	
	@RequestMapping("/logoutProc")
    public String logoutProc(HttpSession session, HttpServletRequest request, FlashMap flashMap) {
		CmmnUtil.clearLoginSession(session);
        SecurityContextHolder.clearContext();
        
        return "redirect:/";
    }
}
