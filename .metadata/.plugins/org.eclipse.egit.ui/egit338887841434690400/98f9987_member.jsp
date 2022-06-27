<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/common_header.jsp" %>
<%
	List<PentasMap> usrTypeList = (List<PentasMap>) request.getAttribute("usrTypeList");
	List<PentasMap> usrPrmsList = (List<PentasMap>) request.getAttribute("usrPrmsList");
	List<PentasMap> techLvList = (List<PentasMap>) request.getAttribute("techLvList");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펜타에스</title>
	<%@include file="/WEB-INF/jsp/common/include/static_resource.jsp" %>
	<%@include file="/WEB-INF/jsp/common/include/gw_static_resource.jsp" %>
	
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />
	
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
									<h4 class="subTit tblMb">직원조회</h4>
								</div>
				            </div>
				            <div class="row-con-l" style="justify-content: space-between;">
								<div class="list-contn flex">
					            	<div class="title-l">이름조회</div>
									<div class="list-contsz flex" style="/* width: 50%; */">
							            <div class="input input-type">
							            	<input type="text" id="word" onkeyup="if( event.keyCode==13 ){ getList();}" placeholder="검색어를 입력해주세요.">
						                </div>
									</div>
								</div>
								<div class="btn_wrap">
					                <button type="button" class="btn btn-com" onclick="getList()"><span>조회</span></button>
					            </div>
							</div>
				            <div class="btn_wrap disbetr mrt-20 SYSAD">
				                <button type="button" class="btn btn-com wi-10 mr10" onclick="clearPopupOpen()"><span>등록</span></button>
				                <button type="button" class="btn btn-list mr10" onclick="openChangePwPopup()"><span>비밀번호 초기화</span></button>
				                <button type="button" class="btn btn-del" onclick="goDelete()"><span>삭제</span></button>
				                <!-- <button type="button" class="btn btn-del wi-10" onclick="goDelete()"><span>삭제</span></button> -->
				            </div>
						</h2> 
					    <div class="form formProfile pd-0 wi-100">
					        <div class="row-con-t">
				               <table>
									<colgroup>
										<col style="width:5%">
										<col style="width:40%">
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:10%">
									</colgroup>
									<thead>
									<tr class="notice_table_tr_top02">
										<th><input type="checkbox" id="selectAll"></th>
										<th>이름</th>
										<th>회원권한</th>
										<th>회원구분</th>
										<th>소속사</th>
										<th>직급</th>
										<th>입사일</th>
									</tr>
									</thead>
									<tbody id="listDiv">
									</tbody>
								</table>
								<%@include file="/WEB-INF/jsp/common/include/pagination.jsp" %>
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
		<h3 class="popup-tit">직원조회</h3>
	</div>
	<div class="popup-body">
		<div class="popup-content">
		
			<!-- 여기에 추가해주시면 됩니다. -->	
			<div class="formWrap formWrapProfile">
				<h2 class="header">
					<div class="innerContView">
						<h4 class="subTit tblMb">직원조회</h4>
					</div>
					<div class="description">
						<span class="star">*</span> 필수 입력 정보입니다.
					</div>
				</h2>
				
				<div class="form formProfile">
				
				    <div class="picture dropped" style="">
				        <!-- <div class="guide" style="display: none;">사진추가</div>
				        <a href="#" class="buttonAddFile" style="display: none;">
				            사진등록
				        </a> -->
				        <div class="image" aria-hidden="true">
				            <img src="../../../static_resources/groupware/image/rian.jpg">
				        </div>
				        <span class="file-add">
				            <input type="text" id="usrPicFile" class="input demo1" title="첨부된 파일명" style="display: none;">
				            <label for="sFilesAdd21" class="btn demo1 btn-file" role="button">
				                <span><input type="file" style="display: none;" name="sFilesAdd21" id="sFilesAdd21" value="찾아보기" tabindex="-1" aria-hidden="true">첨부</span>
				            </label>
				        </span>
				    </div>
				    
				    <div class="row-pi">
				        <div class="input is-label is-value mr10">
				            <div class="label">구분<span class="star">*</span></div>
				            <div class="radio-area">
<%		for(PentasMap map : usrTypeList) { %>
				                <div class="radio-tx-area">
				                    <span class="radio tx">
				                        <input type="radio" name="usrType" id="<%=map.get("MINOR_CD")%>" value="<%=map.get("MINOR_CD")%>">
				                        <label for="<%=map.get("MINOR_CD")%>">
				                            <div><%=map.get("MINOR_NM")%></div>
				                        </label>
				                    </span>
				                </div>
<%		} %>
				            </div>
				        </div>
				        
				        <div class="input is-label is-value">
				        	<input type="text" class="usrPrmsTypeA" placeholder="회원권한을 입력해주세요." disabled>
				            <div class="label">회원권한<span class="star">*</span></div>
				            <div class="radio-area usrPrmsTypeB">
<%		for(PentasMap map : usrPrmsList) { %>
				                <div class="radio-tx-area">
				                    <span class="radio tx">
				                        <input type="radio" name="usrPrms" id="<%=map.get("MINOR_CD")%>" value="<%=map.get("MINOR_CD")%>">
				                        <label for="<%=map.get("MINOR_CD")%>">
				                            <div><%=map.get("MINOR_NM")%></div>
				                        </label>
				                    </span>
				                </div>
<%		} %>
				            </div>
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
					<div class="row pwRow">
		                <div class="input input-end is-label is-value mr10">
		                	<input type="text" placeholder="비밀번호를 입력해주세요." id="usrLogPw">
		                    <div class="label">비밀번호<span class="star">*</span></div>
		                </div>
		                <div class="input input-end is-label is-value mr10">
		                	<input type="password" placeholder="비밀번호를 입력해주세요." id="usrLogPwChk">
		                    <div class="label">비밀번호 확인
		                    	<span class="star">*</span>
								<span id="pwChk"></span>
	                    	</div>
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
			                	<input type="file" id="usrProFile" >
							  	<input class="upload-name" placeholder="파일선택">
			                    <div class="label">프로필파일</div>
			                </div>
				 				<div class="btn_wrap-ll">
								  <label for="usrProFile">업로드</label> 
								 </div>
			                <div class="file-del-con">
								<button type="button" class="btn btn-del-l"><span>삭제</span></button>
                            </div>
			            </div>
		            </div>
		            
		            <div class="row">
		            	<div class="row filebox">
			                <div class="input input-full is-label dropdown-profile-sex is-value ">
			                	<input type="file" id="usrCertFile" >
							  	<input class="upload-name" placeholder="파일선택">
			                    <div class="label">자격증빙파일</div>
			                </div>
				 				<div class="btn_wrap-ll">
								  <label for="usrCertFile">업로드</label> 
								 </div>
			                <div class="file-del-con">
								<button type="button" class="btn btn-del-l"><span>삭제</span></button>
                            </div>
			            </div>
		            </div>
		            
		            <div class="row">
		            	<div class="row filebox">
			                <div class="input input-full is-label dropdown-profile-sex is-value ">
			                	<input type="file" id="usrRefFile" >
							  	<input class="upload-name" placeholder="파일선택">
			                    <div class="label">경력증빙파일</div>
			                </div>
				 				<div class="btn_wrap-ll">
								  <label for="usrCertFile">업로드</label> 
								 </div>
			                <div class="file-del-con">
								<button type="button" class="btn btn-del-l"><span>삭제</span></button>
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
		<h3 class="popup-tit">직원조회</h3>
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
var ID = "";
var USR_PRMS = "<%=USR_PRMS%>"

var idFlag = false;
var pwFlag = false;
var pwChangeFlag = false;
var modFlag = false;
$(function(){
	console.log(USR_PRMS)
	$('#usrBirthDt, #usrGradDt, #usrJoinDt, #usrQuitDt').datepicker({
		dateFormat: 'yy-mm-dd' //달력 날짜 형태
		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
		,changeYear: true //option값 년 선택 가능
		,changeMonth: true //option값  월 선택 가능                
		//,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
		//,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
		//,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
		//,buttonText: "선택" //버튼 호버 텍스트              
		,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
		,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
		,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
		,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
		,showAnim : 'slideDown'
	});
	
	$('#usrBirthDt, #usrJoinDt').datepicker('setDate', 'today');
	$('input:radio[name=usrPrms]').eq(0).attr("checked", true);
	$('input:radio[name=usrType]').eq(0).attr("checked", true);
	
	
	// 권한 체크 함수화 해야함
	if(USR_PRMS == "SYSAD" ){
		$(".SYSAD").show();
	}else{
		$(".SYSAD").hide();
	}
	
	getList();
})
function getList(){
	cv_pageInfo.func = getList;
	var pageInfo = {
			pageNo : cv_pageInfo.pageNo,
			orders : [
				{target : "USR_NAME", isAsc : false},
			],
			limit : 10
	}
	params = {
		word : $("#word").val().trim()
	}
	cf_callPage("/groupware/member/getList", params, pageInfo, getListCB);
}
function getListCB(data){
	console.log(data);
	g_dataList = data.list;
	
	$("#listDiv").html("");
	var listDivHtml = "";
	
	if(g_dataList.length == 0){
		listDivHtml += '<tr class="notice_table_tr_top2_2">';
		listDivHtml += '	<td class="wi-100" colspan="6">검색결과가 없습니다.</td>';
		listDivHtml += '</tr>';
	}else{
	 	for(var i=0; i<g_dataList.length; i++){
	 		listDivHtml += '<tr class="notice_table_tr_top2_2">';
	 		listDivHtml += '	<td><input type="checkbox" name="ID" value="' + g_dataList[i].ID + '"></td>';
			listDivHtml += '	<td><a onclick="getInfo(\'' + g_dataList[i].ID + '\')">' + g_dataList[i].USR_NAME + '</a></td>';
			listDivHtml += '	<td>' + g_dataList[i].USR_PRMS + '</td>';
			listDivHtml += '	<td>' + g_dataList[i].USR_TYPE + '</td>';
			listDivHtml += '	<td>' + g_dataList[i].USR_COMPANY + '</td>';
			listDivHtml += '	<td>' + g_dataList[i].USR_POS + '</td>';
			listDivHtml += '	<td>' + g_dataList[i].USR_JOIN_DT + '</td>';
	 		listDivHtml += '</tr>';
		}
	}
 	
	$("#listDiv").html(listDivHtml);
	checkBoxSet();
}

$('#usrLogId').blur(function(){
	duplID();
});
$('#usrLogPw, #usrLogPwChk').blur(function(){
	pWChk();
});
$('#usrLogChangePw, #usrLogChangePwChk').blur(function(){
	pWChangeChk();
});
function duplID(){
	var usrLogId = $('#usrLogId').val().trim();
	if(usrLogId == ""){
		$("#idChk").text("아이디를 입력해주세요!").css('color','red');
		return
	}
	params = {
		ID : usrLogId
	}
	cf_call("/groupware/member/duplId", params, dupleIdCB);
}
function dupleIdCB(data){
	if(data.IDCHK == 0){
		idFlag = true;
		$("#idChk").text("사용 가능한 아이디입니다.").css('color','#1000ff');
	}else{
		idFlag = false;
		$("#idChk").text("이미 사용중인 아이디입니다!").css('color','red');
	}
}
function pWChk(){
	var usrLogPw = $('#usrLogPw').val().trim();
	var usrLogPwChk = $('#usrLogPwChk').val().trim();
	 if(usrLogPw == "" && usrLogPwChk == ""){
		 pwFlag = false;
		 $("#pwChk").text("비밀번호를 입력해주세요!").css('color','red');
		 return
	 }
		 
	 if(usrLogPw == usrLogPwChk){
		 pwFlag = true;
		 $("#pwChk").text("비밀번호가 일치합니다!").css('color','#1000ff');
	 }else{
		 pwFlag = false;
		 $("#pwChk").text("비밀번호가 일치하지 않습니다!").css('color','red');
	 }
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
	if(!idFlag && !modFlag){
		alert("아이디를 확인해주세요");
		$("#usrLogId").focus();
		return false;
	}
	if(!pwFlag && !modFlag){
		alert("비밀번호를 확인해주세요");
		$("#usrLogPw").focus();
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
	
	params = {
		ID 			: this.ID,
		usrLogId	: $("#usrLogId").val(),
		usrPrms		: $("input[name=usrPrms]:checked").val(),
		usrLogPw	: CryptoJS.SHA256($("#usrLogPw").val()).toString(),
		usrName		: $("#usrName").val(),
		usrNameEn	: $("#usrNameEn").val(),
		usrBirthDt	: $("#usrBirthDt").val(),
		usrType		: $("input[name=usrType]:checked").val(),
		usrDep		: $("#usrDep").val(),
		usrPos		: $("#usrPos").val(),
		usrEmail	: $("#usrEmail").val(),
		usrTel		: $("#usrTel").val(),
		usrEmgTel	: $("#usrEmgTel").val(),
		usrAddr		: $("#usrAddr").val(),
		usrCompany	: $("#usrCompany").val(),
		usrJoinDt	: $("#usrJoinDt").val(),
		usrQuitDt	: $("#usrQuitDt").val(),
		usrTechLv	: $("#usrTechLv").val(),
		usrEduLv	: $("#usrEduLv").val(),
		usrGradDt	: $("#usrGradDt").val(),
		
		usrPicFile	: $("#usrPicFile").val,
		usrProFile 	: $("#usrProFile").val,
		usrCertFile : $("#usrCertFile").val,
		usrRefFile 	: $("#usrRefFile").val,
		
		usrMemo		: $("#usrMemo").val(),
	}

	cf_call("/groupware/member/saveInfo", params, goSaveCB);
}
function goSaveCB(data){
	if(data.rsltStatus == "SUCC"){
		if(this.ID == ""){
			alert("등록이 완료되었습니다.");
		}else{
			alert("수정이 완료되었습니다.");
		}
		location.reload();
	}else{
		if(this.ID == ""){
			alert("등록에 실패하였습니다.");
		}else{
			alert("수정이 실패하였습니다.");
		}
	}
}

function getInfo(ID){
	this.ID = ID;
	params = {
		ID : ID
	}
	cf_call("/groupware/member/getInfo", params, getInfoCB);
}
function getInfoCB(data){
	console.log(data)
	modFlag = true;
	
	$("[name=usrType][value=" + data.USR_TYPE + "]").prop("checked", true);
	$(".usrPrmsTypeA").val(data.USR_PRMS).show();
	$(".usrPrmsTypeB").hide();
	$("#usrName").val(data.USR_NAME),
	$("#usrNameEn").val(data.USR_NAME_EN),
	$("#usrLogId").val(data.USR_LOGID).attr("disabled",true);
	$("#usrEmail").val(data.USR_EMAIL);
	
	$(".pwRow").hide();
	
	$("#usrTel").val(data.USR_TEL);
	$("#usrEmgTel").val(data.USR_EMG_TEL);
	$("#usrAddr").val(data.USR_ADDR);
	$("#usrBirthDt").val(data.USR_BIRTH_DT);
	$("#usrEduLv").val(data.USR_EDU_LV);
	$("#usrGradDt").val(data.USR_GRAD_DT);
	$("#usrCompany").val(data.USR_COMPANY);
	$("#usrDep").val(data.USR_DEP);
	$("#usrPos").val(data.USR_POS);
	$("#usrTechLv").val(data.USR_TECH_LV);
	$("#usrJoinDt").val(data.USR_JOIN_DT);
	$("#usrQuitDt").val(data.USR_QUIT_DT);
	$("#usrMemo").val(data.USR_MEMO);
	
	/* $("#usrPicFile").val(data.USR_PIC_FILE);
	$("#usrProFile").val(data.USR_PRO_FILE);
	$("#usrCertFile").val(data.usrCertFile);
	$("#usrRefFile").val(data.usrRefFile); */
	
	$(".changeBtn").text("수정");
	$(".subTit").text("직원조회 상세");
	
	popupOpen('popupDialog');
}

function clearPopupOpen(){
	modFlag = false;
	this.ID = "";
	$(".usrPrmsTypeA").val("").hide();;
	$(".usrPrmsTypeB").show();
	$('#usrBirthDt, #usrJoinDt').datepicker('setDate', 'today');
	$('input:radio[name=usrPrms]').eq(0).attr("checked", true);
	$('input:radio[name=usrType]').eq(0).attr("checked", true);
	
	$("#usrName").val(""),
	$("#usrNameEn").val(""),
	$("#usrLogId").val("").attr("disabled",false);
	$("#usrEmail").val("");
	
	$(".pwRow").show();
	
	$("#usrTel").val("");
	$("#usrEmgTel").val("");
	$("#usrAddr").val("");
	$("#usrEduLv").val("");
	$("#usrGradDt").val("");
	$("#usrCompany").val("");
	$("#usrDep").val("");
	$("#usrPos").val("");
	$("#usrTechLv option:eq(0)").prop("selected", true); //첫번째 option 선택
	$("#usrQuitDt").val("");
	$("#usrMemo").val("");
	$("#usrPicFile").val("");
	$("#usrProFile").val("");
	$("#usrCertFile").val("");
	$("#usrRefFile").val("");
	
	$(".changeBtn").text("등록");
	$(".subTit").text("직원조회 등록");
	popupOpen('popupDialog');
}

function goDelete(){
	
	if($("input[name='ID']:checked").length == 0){
		alert("삭제하실 항목을 선택해주세요.")
		return;
	}
	
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	
	idList = [];
	
	$("input[name='ID']:checked").each(function(e){
        if($(this).val() == "<%=USR_ID%>"){
        	alert("로그인한 ID가 포함되어있습니다.\n다시 시도해주세요.")
        	return false;
        }
        idList.push($(this).val())
    })
    
    if(idList.length == 0){
    	return
    }
	
	params = {
		idList : idList
	}
	cf_call("/groupware/member/goDelete", params, goDeleteCB);
}
function goDeleteCB(data){
	if(data.rsltStatus == "SUCC"){
		alert("삭제가 완료되었습니다.");
		location.reload();
	}else{
		alert("삭제에 실패하였습니다.");
	}
}

function openChangePwPopup(){
	if($("input[name='ID']:checked").length == 0){
		alert("비밀번호 변경할 항목을 선택해주세요.")
		return;
	}
	if($("input[name='ID']:checked").length > 1){
		alert("비밀번호 변경할 항목을 하나만 선택해주세요.")
		return;
	}
	
	$("input[name='ID']:checked").val();
	this.ID = $("input[name='ID']:checked").val();
	console.log(1111,$("input[name='ID']:checked").val());
	popupOpen('changePwPopupDialog');
}

function goChangePw(){
	if(!pwChangeFlag){
		alert("비민번호를 확인해주세요.");
		$("#usrLogChangePw").focus();
		return
	}
	params = {
		ID : this.ID,
		usrLogPw : CryptoJS.SHA256($("#usrLogChangePw").val()).toString()
	}
	cf_call("/groupware/member/goChangePw", params, goChangePwCB);
}
function goChangePwCB(data){
	if(data.rsltStatus == "SUCC"){
		alert("비민번호 변경이 완료되었습니다.");
		location.reload();
	}else{
		alert("비밀번호 변경이 실패하였습니다.");
	}
}

function checkBoxSet(){
	$("#selectAll").click(function() {
		$("input[type=checkbox]").prop("checked", $(this).prop("checked"));
	});

	$("input[type=checkbox]").click(function() {
		if (!$(this).prop("checked")) {
			$("#selectAll").prop("checked", false);
		}
	});
}

</script>
</html>