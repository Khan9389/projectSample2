package xyz.bank.common.ctl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import common.exception.UserBizException;
import common.utils.common.CmmnUtil;
import common.utils.common.PentasMap;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice  
@Controller
@Slf4j
public class GlobalExceptionHandlerCtl {

    @ExceptionHandler(value = UserBizException.class) 
    @ResponseBody
    public PentasMap handleUserException(UserBizException e){
    	log.error("UserBizException ====> ");
    	log.error(CmmnUtil.getExceptionStackTrace(e));
    	
    	PentasMap rslt = new PentasMap();
    	rslt.put("rsltStatus", "user-error");
    	rslt.put("errMsg", e.getMessage());
    	
        return rslt;
    }
    
    @ExceptionHandler(value = Exception.class) 
    public PentasMap handleException(Exception e){
    	log.error("Exception ====> ");
    	log.error(CmmnUtil.getExceptionStackTrace(e));
    	
    	PentasMap rslt = new PentasMap();
    	rslt.put("rsltStatus", "sys-error");
    	rslt.put("errMsg", "처리중 오류가 발생했습니다. \n관리자에게 문의해 주세요.");
    	
        return rslt;
    }
    
}
