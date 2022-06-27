package pentas.common.ctl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonCtl {

	@RequestMapping("/")
	public String mainpage() {
		return "common/main";
	}
}
