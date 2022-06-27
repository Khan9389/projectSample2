package pentas.common.svc;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import common.config.properties.SettingProperties;
import common.dao.CmmnDao;
import common.exception.UserBizException;
import common.utils.common.CmmnUtil;
import common.utils.common.Constant;
import common.utils.common.PentasMap;
import common.utils.common.PentasMapBuilder;
import common.utils.string.StringUtil;
import common.utils.uuid.UuidUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommonSvc {

	@Autowired
	HttpServletRequest request;

	@Autowired
	SettingProperties settingProperties;

	@Autowired
	CommonCacheSvc commonCacheSvc;

	@Autowired
	CmmnDao cmmnDao;

	/**
	 * 파일을 실제로 저장하는 함수
	 * 
	 * @param multipartFile
	 * @param uploadRelativePath 업로드할 루트경로의 상대경로
	 * @return
	 */
	public PentasMap uploadFile(MultipartFile multipartFile, String uploadRelativePath) {

		String uploadPath = StringUtil.join(settingProperties.getUploadRootPath(), uploadRelativePath); // 파일저장경로
		File filePath = new File(uploadPath);
		if (!filePath.exists()) {
			filePath.mkdirs();
			if (!StringUtil.equals("local_win", settingProperties.getRunEnv())) {
				try {
					CmmnUtil.shellCmd("chmod 774 " + uploadPath);
				} catch (Exception e) {
					log.error(CmmnUtil.getExceptionStackTrace(e));
				}
				
			}
		}

		String CONTENT_TYPE = multipartFile.getContentType();
		String storFileNm = UuidUtil.getUuidOnlyString(); // 저장파일명
		String orgFileNm = multipartFile.getOriginalFilename(); // 원시파일명
		orgFileNm = orgFileNm.replaceAll(" ", "_");

		log.debug(">>> CONTENT_TYPE : " + CONTENT_TYPE);

		String fileExt = orgFileNm.substring(orgFileNm.lastIndexOf(".") + 1); // 파일확장자
		if (fileExt.length() < 3 || fileExt.length() > 4) {
			throw new UserBizException("업로드가 불가한 파일입니다.");
		}

		String[] fileExtArry = settingProperties.getUploadDenyExtList().split(",");
		for (String str : fileExtArry) {
			if (str.equalsIgnoreCase(fileExt)) {
				throw new UserBizException("확장자(" + fileExt + ")파일은 업로드가 불가합니다.");
			}
		}

		String uploadMaxSize;
		if ("mp4".equalsIgnoreCase(fileExt)) {
			uploadMaxSize = settingProperties.getUploadVideoMaxSize(); // 동영상 파일업로드 최대사이즈
		} else {
			uploadMaxSize = settingProperties.getUploadMaxSize(); // 파일업로드 최대사이즈
		}
		long fileSize = multipartFile.getSize(); // 파일크기

		if (fileSize > Long.parseLong(uploadMaxSize)) {
			if("mp4".equalsIgnoreCase(fileExt)) {
				throw new UserBizException("업로드 파일크기가 150MB를 초과할 수 없습니다.");
			}else {
				throw new UserBizException("업로드 파일크기가 10MB를 초과할 수 없습니다.");
			}
			/*throw new UserBizException(StringUtil.join("업로드 파일크기가 ",
					uploadMaxSize.substring(0, uploadMaxSize.length() - 6), "MByte를 초과할 수 없습니다."));*/
		}

		String fileFullPath = StringUtil.join(uploadPath, storFileNm);
		File file = new File(fileFullPath);
		try {
			multipartFile.transferTo(file);
			if (!StringUtil.equals("local_win", settingProperties.getRunEnv())) {
				
				CmmnUtil.shellCmd("chmod 644 " + fileFullPath);
			}
		} catch (Exception e) {
			log.error(CmmnUtil.getExceptionStackTrace(e));
			throw new UserBizException("파일업로드를 실패했습니다.");
		}

		HttpSession session = request.getSession();
		String USR_ID = StringUtil.defaultString((String) session.getAttribute("USR_ID"), "NO_USER");

		PentasMap fileInfo = new PentasMap();
		fileInfo.put("STOR_FILE_NM", storFileNm);
		fileInfo.put("FILE_EXT", fileExt);
		fileInfo.put("UPLOAD_PATH", uploadPath);
		fileInfo.put("ORG_FILE_NM", orgFileNm);
		fileInfo.put("FILE_SIZE", fileSize);
		fileInfo.put("CONTENT_TYPE", CONTENT_TYPE);
		fileInfo.put("USR_ID", USR_ID);

		// 파일메타정보를 관리하는 테이블에 해당정보를 삽입
		cmmnDao.insert("common.insertFileInfo", fileInfo);

		return fileInfo;
	}

	/**
	 * 첨부파일 다운로드 함수
	 * 
	 * @param STOR_FILE_NM 실제저장된 파일명
	 * @param response
	 */
	public void attachmentDownload(String STOR_FILE_NM, HttpServletResponse response) {

		PentasMap fileInfo = cmmnDao.selectOne("common.selectFileInfo", STOR_FILE_NM);

		String UPLOAD_PATH = fileInfo.getString("UPLOAD_PATH");
		String fileFullPath = new StringBuilder()
				.append(UPLOAD_PATH)
				.append(STOR_FILE_NM)
				.toString();

		File file = new File(fileFullPath);

		String ORG_FILE_NM = fileInfo.getString("ORG_FILE_NM");
		try {
			ORG_FILE_NM = URLEncoder.encode(ORG_FILE_NM, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			log.error(CmmnUtil.getExceptionStackTrace(e));
			throw new UserBizException("파일다운로드중 오류가 발생했습니다.");
		}

		String contentDisposition = StringUtil.join("attachment; filename=\"", ORG_FILE_NM, "\";");

		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", contentDisposition);

		String fileExt = ORG_FILE_NM.substring(ORG_FILE_NM.lastIndexOf(".") + 1); // 파일확장자
		if ("gif".equalsIgnoreCase(fileExt)) {
			response.setContentType("image/gif");
		} else if ("png".equalsIgnoreCase(fileExt)) {
			response.setContentType("image/png");
		} else if ("jpeg".equalsIgnoreCase(fileExt) || "jpg".equalsIgnoreCase(fileExt)) {
			response.setContentType("image/jpeg");
		} else if ("bmp".equalsIgnoreCase(fileExt)) {
			response.setContentType("image/bmp");
		} else if ("pdf".equalsIgnoreCase(fileExt)) {
			response.setContentType("application/pdf");
		} else {
			response.setContentType("application/octet-stream");
		}

		byte[] b = new byte[1000000];
		try (BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream())) {
			int read = 0;

			while (true) {
				read = fin.read(b);
				if (read == -1) {
					break;
				}
				outs.write(b, 0, read);
			}
		} catch (Exception e) {
			log.error(CmmnUtil.getExceptionStackTrace(e));

			try (BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());) {
				outs.write(Base64.decodeBase64(Constant.NOIMAGE));
			} catch (IOException e1) {
				log.error(CmmnUtil.getExceptionStackTrace(e1));
			}
			;
		}
	}

	/**
	 * 업로드된 파일을 삭제하는 함수
	 * 
	 * @param STOR_FILE_NM
	 */
	public void deleteFile(String STOR_FILE_NM) {
		PentasMap fileInfo = cmmnDao.selectOne("common.selectFileInfo", STOR_FILE_NM);

		String UPLOAD_PATH = fileInfo.getString("UPLOAD_PATH");
		String fileFullPath = new StringBuilder()
				.append(UPLOAD_PATH)
				.append(STOR_FILE_NM)
				.toString();

		File file = new File(fileFullPath);
		if (!file.exists() || !file.isFile()) {
			throw new UserBizException("파일이 존재하지 않습니다.");
		}
		file.delete();

		HttpSession session = request.getSession();
		String USR_ID = StringUtil.defaultString((String) session.getAttribute("USR_ID"), "NO_USER");

		// 파일메타정보를 관리하는 테이블에 해당정보를 업데이트
		PentasMap params = new PentasMapBuilder().put("USR_ID", USR_ID).put("STOR_FILE_NM", STOR_FILE_NM).build();

		cmmnDao.update("common.deleteFileInfo", params);
	}

	public boolean chkFileExist(PentasMap params) {
		String STOR_FILE_NM = params.getString("STOR_FILE_NM");
		PentasMap fileInfo = cmmnDao.selectOne("common.selectFileInfo", STOR_FILE_NM);
		if (fileInfo == null) {
			return false;
		}

		String UPLOAD_PATH = fileInfo.getString("UPLOAD_PATH");
		String fileFullPath = new StringBuilder()
				.append(UPLOAD_PATH)
				.append(STOR_FILE_NM)
				.toString();

		File file = new File(fileFullPath);
		if (!file.exists() || !file.isFile()) {
			return false;
		}

		return true;
	}

	public PentasMap getFileInfo(String STOR_FILE_NM) {
		return cmmnDao.selectOne("common.selectFileInfo", STOR_FILE_NM);
	}

	/**
	 * 공통코드 가져오는 함수, 정렬기준은 SORT_NO 칼럼의 오름차순
	 * 
	 * @param COM_CD_MST
	 * @return
	 */
	public List<PentasMap> getComCode(String COM_CD_MST) {
		Comparator<PentasMap> comparator = Comparator.comparing((m -> m.getString("SORT_NO")));

		List<PentasMap> rslt = commonCacheSvc.getComCodeCache().stream()
				.filter(p -> p.getString("COM_CD_MST").equals(COM_CD_MST))
				.filter(p -> p.getString("USE_YN").equals("Y")).sorted(comparator).collect(Collectors.toList());
		return rslt;
	}

	/**
	 * 공통코드 가져오는 함수
	 * 
	 * @param MAJOR_CD_ID
	 * @param sortTarget 정렬기준칼럼명 (MAJOR_CD_ORM 또는 MINOR_CD 또는 MINOR_NM)
	 * @param isAsc      오름차순여부
	 * @return
	 */
	public List<PentasMap> getComCode(String MAJOR_CD_ID, String sortTarget, boolean isAsc) {
		Comparator<PentasMap> comparator;
		if (sortTarget.equals("MINOR_CD_ORD")) {
			comparator = Comparator.comparing((m -> m.getInt(sortTarget)));
		} else {
			comparator = Comparator.comparing((m -> m.getString(sortTarget)));
		}
		
		Comparator<PentasMap> finalComparator;
		if (isAsc) {
			finalComparator = comparator;
		} else {
			finalComparator = comparator.reversed();
		}
		
		List<PentasMap> rslt = commonCacheSvc.getComCodeCache().stream()
				.filter(p -> p.getString("MAJOR_CD_ID").equals(MAJOR_CD_ID))
				.filter(p -> p.getString("DEL_YN").equals("N")).sorted(finalComparator).collect(Collectors.toList());
		return rslt;
	}

	public String getComCodeMajor(String MAJOR_CD_ID) {
		return cmmnDao.selectOne("common.getComCodeMajor", MAJOR_CD_ID);
	}
	
	public PentasMap getCorpInfoByUsrId(String USR_ID) {
		return cmmnDao.selectOne("common.getCorpInfoByUsrId", USR_ID);
	}

	public PentasMap getByrInfoByUsrId(String USR_ID) {
		return cmmnDao.selectOne("common.getByrInfoByUsrId", USR_ID);
	}

	public PentasMap getCorpInfoByCorpId(String CORP_ID) {		
		return cmmnDao.selectOne("common.getCorpInfoByCorpId", CORP_ID);
	}

//	public PentasMap getUsrInfo(String USR_ID) {
//		return cmmnDao.selectOneEncrypt("common.getUsrInfo", USR_ID, null, new String[] {"USR_EMAIL"});
//	}

	public void pdfObject(String STOR_FILE_NM, HttpServletResponse response) {
		
		PentasMap fileInfo = cmmnDao.selectOne("common.selectFileInfo", STOR_FILE_NM);
		String UPLOAD_PATH = fileInfo.getString("UPLOAD_PATH");
		String fileFullPath = new StringBuilder()
				.append(UPLOAD_PATH)
				.append(STOR_FILE_NM)
				.toString();

		File file = new File(fileFullPath);

		String ORG_FILE_NM = fileInfo.getString("ORG_FILE_NM");
		try {
			ORG_FILE_NM = URLEncoder.encode(ORG_FILE_NM, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			log.error(CmmnUtil.getExceptionStackTrace(e));
			throw new UserBizException("파일다운로드중 오류가 발생했습니다.");
		}

		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", "JSP Generated Data");
		response.setContentType("application/pdf");
		
		byte[] b = new byte[1000000];
		try (BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream())) {
			int read = 0;

			while (true) {
				read = fin.read(b);
				if (read == -1) {
					break;
				}
				outs.write(b, 0, read);
			}
		} catch (Exception e) {
			log.error(CmmnUtil.getExceptionStackTrace(e));

			try (BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());) {
				outs.write(Base64.decodeBase64(Constant.NOIMAGE));
			} catch (IOException e1) {
				log.error(CmmnUtil.getExceptionStackTrace(e1));
			};
		}

	}
	
	public int getExtra01() {
		return cmmnDao.selectOne("common.getExtra01");
	}

	public void increaseExtra01() {
		cmmnDao.update("common.increaseExtra01");
	}
	
	public void setLoginSessionId(String USR_ID, String SESSION_ID) {
		PentasMap params = new PentasMapBuilder()
				.put("USR_ID", USR_ID)
				.put("SESSION_ID", SESSION_ID)
				.build();
		int count = cmmnDao.selectOne("common.getLoginSessionIdCount", params);
		if(count > 0) {
			cmmnDao.update("common.updateLoginSessionId", params);
		} else {
			cmmnDao.insert("common.insertLoginSessionId", params);
		}
	}
	
	public String getLoginSessionId(String USR_ID) {
		return cmmnDao.selectOne("common.getLoginSessionId", USR_ID);
	}
}
