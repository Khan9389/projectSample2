package xyz.bank.common.ctl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.PentasMap;
import common.utils.common.PentasMapBuilder;
import xyz.bank.common.svc.CommonSvc;

@Controller
public class CommonCtl {

	@Autowired
	CommonSvc commonSvc;
	
	/**
	 * 첨부파일다운로드
	 * @param STOR_FILE_NM 실제저장된 파일명
	 * @param response
	 */
	@RequestMapping("/fileDn")
	public void fileDn(HttpServletRequest request, HttpServletResponse response) {
		String p = request.getParameter("p");
		commonSvc.attachmentDownload(p, response);
	}
	
	@RequestMapping("/getFileOrgNm")
	public PentasMap getFileOrgNm(PentasMap params) {
		String FILE_STOR_NAME = params.getString("FILE_STOR_NAME");
		PentasMap fileInfo = commonSvc.getFileInfo(FILE_STOR_NAME);
		
		return new PentasMapBuilder()
				.put("FILE_ORIG_NAME", fileInfo.getString("FILE_ORIG_NAME"))
				.put("FILE_ORIG_EXT", fileInfo.getString("FILE_ORIG_EXT"))
				.build();
	}
	
	@RequestMapping("/chkFileExist")
	public PentasMap chkFileExist(PentasMap params) {
		boolean isFileExist = commonSvc.chkFileExist(params);
		
		return new PentasMapBuilder()
				.put("isFileExist", isFileExist)
				.put("rsltStatus", "SUCC")
				.build();
	}

}
