package xyz.bank.homepage.ctl;

import javax.servlet.http.HttpServletRequest;

import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/")
@Controller
public class MainCtl {
	
	@RequestMapping(value= {"/",""})
	public String main(HttpServletRequest request, Device device) {
		return "home/main";
	}

}
