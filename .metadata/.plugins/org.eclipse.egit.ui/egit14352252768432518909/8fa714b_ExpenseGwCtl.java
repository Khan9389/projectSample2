package pentas.groupware.ctl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/groupware/expense")
@Controller
public class ExpenseGwCtl {
	
	@RequestMapping({"/", ""})
	public String expense() {
		return "groupware/expense";
	}

}
