package pentas.groupware.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import common.dao.CmmnDao;
import common.exception.UserBizException;
import common.utils.common.CmmnUtil;
import common.utils.common.MultipartFileList;
import common.utils.common.PageInfo;
import common.utils.common.PentasMap;
import common.utils.crypt.CryptUtil;
import common.utils.mybatis_paginator.domain.PageList;
import common.utils.string.StringUtil;
import common.utils.uuid.UuidUtil;
import pentas.common.svc.CommonSvc;

@Service
public class MemberGwSvc {

	@Autowired
	CmmnDao cmmnDao;
	
	@Autowired
	CommonSvc commonSvc;
	
	public PentasMap duplId(PentasMap params) {
		return cmmnDao.selectOne("groupWare.member.duplId", params);
	}
	
	public void saveInfo(MultipartFileList fileList, PentasMap params) {
		
		List<String> upfileIds = (List<String>) params.get("upfileIds");
		//String uploadRelativePath = StringUtil.join("/upload/", CmmnUtil.getTodayString().substring(0,6), '/');
		String uploadRelativePath = "/user/";
		String fileUseTable = (String) params.get("fileUseTable");
		int idx = 0;
		for(MultipartFile file : fileList) {
			String docType = file.getContentType();
			
			PentasMap fileInfo = commonSvc.uploadFile(file, uploadRelativePath, fileUseTable);
			params.put(upfileIds.get(idx), fileInfo.getString("FILE_STOR_NAME"));
			
			idx++;
		}
		
		if(params.getString("ID").equals("")) {
			String ID = UuidUtil.getUuidOnlyString();
			params.put("ID", ID);
			cmmnDao.insert("groupWare.member.saveInfo", params);
		}else {
			cmmnDao.update("groupWare.member.updateInfo", params);
		}
	}
	
	public PageList<PentasMap> getList(PentasMap params, PageInfo pageInfo) {
		PageList<PentasMap> pageList = cmmnDao.selectListPage("groupWare.member.getList", params, pageInfo);
		
		return pageList;
	}
	
	public PentasMap getInfo(PentasMap params) {
		return cmmnDao.selectOne("groupWare.member.getInfo", params);
	}
	
	public void goDelete(PentasMap params) {
		List<String> idList = (List<String>) params.get("idList");
		
		for(int i = 0; i < idList.size(); i++) {
			params.put("ID", idList.get(i));
			cmmnDao.update("groupWare.member.goDelete", params);
		}
	}
	
	public void goChangePw(PentasMap params) {
		cmmnDao.update("groupWare.member.goChangePw", params);
	}
	
}