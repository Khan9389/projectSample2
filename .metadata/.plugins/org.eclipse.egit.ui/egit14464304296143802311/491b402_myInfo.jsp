<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/common_header.jsp" %>
<%
	List<PentasMap> techLvList = (List<PentasMap>) request.getAttribute("techLvList");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펜타에스</title>
	<%@include file="/WEB-INF/jsp/common/include/static_resource.jsp" %>
	<%@include file="/WEB-INF/jsp/common/include/gw_static_resource.jsp" %>
	<script src="/static_resources/lib/CryptoJS/3.1.2/rollups/sha256.js"></script>
<body>
	<%@include file="/WEB-INF/jsp/common/include/header_gw.jsp"%>
	<div class="mainCont">
		<div class="container">
			<div id="sideBar">
				<%@include file="/WEB-INF/jsp/common/include/lnb.jsp"%>
			</div>
			<div class="visual_item">
				<div class="reportCont">
					<!-- 테이블형식 -->
					<div class="formWrap formWrapProfile">
					    <h2 class="header">
					    	<div class="shbox">
							    <div class="innerContView">
									<h4 class="subTit tblMb">내 정보</h4>
								</div>
				            </div>
				            <div class="btn_wrap disbetr mrt-20">
				                <button type="button" class="btn btn-com wi-10 mr10" onclick="clearPopupOpen()"><span>수정</span></button>
				                <button type="button" class="btn btn-list mr10" onclick="openChangePwPopup()"><span>비밀번호 초기화</span></button>
				            </div>
						</h2> 
						
					    <div class="form formProfile">
					        <div class="resume-view-container">					
								<div class="base profile image">
								    <div class="container mrg-b20">
								            <div class="photo"><img src="../../../static_resources/groupware/image/rian.jpg"></div>
								        <div class="info-container">
								            <div class="info-general">
								                <div class="item name" id="usrNameDtl"></div>
								            </div>
								            <div class="info-detail">
						                        <div class="item">
						                            <div class="label">구분</div>
						                            <div class="value" id="usrTypeDtl"></div>
						                        </div>
						                        <div class="item">
						                            <div class="label">회원권한</div>
						                            <div class="value" id="usrPrmsDtl"></div>
						                        </div>
						                        <!-- <div class="item item-full">
						                        	<div class="label">회원권한</div>
						                   		</div> -->
								            </div>
								        </div>
									</div>
								</div>
								
								<div class="base profile image">
								    <div class="container">
								        <div class="info-container mrl-0">
								        	<div class="info-detail disbet">
						                        <div class="item wi-50">
						                            <div class="label">ID</div>
						                            <div class="value" id="usrLogIdDtl"></div>
						                        </div>
						                        <div class="item item-full wi-50">
						                        	<div class="label">이메일</div>
						                        	<div class="value" id="usrEmailDtl"></div>
						                   		</div>
								            </div>
								            
								            <div class="info-detail disbet">
						                        <div class="item wi-50">
						                            <div class="label">연락처</div>
						                            <div class="value" id="usrTelDtl"></div>
						                        </div>
						                        <div class="item item-full wi-50">
						                        	<div class="label">비상 연락처</div>
						                        	<div class="value" id="usrEmgTelDtl"></div>
						                   		</div>
								            </div>
								            
								            <div class="info-detail disbet">
						                        <div class="item wi-50">
						                            <div class="label">주소</div>
						                            <div class="value" id="usrAddrDtl"></div>
						                        </div>
						                        <div class="item item-full wi-50">
						                        	<div class="label">생년월일</div>
						                        	<div class="value" id="usrBirthDtDtl"></div>
						                   		</div>
								            </div>
								            
								        	<div class="info-detail disbet">
						                        <div class="item wi-50">
						                            <div class="label">최종학력</div>
						                            <div class="value" id="usrEduLvDtl"></div>
						                        </div>
						                        <div class="item item-full wi-50">
						                        	<div class="label">졸업년월일</div>
						                        	<div class="value" id="usrGradDtDtl"></div>
						                   		</div>
								            </div>
								        	
								            <div class="info-detail disbet">
						                        <div class="item wi-50">
						                            <div class="label">소속사</div>
						                            <div class="value" id="usrCompanyDtl"></div>
						                        </div>
						                        <div class="item item-full wi-50">
						                        	<div class="label">부서</div>
						                        	<div class="value" id="usrDepDtl"></div>
						                   		</div>
								            </div>
								            
								            <div class="info-detail disbet">
						                        <div class="item wi-50">
						                            <div class="label">직급</div>
						                            <div class="value" id="usrPosDtl"></div>
						                        </div>
						                        <div class="item item-full wi-50">
						                        	<div class="label">기술자 등급</div>
						                        	<div class="value" id="usrTechLvDtl"></div>
						                   		</div>
								            </div>
								            
								            <div class="info-detail disbet">
						                        <div class="item wi-50">
						                            <div class="label">입사일</div>
						                            <div class="value" id="usrJoinDtDtl"></div>
						                        </div>
						                        <div class="item item-full wi-50">
						                        	<div class="label">퇴사일</div>
						                        	<div class="value" id="usrQuitDtDtl"></div>
						                   		</div>
								            </div>
								            
								            <div class="info-detail">
						                        <div class="item item-full">
						                        	<div class="label">비고</div>
						                        	<div class="value" id="usrMemoDtl"></div>
						                   		</div>
								            </div>
								        </div>
									</div>
								</div>
			            	</div>
				        </div>
				        
				        
				    </div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/jsp/common/include/footer_gw.jsp"%>
</body>

<div id="popupDialog" class="popup-wrap type-basic">
	<section class="popup demo1">
	<div class="popup-head">
		<h3 class="popup-tit">내 정보</h3>
	</div>
	<div class="popup-body">
		<div class="popup-content">
		
			<!-- 여기에 추가해주시면 됩니다. -->	
			<div class="formWrap formWrapProfile">
				<h2 class="header">
					<div class="innerContView">
						<h4 class="subTit tblMb">내정보 수정</h4>
					</div>
					<div class="description">
						<span class="star">*</span> 필수 입력 정보입니다.
					</div>
				</h2>
				
				<div class="form formProfile">
				
				    <div class="picture dropped" style="">
				        <div class="image" aria-hidden="true">
				            <img id="img_usrPicFile"src="../../../static_resources/groupware/image/rian.jpg">
				        </div>
				        <span class="file-add">
				            <label for="file_usrPicFile" class="btn demo1 btn-file" role="button">
				                <span><input type="file" style="display: none;" id="file_usrPicFile" onchange="delFile('usrPicFile')"/>첨부</span>
				            </label>
				        </span>
				    </div>
				    
				    <div class="row-pi">
				        <div class="input is-label is-value mr10">
				        	<input type="text" class="usrTypeDisabled" placeholder="회원권한을 입력해주세요." disabled>
				            <div class="label">구분<span class="star">*</span></div>
				        </div>
				        
				        <div class="input is-label is-value">
				        	<input type="text" class="usrPrmsDisabled" placeholder="회원권한을 입력해주세요." disabled>
				            <div class="label">회원권한<span class="star">*</span></div>
				        </div>
				    </div>
				    
				    <div class="row-pi">
				        <div class="input is-label is-value mr10">
				            <input type="text" placeholder="성명을 입력해주세요." id="usrName">
				            <div class="label">성명<span class="star">*</span></div>
				        </div>
				       	<div class="input is-label is-value">
				            <input type="text" placeholder="성명(영문)을 입력해주세요." id=usrNameEn>
				            <div class="label">성명(영문)<span class="star">*</span></div>
				        </div>
				    </div>
				</div>

				<div class="form-end formProfile">
		            <div class="row">
		                <div class="input input-end is-label is-value mr10">
		                	<input type="text" placeholder="ID 입력해주세요." id="usrLogId">
		                    <div class="label">ID
		                    	<span class="star">*</span>
		                    	<span id="idChk"></span>
		                    </div>
		                </div>
		                <div class="input input-end is-label is-value mr10">
		                	<input type="text" placeholder="이메일를 입력해주세요." id="usrEmail">
		                    <div class="label">이메일<span class="star">*</span></div>
		                </div>
					</div>
		            
		            <div class="row">
		                <div class="input input-end is-label is-value mr10">
		                	<input type="text" placeholder="연락처를 입력해주세요." id="usrTel" onkeyup="telePhoneCheck(this);">
		                    <div class="label">연락처<span class="star">*</span></div>
		                </div>
		                <div class="input input-end is-label is-value mr10">
		                	<input type="text" placeholder="비상 연락처를 입력해주세요." id="usrEmgTel" onkeyup="telePhoneCheck(this);">
		                    <div class="label">비상 연락처<span class="star">*</span>
	                    	</div>
		                </div>
		            </div>
		            
		            <div class="row">
		                <div class="input input-end is-label is-value mr10">
		                	<input type="text" placeholder="주소를 입력해주세요." id="usrAddr">
		                    <div class="label">주소<span class="star">*</span></div>
		                </div>
		                <div class="input is-label is-value">
				            <input type="text" id="usrBirthDt">
				            <div class="label">생년월일<span class="star">*</span></div>
				        </div>
		            </div>
		            
		            <div class="row">
		            	<div class="input input-end is-label is-value mr10">
		                	<input type="text" placeholder="최종학력정보를 입력해주세요." id="usrEduLv">
		                    <div class="label">최종학력정보</div>
		                </div>
		                <div class="input is-label is-value">
				            <input type="text" id="usrGradDt">
				            <div class="label">졸업년월일</div>
				        </div>
		            </div>
		            
		            <div class="row">
		                 <div class="input input-end is-label is-value mr10">
		                	<input type="text" placeholder="소속사를 입력해주세요." id="usrCompany">
		                    <div class="label">소속사<span class="star">*</span></div>
		                </div>
		                 <div class="input is-label is-value mr10">
		                	<input type="text" placeholder="부서를 입력해주세요." id="usrDep">
		                    <div class="label">부서</div>
		                </div>	
		                 <div class="input input-end is-label is-value mr10">
		                	<input type="text" placeholder="직급을 입력해주세요." id="usrPos">
		                    <div class="label">직급<span class="star">*</span></div>
		                </div>
		                 <div class="dropdown dropdown-education-category selected is-label input">
			                <div class="label">기술자등급<span class="star">*</span></div>
			                <select class="button buttonChoose"  id="usrTechLv">
<%		for(PentasMap map : techLvList) { %>		      
			                	<option class="button" value="<%=map.get("MINOR_CD")%>"><span><%=map.get("MINOR_NM")%></span></option>
<%		} %>			                	
			                </select>
			            </div>
		            </div>
		            
	             	<div class="row">
						<div class="input is-label is-value mr10">
				            <input type="text" id="usrJoinDt">
				            <div class="label">입사일<span class="star">*</span></div>
				        </div>
				        <div class="input is-label is-value">
				            <input type="text" id="usrQuitDt">
				            <div class="label">퇴사일</div>
				        </div>
		            </div>
		            
		            <div class="row">
						<div class="textarea is-label is-value">
		                    <label for="Edu_Edu_Cntnt_c15">비고</label>
		                    <textarea cols="30" rows="10" id="usrMemo" placeholder="비고"></textarea>
		                </div>
		            </div>
		            
		            <div class="row">
		            	<div class="row filebox">
			                <div class="input input-full is-label dropdown-profile-sex is-value ">
			                	<div class="input-file flex">
								  	<input type="text" id="name_usrProFile" class="file-name" placeholder="파일업로드" readonly="readonly"/>
			                		<a class="downBtn" alt="" href="" id="a_usrProFile" style="display: none;">다운로드</a>
			                		<a class="delBtn mrl-10" id="del_usrProFile" style="display: none;" onclick="delFile('usrProFile')">삭제</a>
								  	<input type="file" id="file_usrProFile" class="file-upload" onchange="delFile('usrProFile')"/>
								</div>
			                    <div class="label">프로필파일<span class="star">*</span></div>
			                </div>
			 				<div class="btn_wrap-ll">
								<label for="file_usrProFile" class="file-label">업로드</label>
							</div>
			            </div>
		            </div>
		            
		            <div class="row">
		            	<div class="row filebox">
			                <div class="input input-full is-label dropdown-profile-sex is-value ">
			                	<div class="input-file flex">
								  	<input type="text" id="name_usrCertFile" class="file-name" placeholder="파일업로드" readonly="readonly"/>
			                		<a class="downBtn" alt="" href="" id="a_usrCertFile" style="display: none;">다운로드</a>
			                		<a class="delBtn mrl-10" id="del_usrCertFile" style="display: none;" onclick="delFile('usrCertFile')">삭제</a>
								  	<input type="file" id="file_usrCertFile" class="file-upload" onchange="delFile('usrCertFile')"/>
								</div>
			                    <div class="label">자격증빙파일<span class="star">*</span></div>
			                </div>
			 				<div class="btn_wrap-ll">
								<label for="file_usrCertFile" class="file-label">업로드</label>
							</div>
			            </div>
		            </div>
		            
		            <div class="row">
		            	<div class="row filebox">
			                <div class="input input-full is-label dropdown-profile-sex is-value ">
			                	<div class="input-file flex">
								  	<input type="text" id="name_usrRefFile" class="file-name" placeholder="파일업로드" readonly="readonly"/>
			                		<a class="downBtn" id="a_usrRefFile" style="display: none;">다운로드</a>
			                		<a class="delBtn mrl-10" id="del_usrRefFile" style="display: none;" onclick="delFile('usrRefFile')">삭제</a>
								  	<input type="file" id="file_usrRefFile" class="file-upload" onchange="delFile('usrRefFile')"/>
								</div>
			                    <div class="label">경력증빙파일<span class="star">*</span></div>
			                </div>
			 				<div class="btn_wrap-ll">
								<label for="file_usrRefFile" class="file-label">업로드</label>
							</div>
			            </div>
		            </div>
		            
				</div>
            </div>
           	<!-- 여기에 추가해주시면 됩니다. -->
           	
           	<div class="btn_wrap SYSAD">
		 		<!-- 버튼 기본 컬러  -->
                <button type="button" class="btn btn-com" onclick="goSave()"><span class="changeBtn">수정</span></button>
		 		<!-- 버튼 기본 컬러  -->
            </div>
		</div>
	</div>
	<div class="popup-close">
		<button type="button" class="btn btn-close" onclick="popupClose('popupDialog')"><span><img src="../../../static_resources/groupware/image/ico_close01.png"></span></button>
	</div>
	</section>
</div>

<div id="changePwPopupDialog" class="popup-wrap type-basic">
	<section class="popup demo1">
	<div class="popup-head">
		<h3 class="popup-tit">내 정보</h3>
	</div>
	<div class="popup-body">
		<div class="popup-content">
					
			<!-- 여기에 추가해주시면 됩니다. -->
			<div class="formWrap formWrapProfile">
				<h2 class="header">
					<div class="innerContView">
						<h4 class="subTit tblMb">비민번호 변경</h4>
					</div>
					<div class="description">
						<span class="star">*</span> 필수 입력 정보입니다.
					</div>
				</h2>
				<div class="form formProfile">
					<div class="row">
            			<div class="input input-end is-label is-value mr10">
            				<input type="text" placeholder="비밀번호를 입력해주세요." id="usrLogChangePw">	
                			<div class="label">비밀번호<span class="star">*</span></div>
            			</div>
            			<div class="input input-end is-label is-value mr10">
            				<input type="password" placeholder="비밀번호를 입력해주세요." id="usrLogChangePwChk">
                			<div class="label">비밀번호 확인
                				<span class="star">*</span>
                				<span id="pwChangeChk"></span>
							</div>
            			</div>
        			</div>
				</div>
			</div>
           	<!-- 여기에 추가해주시면 됩니다. -->
           	
           	<div class="btn_wrap SYSAD">
		 		<!-- 버튼 기본 컬러  -->
                <button type="button" class="btn btn-com" onclick="goChangePw()"><span>수정</span></button>
		 		<!-- 버튼 기본 컬러  -->
            </div>
		</div>
	</div>
	<div class="popup-close">
		<button type="button" class="btn btn-close" onclick="popupClose('changePwPopupDialog')"><span><img src="../../../static_resources/groupware/image/ico_close01.png"></span></button>
	</div>
	</section>
</div>
<script>
var USR_ID = "<%=USR_ID%>";

var pwChangeFlag = false;
var staticData = {};
$(function(){
	gw_datepickerInit("#usrBirthDt, #usrGradDt, #usrJoinDt, #usrQuitDt");
	
	
	if(USR_ID != ""){
		getInfo();
	}
})

$('#usrLogChangePw, #usrLogChangePwChk').blur(function(){
	pWChangeChk();
});

function getInfo(){
	params = {
		ID : USR_ID			
	}
	console.log(params)
	cf_call("/groupware/myInfo/getInfo", params, getInfoCB);
}
function getInfoCB(data){
	console.log(data);
	this.staticData = data;
	
	$("#usrNameDtl").text( data.USR_NAME + " ( " + data.USR_NAME_EN + " ) ");
	$("#usrTypeDtl").text(data.USR_TYPE_TEXT);
	$("#usrPrmsDtl").text(data.USR_PRMS);
	$("#usrLogIdDtl").text(data.USR_LOGID);
	$("#usrEmailDtl").text(data.USR_EMAIL);
	$("#usrTelDtl").text(data.USR_TEL);
	$("#usrEmgTelDtl").text(data.USR_EMG_TEL);
	$("#usrAddrDtl").text(data.USR_ADDR);
	$("#usrBirthDtDtl").text(data.USR_BIRTH_DT);
	$("#usrEduLvDtl").text(data.USR_EDU_LV);
	$("#usrGradDtDtl").val(data.USR_GRAD_DT);
	$("#usrCompanyDtl").text(data.USR_COMPANY);
	$("#usrDepDtl").text(data.USR_DEP);
	$("#usrPosDtl").text(data.USR_POS);
	$("#usrTechLvDtl").text(data.TECH_LV_TEXT);
	$("#usrJoinDtDtl").text(data.USR_JOIN_DT);
	$("#usrQuitDtDtl").text(data.USR_QUIT_DT);
	$("#usrMemoDtl").text(data.USR_MEMO);
	
	/* 파일 업로드 S */
	setImgFile("usrPicFile", data.USR_PIC_FILE);
	setAttachFile("usrProFile", data.USR_PRO_FILE);
	setAttachFile("usrCertFile", data.USR_CERT_FILE);
	setAttachFile("usrRefFile", data.USR_REF_FILE);
	/* 파일 업로드 E */
}

function validate(){
	if(cf_isEmpty($("#usrName").val().trim())){
		alert("성명을 입력하세요.");
		$("#usrName").focus();
		return false;
	}
	if(cf_isEmpty($("#usrNameEn").val().trim())){
		alert("성명(영문)을 입력하세요.");
		$("#usrNameEn").focus();
		return false;
	}
	if(cf_isEmpty($("#usrEmail").val().trim())){
		alert("이메일을 입력하세요.");
		$("#usrEmail").focus();
		return false;
	}
	if(cf_isEmpty($("#usrTel").val().trim())){
		alert("연락처를 입력하세요.");
		$("#usrTel").focus();
		return false;
	}
	if(cf_isEmpty($("#usrEmgTel").val().trim())){
		alert("비상 연락처를 입력하세요.");
		$("#usrEmgTel").focus();
		return false;
	}
	if(cf_isEmpty($("#usrAddr").val().trim())){
		alert("주소를 입력하세요.");
		$("#usrAddr").focus();
		return false;
	}
	if(cf_isEmpty($("#usrBirthDt").val().trim())){
		alert("생년월일을 입력하세요.");
		$("#usrBirthDt").focus();
		return false;
	}
	if(cf_isEmpty($("#usrCompany").val().trim())){
		alert("소속사를 입력하세요.");
		$("#usrCompany").focus();
		return false;
	}
	if(cf_isEmpty($("#usrPos").val().trim())){
		alert("직급을 입력하세요.");
		$("#usrPos").focus();
		return false;
	}
	if(cf_isEmpty($("#usrJoinDt").val().trim())){
		alert("입사일을 입력하세요.");
		$("#usrJoinDt").focus();
		return false;
	}
	return true;
}
function goSave(){
	if(!validate()) 
		return;
	
	/* 파일 업로드 S */
	var fileList = [];
	var upfileIds = [];
	setFileList(fileList, upfileIds, "usrPicFile");
	setFileList(fileList, upfileIds, "usrProFile");
	setFileList(fileList, upfileIds, "usrCertFile");
	setFileList(fileList, upfileIds, "usrRefFile");
	/* 파일 업로드 E */
	
	params = {
		/* 파일 업로드 S */
		upfileIds 	: upfileIds,
		fileUseTable:"WERE_USER",
		/* 파일 업로드 E */
		ID 			: this.USR_ID,
		usrName		: $("#usrName").val(),
		usrNameEn	: $("#usrNameEn").val(),
		usrEmail	: $("#usrEmail").val(),
		usrTel		: $("#usrTel").val(),
		usrEmgTel	: $("#usrEmgTel").val(),
		usrAddr		: $("#usrAddr").val(),
		usrBirthDt	: $("#usrBirthDt").val(),
		usrCompany	: $("#usrCompany").val(),
		usrDep		: $("#usrDep").val(),
		usrPos		: $("#usrPos").val(),
		usrTechLv	: $("#usrTechLv").val(),
		usrEduLv	: $("#usrEduLv").val(),
		usrGradDt	: $("#usrGradDt").val(),
		/* usrJoinDt	: $("#usrJoinDt").val(),
		usrQuitDt	: $("#usrQuitDt").val(), */
		/* 파일 업로드 S */
		usrPicFile	: $("#img_usrPicFile").val(),
		usrProFile 	: $("#a_usrProFile").val(),
		usrCertFile : $("#a_usrCertFile").val(),
		usrRefFile 	: $("#a_usrRefFile").val(),
		/* 파일 업로드 E */
		usrMemo		: $("#usrMemo").val(),
	}
	cf_callWithFiles("/groupware/myInfo/updateInfo", fileList, params, goSaveCB);
}

function goSaveCB(data){
	if(data.rsltStatus == "SUCC"){
		alert("수정이 완료되었습니다.");
		location.reload();
	}else{
		alert("수정이 실패하였습니다.");
	}
}



function clearPopupOpen(){
	$(".usrTypeDisabled").val(staticData.USR_TYPE_TEXT);
	$(".usrPrmsDisabled").val(staticData.USR_PRMS);
	$("#usrName").val(staticData.USR_NAME),
	$("#usrNameEn").val(staticData.USR_NAME_EN),
	$("#usrLogId").val(staticData.USR_LOGID).attr("disabled",true);
	$("#usrEmail").val(staticData.USR_EMAIL);
	$("#usrTel").val(staticData.USR_TEL);
	$("#usrEmgTel").val(staticData.USR_EMG_TEL);
	$("#usrAddr").val(staticData.USR_ADDR);
	$("#usrBirthDt").val(staticData.USR_BIRTH_DT);
	$("#usrEduLv").val(staticData.USR_EDU_LV);
	$("#usrGradDt").val(staticData.USR_GRAD_DT);
	$("#usrCompany").val(staticData.USR_COMPANY)
	if("<%=USR_PRMS%>" == "MEMBR"){
		$("#usrDep").val(staticData.USR_DEP).attr("disabled",true);
		$("#usrPos").val(staticData.USR_POS).attr("disabled",true);
		$("#usrTechLv").val(staticData.USR_TECH_LV).attr("disabled",true);
		$("#usrJoinDt").val(staticData.USR_JOIN_DT).attr("disabled",true);
		$("#usrQuitDt").val(staticData.USR_QUIT_DT).attr("disabled",true);
	}else{
		$("#usrDep").val(staticData.USR_DEP);
		$("#usrPos").val(staticData.USR_POS);
		$("#usrTechLv").val(staticData.USR_TECH_LV);
		$("#usrJoinDt").val(staticData.USR_JOIN_DT);
		$("#usrQuitDt").val(staticData.USR_QUIT_DT);
	}
		$("#usrMemo").val(staticData.USR_MEMO);
	popupOpen('popupDialog');
}

function pWChangeChk(){
	var usrLogPw = $('#usrLogChangePw').val().trim();
	var usrLogPwChk = $('#usrLogChangePwChk').val().trim();
	 if(usrLogPw == "" && usrLogPwChk == ""){
		 pwChangeFlag = false;
		 $("#pwChangeChk").text("비밀번호를 입력해주세요!").css('color','red');
		 return
	 }
	 if(usrLogPw == usrLogPwChk){
		 pwChangeFlag = true;
		 $("#pwChangeChk").text("비밀번호가 일치합니다!").css('color','#1000ff');
	 }else{
		 pwChangeFlag = false;
		 $("#pwChangeChk").text("비밀번호가 일치하지 않습니다!").css('color','red');
	 }
}
function openChangePwPopup(){
	$("#usrLogChangePw").val("");
	$("#usrLogChangePwChk").val("");
	pwChangeFlag = false;
	$("#pwChangeChk").text("");
	popupOpen('changePwPopupDialog');
}

function goChangePw(){
	if(!pwChangeFlag){
		alert("비민번호를 확인해주세요.");
		$("#usrLogChangePw").focus();
		return
	}
	params = {
		ID : this.USR_ID,
		usrLogPw : CryptoJS.SHA256($("#usrLogChangePw").val()).toString()
	}
	cf_call("/groupware/myInfo/goChangePw", params, goChangePwCB);
}
function goChangePwCB(data){
	if(data.rsltStatus == "SUCC"){
		alert("비민번호 변경이 완료되었습니다.");
		location.reload();
	}else{
		alert("비밀번호 변경이 실패하였습니다.");
	}
}


/* 파일 업로드 S */
function setFileList(fileList, upfileIds, target){
	if(!cf_isFileEmpty("file_" + target)){
		upfileIds.push(target);
		fileList.push($("#file_" + target)[0].files[0]);
	}	
}
function setImgFile(target, data){
	$("#img_" + target).val(data);
	$("#img_" + target).attr("onclick","cf_fileDn('" + data + "')");
	if(data === "" || data == null){
		$("#img_" + target).attr("src","../../../static_resources/groupware/image/rian.jpg");
	} else {
		$("#img_" + target).attr("src", "/fileDn?p=" + data);
	}
}

function setAttachFile(target, data){
	$("#a_" + target).val(data);
	$("#a_" + target).attr("href", "/fileDn?p=" + data);
	
	if(data === "" || data == null){
	 	$("#a_" + target).hide();
	 	$("#name_" + target).val("");
	 	$("#del_" + target).hide();
	} else {
		cf_orgFileNm2Text("name_" + target, data);
		$("#a_" + target).show();
		$("#del_" + target).show();
	} 
}
function delFile(target){
	$("#del_" + target).hide();;
	$("#a_" + target).val("");
	$("#a_" + target).hide();
	$("#name_" + target).val( $("#file_" + target).val().substr("12") );
}
/* 파일 업로드 E */
</script>
</html>