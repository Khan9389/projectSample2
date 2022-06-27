package pentas.groupware.ctl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.MultipartFileList;
import common.utils.common.PageInfo;
import common.utils.common.PentasMap;
import common.utils.common.PentasMapBuilder;
import common.utils.mybatis_paginator.domain.PageList;
import pentas.common.svc.CommonSvc;
import pentas.groupware.svc.MemberGwSvc;

@RequestMapping("/groupware/member")
@Controller
public class MemberGwCtl {
	
	@Autowired
	CommonSvc commonSvc;
	
	@Autowired
	MemberGwSvc memberSvc;
	
	@RequestMapping({"/", ""})
	public String member(Model model) {
		List<PentasMap> usrTypeList;
		usrTypeList = commonSvc.getComCode("USR_TYPE", "MINOR_CD_ORD", true);
		List<PentasMap> usrPrmsList;
		usrPrmsList = commonSvc.getComCode("USR_PRMS", "MINOR_CD_ORD", true);
		List<PentasMap> techLvList;
		techLvList = commonSvc.getComCode("TECH_LV", "MINOR_CD_ORD", true);
		
		model.addAttribute("usrTypeList", usrTypeList);
		model.addAttribute("usrPrmsList", usrPrmsList);
		model.addAttribute("techLvList", techLvList);
		return "groupware/member";
	}
	
	@RequestMapping("/duplId")
	public PentasMap duplId(PentasMap params) {
		return memberSvc.duplId(params);
	}
	
	// 파일 업로드 필요
	@RequestMapping("/saveInfo")
	public PentasMap saveInfo(MultipartFileList fileList, PentasMap params) {
		memberSvc.saveInfo(fileList, params);
		
		return new PentasMapBuilder()
				.put("rsltStatus","SUCC")
				.build();
	}
	
	@RequestMapping("/getList")
	public PageList<PentasMap> getList(PentasMap params, PageInfo pageInfo) {
		return memberSvc.getList(params, pageInfo);
	}
	
	@RequestMapping("/getInfo")
	public PentasMap getInfo(PentasMap params){		
		return memberSvc.getInfo(params);
	}
	
	@RequestMapping("goDelete")
	public PentasMap goDelete(PentasMap params) {
		memberSvc.goDelete(params);
		
		return new PentasMapBuilder()
				.put("rsltStatus","SUCC")
				.build();
	}
	
	@RequestMapping("/goChangePw")
	public PentasMap goChangePw(PentasMap params) {
		memberSvc.goChangePw(params);
		
		return new PentasMapBuilder()
				.put("rsltStatus","SUCC")
				.build();
	}
	
}
