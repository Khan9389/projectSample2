package pentas.groupware.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import common.dao.CmmnDao;
import common.utils.common.MultipartFileList;
import common.utils.common.PentasMap;
import common.utils.uuid.UuidUtil;
import pentas.common.svc.CommonSvc;

@Service
public class MyInfoGwSvc {

	@Autowired
	CmmnDao cmmnDao;
	
	@Autowired
	CommonSvc commonSvc;
	
	public PentasMap getInfo(PentasMap params) {
		return cmmnDao.selectOne("groupWare.myInfo.getInfo", params);
	}
	
	public void updateInfo(MultipartFileList fileList, PentasMap params) {
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
		
		cmmnDao.update("groupWare.myInfo.updateInfo", params);
	}
	
	public void goChangePw(PentasMap params) {
		cmmnDao.update("groupWare.myInfo.goChangePw", params);
	}
}
