<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/common_header.jsp"%>
<%
	List<PentasMap> mbrList = (List<PentasMap>) request.getAttribute("mbrList");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펜타에스</title>
	<%@include file="/WEB-INF/jsp/common/include/static_resource.jsp"%>
	<%@include file="/WEB-INF/jsp/common/include/gw_static_resource.jsp"%>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />
</head>
<body>
	<div id="wrap">
	<%@include file="/WEB-INF/jsp/common/include/header_gw.jsp"%>
	<div class="mainCont">
		<div class="container">
			<div id="sideBar">
				<%@include file="/WEB-INF/jsp/common/include/lnb.jsp"%>
			</div>
			<div class="visual_item">
				<div class="formWrap formWrapProfile">
					<h2 class="header">
						<div class="shbox">
							<div class="innerContView">
								<h4 class="subTit tblMb">업무실적조회</h4>
							</div>
						</div>
						<div class="row-con-l authBtnArea">
							<div class="list-contsz flex">
								<div class="title-l" style="width: 10%">직원 선택</div>
				                <div class="input input-list flex">
					                <select type="text" maxlength="50" id="searchEmpId">
					                <option class="button" value="all"><span>선택</span></option>
		                	<%for(PentasMap mbr : mbrList) { %>
								<option class="button" value="<%=mbr.get("ID")%>"><span><%=mbr.get("USR_NAME")%>(<%=mbr.get("USR_TYPE")%> - <%=mbr.get("USR_COMPANY")%>)</span></option>
							<% } %>
					                </select>
					            </div>
							</div>
							<div class="btn_wrap">
								<button type="button" class="btn btn-com" onclick="goSearch()">
									<span>조회</span>
								</button>
							</div>
						</div>
					</h2>
					<div class="form formProfile pd-0 wi-100">
						<div class="row-con-t">
							<table>
								<colgroup>
									<col style="width: 5%">
									<col style="width: 15%">
									<col style="width: 45%">
									<col style="width: 10%">
									<col style="width: 10%">
									<col style="width: 10%">
								</colgroup>
								<thead>
									<tr class="notice_table_tr_top02">
										<th>번호</th>
										<th>고객사</th>
										<th>프로젝트명</th>
										<th>시작일</th>
										<th>종료일</th>
										<th>장소</th>
									</tr>
								</thead>
								<tbody id="listDiv"></tbody>
							</table>
<%-- 							<%@include file="/WEB-INF/jsp/common/include/pagination.jsp"%> --%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="prjLayerPop" class="popup-wrap type-basic">
		<section class="popup demo1" style="height: auto">
			<div class="popup-head">
				<h3 class="popup-tit">프로젝트 정보</h3>
			</div>
			<div class="popup-body">
				<div class="popup-content">
					<div class="formWrap formWrapProfile">
						<div class="form formProfile">
							<div class="base profile image">
							    <div class="container">
							        <div class="info-container mrl-0">
							        	<div class="info-detail disbet">
					                        <div class="item wi-50">
					                            <div class="label">프로젝트명</div>
					                            <div class="value" id="prjName"></div>
					                        </div>
					                        <div class="item item-full wi-50">
					                        	<div class="label">진행단계</div>
					                        	<div class="value" id="prjStatus"></div>
					                   		</div>
							            </div>
							            
							            <div class="info-detail disbet">
					                        <div class="item wi-50">
					                            <div class="label" style="word-break:keep-all">프로젝트 시작일</div>
					                            <div class="value" id="prjStartDt"></div>
					                        </div>
					                        <div class="item item-full wi-50">
					                        	<div class="label" style="word-break:keep-all">프로젝트 종료일</div>
					                        	<div class="value" id="prjEndDt"></div>
					                   		</div>
							            </div>
							            
							            <div class="info-detail disbet" style="margin-top:5px">
					                        <div class="item wi-50">
					                            <div class="label">고객사명</div>
					                            <div class="value" id="prjClient"></div>
					                        </div>
					                        <div class="item item-full wi-50">
					                        	<div class="label">장소</div>
					                        	<div class="value" id="prjLocation"></div>
					                   		</div>
							            </div>
							            <div class="info-detail">
					                        <div class="item item-full">
					                        	<div class="label" style="word-break:keep-all">프로젝트 관련파일1</div>
					                        	<div class="value" style="width:100%">
					                        		<a id="a_prjFile01" style="width:100%">
					                        			<input class="file-name" type="text" id="name_prjFile01" readonly="readonly" style="cursor: pointer; border:none; width: 100%"/>
					                        		</a>
					                        	</div>
					                   		</div>
							            </div>
							            <div class="info-detail">
					                        <div class="item item-full">
					                        	<div class="label" style="word-break:keep-all">프로젝트 관련파일2</div>
					                        	<div class="value" style="width:100%">
					                        		<a id="a_prjFile02" style="width:100%">
					                        			<input type="text" id="name_prjFile02" readonly="readonly" style="cursor: pointer; border:none; width: 100%"/>
					                        		</a>
					                        	</div>
					                   		</div>
							            </div>
							            <div class="info-detail">
					                        <div class="item item-full">
					                        	<div class="label" style="word-break:keep-all">프로젝트 관련파일3</div>
					                        	<div class="value" style="width:100%">
					                        		<a id="a_prjFile03" style="width:100%">
					                        			<input type="text" id="name_prjFile03" readonly="readonly" style="cursor: pointer; border:none; width: 100%"/>
					                        		</a>
					                        	</div>
					                   		</div>
							            </div>
							            <div class="info-detail">
					                        <div class="item item-full">
					                        	<div class="label" style="word-break:keep-all">프로젝트 관련파일4</div>
					                        	<div class="value" style="width:100%">
					                        		<a id="a_prjFile04" style="width:100%">
					                        			<input type="text" id="name_prjFile04" readonly="readonly" style="cursor: pointer; border:none; width: 100%"/>
					                        		</a>
					                        	</div>
					                   		</div>
							            </div>
							            <div class="info-detail">
					                        <div class="item item-full">
					                        	<div class="label" style="word-break:keep-all">프로젝트 관련파일5</div>
					                        	<div class="value" style="width:100%">
					                        		<a id="a_prjFile05" style="width:100%">
					                        			<input type="text" id="name_prjFile05" readonly="readonly" style="cursor: pointer; border:none; width: 100%"/>
					                        		</a>
					                        	</div>
					                   		</div>
							            </div>
							        </div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="popup-close">
					<button type="button" class="btn btn-close" onclick="prjLayerPopClose()">
						<span><img src="/static_resources/groupware/image/ico_close01.png"></span>
					</button>
				</div>
			</div>
		</section>
		<!-- 모달(팝업) [e] -->
	</div>
	<%@include file="/WEB-INF/jsp/common/include/footer_gw.jsp"%>
					</div>
</body>
<script>
var ID = ""
var USR_PRMS = "<%=USR_PRMS%>"
var USR_ID = "<%=USR_ID%>"

var prjInfo = {}

$(function() {
	authChk()
	goSearch()
})

function authChk(){	// 회원 권한에 따른 화면처리
	if(USR_PRMS !== 'ADMIN'){
		$(".authBtnArea").hide()
	}
}

function layerInit(){
	$("#prjName").text("")
	$("#prjStartDt").text("")
	$("#prjEndDt").text("")
	$("#prjStatus").text("")
	$("#prjClient").text("")
	$("#prjLocation").text("")

	/* 파일 업로드 S */
	setAttachFile("prjFile01", "")
	setAttachFile("prjFile02", "")
	setAttachFile("prjFile03", "")
	setAttachFile("prjFile04", "")
	setAttachFile("prjFile05", "")
	/* 파일 업로드 E */
}

function prjLayerPopOpen(){
	$(".popup-body").scrollTop(0)
	$('body').css('overflow', 'hidden')
	authChk()	// 회원 권한에 따른 화면처리
	popupOpen('prjLayerPop')
}

function prjLayerPopClose(){
	$('body').css('overflow', '')
	popupClose('prjLayerPop')
}

function goSearch() {
	var params = {
		empId : $('#searchEmpId').val()
	}
	// 관리자가 아닐경우 본인ID
	if(USR_PRMS !== 'ADMIN'){
		params.empId = USR_ID
	}
	cf_call("/groupware/empPerformance/getPrjList", params, goSearchCB)
}
function goSearchCB(data) {
	g_dataList = data.prjList
	
	$("#listDiv").html("")
	var listDivHtml = ""
	if (g_dataList.length === 0) {
		listDivHtml += '<tr class="notice_table_tr_top2_2">'
		listDivHtml += '	<td colspan="6" class="wi-100">검색결과가 없습니다.</td>'
		listDivHtml += '</tr>'
	} else {
		for (var i = 0; i < g_dataList.length; i++) {
			listDivHtml += '<tr class="notice_table_tr_top2_2">'
			listDivHtml += '	<td>'+ (g_dataList.length - i) +'</td>'
			listDivHtml += '	<td>'+ g_dataList[i].PRJ_CLIENT +'</td>'
			listDivHtml += '	<td><div class="mrl-10" style="float : left">'+ g_dataList[i].PRJ_NAME +'</div></td>'
			listDivHtml += '	<td>'+ g_dataList[i].PRJ_START_DT +'</td>'
			listDivHtml += '	<td>'+ g_dataList[i].PRJ_END_DT +'</td>'
			listDivHtml += '	<td>'+ g_dataList[i].PRJ_LOCATION +'</td>'
			listDivHtml += '</tr>'
		}
	}
	$("#listDiv").html(listDivHtml)
}
/* 20210914 테스트 피드백 적용
function prjDetail(ID) {
	this.ID = ID
	var params = {
		ID : ID			
	}
	cf_call("/groupware/empPerformance/getProjectInfo", params, function(rslt){
		var prjInfo = rslt.prjInfo
		layerInit()
		$("#prjName").text(prjInfo.PRJ_NAME)
		$("#prjStartDt").text(prjInfo.PRJ_START_DT)
		$("#prjEndDt").text(prjInfo.PRJ_END_DT)
		$("#prjStatus").text(prjInfo.PRJ_STATUS_TXT)
		$("#prjClient").text(prjInfo.PRJ_CLIENT)
		$("#prjLocation").text(prjInfo.PRJ_LOCATION)
		
		setAttachFile("prjFile01", prjInfo.PRJ_FILE_01)
		setAttachFile("prjFile02", prjInfo.PRJ_FILE_02)
		setAttachFile("prjFile03", prjInfo.PRJ_FILE_03)
		setAttachFile("prjFile04", prjInfo.PRJ_FILE_04)
		setAttachFile("prjFile05", prjInfo.PRJ_FILE_05)
		
		prjLayerPopOpen()
	})
}

function setAttachFile(target, data){
	$("#a_" + target).val(data);
	$("#a_" + target).attr("href", "/fileDn?p=" + data);
	
	if(data === "" || data == null){
	 	$("#a_" + target).hide();
	 	$("#name_" + target).val("");
	} else {
		cf_orgFileNm2Text("name_" + target, data);
		$("#a_" + target).show();
	} 
}
*/
</script>
</html>