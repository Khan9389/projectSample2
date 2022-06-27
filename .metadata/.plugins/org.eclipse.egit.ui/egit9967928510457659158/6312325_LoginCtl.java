package pentas.common.ctl;

import java.security.Principal;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import common.springsecurity.MemberVO;
import common.utils.common.CmmnUtil;
import common.utils.common.PentasMap;
import common.utils.string.StringUtil;

@Controller
public class LoginCtl {
	
	public static final Map<String, String> login_sessions = new HashMap<>();
	
	@GetMapping("/login")
	public String openPage(HttpSession session) {
		CmmnUtil.clearLoginSession(session);
        SecurityContextHolder.clearContext();
		return "groupWare/login";
	}
	
	@GetMapping("/afterLoginProc")
	public String afterLoginProc(HttpSession session, HttpServletRequest request, FlashMap flashMap) {
		System.out.println("afterLoginProc ###################");
		MemberVO memberVO = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		String USR_PW = memberVO.getUsrPw();
		String inputPwdNo = memberVO.getInputPwdNo();
		
		if(!StringUtil.equals(USR_PW, inputPwdNo)) {
			flashMap.put("loginStat", "FAIL_PW_ERR");
			return "redirect:/login";
		}
		
		CmmnUtil.setLoginSession(session, memberVO);
		
		Enumeration se = session.getAttributeNames();
		
		while(se.hasMoreElements()){
			String getse = se.nextElement()+"";
			System.out.println("@@@@@@@ session : "+getse+" : "+session.getAttribute(getse));
		}
		
        return "redirect:/groupware/main";
    }
	
	@RequestMapping("/loginFail")
    public String loginFail(HttpSession session, HttpServletRequest request, FlashMap flashMap) {
		
		System.out.println("loginFail ###################");
		
		CmmnUtil.clearLoginSession(session);
        
        flashMap.put("loginStat", "FAIL");
        return "redirect:/login";
    }
	
	@RequestMapping("/logoutProc")
    public String logoutProc(HttpSession session, HttpServletRequest request, FlashMap flashMap) {
		
		CmmnUtil.clearLoginSession(session);
        SecurityContextHolder.clearContext();
        
        return "redirect:/groupware";
    }
}
