<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/common_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펜타에스</title>
	<%@include file="/WEB-INF/jsp/common/include/static_resource.jsp" %>
	<%@include file="/WEB-INF/jsp/common/include/gw_static_resource.jsp" %>
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
									<h4 class="subTit tblMb">공통코드 조회</h4>
								</div>
				            </div>
				            
				            <!-- 검색영역 [s] -->
							<div class="row-con-l">
								<div class="list-contss flex">
									<div class="list-contsz flex" style="/* width: 50%; */">
										<div class="title-l">검색조건/대분류 코드/대분류명</div>
						                <div class="input input-list-l flex">
							                <input type="text" maxlength="50" placeholder="2021.09.02">
							            </div>
									</div>
								</div>
								<div class="btn_wrap">
							 		<!-- 버튼 기본 컬러  -->
					                <button type="button" class="btn btn-com"><span>확인</span></button>
					            </div>
							</div>
							<!-- 검색영역 [e] -->
							
				            <div class="btn_wrap disbetr mrt-20">
						 		<!-- 버튼 기본 컬러  -->
				                <button type="button" class="btn btn-com"><span>등록</span></button>
						 		<!-- 버튼 기본 컬러  -->
				            </div>
						</h2> 
						
					    <div class="form formProfile pd-0 wi-100">
					        <div class="row-con-t">
				               <table>
									<colgroup>
										<col style="width:10%">
										<col style="width:27%">
										<col style="width:27%">
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:16%">
									</colgroup>
									<thead>
									<tr class="notice_table_tr_top02">
										<th>번호</th>
										<th>대분류 코드</th>
										<th>대분류명</th>
										<th>소분류 갯수</th>
										<th>사용여부</th>
										<th>등록일</th>
									</tr>
									</thead>
									<tbody id="listDiv">
									</tbody>
								</table>
								<div class="board-paging">
								    <ul>
								        <li class="pg begin" onclick="cf_beginPage()"><a href="#none">맨처음</a></li>
								        <li class="pg prev" onclick="cf_prevPage()"><a href="#none">이전</a></li>
								        <div class="num" id="pagination_content"><li class="on" onclick="cf_goPage('1')"><a href="#kc">1</a></li><li onclick="cf_goPage('2')"><a href="#kc">2</a></li><li onclick="cf_goPage('3')"><a href="#kc">3</a></li></div>
								        <li class="pg next" onclick="cf_nextPage()"><a href="#none">다음</a></li>
								        <li class="pg end" onclick="cf_endPage()"><a href="#none">맨끝</a></li>
								    </ul>
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

<!-- 모달(팝업) [s] -->
<div id="popupDialog" class="popup-wrap type-basic">
	<section class="popup demo1">
		<div class="popup-head">
			<h3 class="popup-tit">공통코드 관리</h3>
		</div>
		<div class="popup-body">
			<div class="popup-content">
				<div class="formWrap formWrapProfile">
					<h2 class="header">
					<div class="innerContView">
						<h4 class="subTit tblMb">대분류</h4>
					</div>
					<div class="description">
						<span class="star">*</span> 필수 입력 정보입니다.
					</div>
					</h2>
					<div class="form formProfile">
						<div class="row-con">
							<input type="hidden" id="majorId">
							<div class="input input-end is-label input-profile-name is-value mr10">
								<input type="text" placeholder="대분류 코드를 입력해주세요." max-length="50" id="majorCd">
								<div class="label">
									대분류 코드<span class="star">*</span>
								</div>
							</div>
							<div class="input is-label input-profile-birth is-value mr10">
								<input type="text" placeholder="대분류명을 입력해주세요." max-length="50" id="majorNm">
								<div class="label">
									대분류명<span class="star">*</span>
								</div>
							</div>
							<div class="dropdown dropdown-education-category selected is-label">
								<div class="label" aria-hidden="false">
									사용여부<span class="star">*</span>
								</div>
								<select class="button buttonChoose" id="useYn">
									<option class="button" value="Y" selected><span>사용</span></option>
									<option class="button" value="N"><span>미사용</span></option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="formWrap formWrapProfile">
					<h2 class="header">
					<div class="innerContView">
						<h4 class="subTit tblMb">소분류</h4>
					</div>
					<div class="description">
						<span class="star">*</span> 필수 입력 정보입니다.
					</div>
					</h2>
					<div class="form formProfile" id="layerList">
						<div class="row-con">
							<input type="hidden" id="minorId01">
							<div class="input is-label input-profile-birth is-value mr10">
								<div class="label">
									소분류 코드 순번
								</div>
								<input type="number" id="minorCdOrd01" value="">
							</div>
							<div class="input is-label input-profile-birth is-value mr10">
								<input type="text" placeholder="소분류 코드를 입력해주세요." max-length="50" id="minorCd01">
								<div class="label">
									소분류 코드<span class="star">*</span>
								</div>
							</div>
							<div class="input is-label input-profile-birth is-value mr10">
								<input type="text" placeholder="소분류명을 입력해주세요." max-length="50" id="minorNm01">
								<div class="label">
									소분류명<span class="star">*</span>
								</div>
							</div>
							<div class="dropdown dropdown-education-category selected is-label">
								<div class="label" aria-hidden="false">
									삭제여부<span class="star">*</span>
								</div>
								<select class="button buttonChoose" id="delYn01">
									<option class="button" value="N" selected><span>-</span></option>
									<option class="button" value="Y"><span>삭제</span></option>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="popup-close">
			<button type="button" class="btn btn-close" onclick="popupClose('popupDialog')"><span><img src="../../../static_resources/groupware/image/ico_close01.png"></span></button>
		</div>
	</section>
</div>
<!-- 모달(팝업) [e] -->
<script>
$(function() {
	goSearch();
})

function goSearch() {
	cv_pageInfo.func = goSearch;
	var pageInfo = {
			pageNo : cv_pageInfo.pageNo,
			orders : [
				{target : "MAJOR_CD_NO", isAsc : false},
			],
			limit : 10
	}
	
	params = {
		//word : $("#word").val().trim()
		word : ''
	}
	cf_callPage("/groupware/cmmnCd/getMajorList", params, pageInfo, goSearchCB);
}

function goSearchCB(data) {
	g_dataList = data.list;
	
	$("#listDiv").html("");
	var listDivHtml = "";

	if (g_dataList.length === 0) {
		listDivHtml += '<tr class="notice_table_tr_top2_2">';
		listDivHtml += '	<td class="wi-100">해당하는 정보가 없습니다.</td>';
		listDivHtml += '</tr>';
	} else {
	 	for (var i = 0; i < g_dataList.length; i++) {
			listDivHtml += '<tr class="notice_table_tr_top2_2">';
	 		listDivHtml += '	<td>' + g_dataList[i].MAJOR_CD_NO + '</td>';
	 		listDivHtml += '	<td><a onclick="goDetail(\'' + g_dataList[i].ID + '\')">' + g_dataList[i].MAJOR_CD + '</a></td>';
	 		listDivHtml += '	<td><a onclick="goDetail(\'' + g_dataList[i].ID + '\')">' + g_dataList[i].MAJOR_NM + '</a></td>';
	 		listDivHtml += '	<td>' + g_dataList[i].MINOR_CNT + '</td>';
	 		listDivHtml += '	<td>' + (g_dataList[i].USE_YN === 'Y' ? '사용' : '미사용') + '</td>';
	 		listDivHtml += '	<td>' + g_dataList[i].REG_DT + '</td>';
			listDivHtml += '</tr>';
		}
	}
 	
	$("#listDiv").html(listDivHtml);
	$(".notice_table_tr_top2_2").last().addClass("notice_table_tr_last_2");
}

var dtlData = {};
var isDtlOpen = false;
var minorSize = 1;

function goDetail(id) {
	if (id !== undefined) {
		getDtlData(id);
		isDtlOpen = true;
	} else {
		dtlData = {};
		
		$("majorId").val('');
		$("#majorCd").val('');
		$("#majorNm").val('');
		$("#useYn").val('');
		
		$("#majorId").val('');
		$("#majorCd").val('');
		$("#majorNm").val('');
		$("#useYn").val('');
		
		minorSize = 1;
		
		popupOpen('popupDialog');
	}
}

function getDtlData(id, mode) {
	for (var i = 0; i < g_dataList.length; i++) {
		if (g_dataList[i].ID === id) {
			dtlData = g_dataList[i];
			break;
		}
	}
	
	var params = {
		MAJOR_CD_ID : dtlData.ID
	}
	cf_call("/groupware/cmmnCd/getMinorList", params, getDtlDataCB);
}

function getDtlDataCB(data) {
	var minorList = data;
	
	$("#layerList").html("");
	var layerListHtml = "";
	
	if (data.length === 0) {
		layerListHtml += '<div class="row-con">';
		layerListHtml += '	<input type="hidden" id="minorId01" value="">';
		layerListHtml += '	<div class="input is-label input-profile-birth is-value mr10">';
		layerListHtml += '		<div class="label">소분류 코드 순번</div>';
		layerListHtml += '		<input type="number" id="minorCdOrd01" value="">';
		layerListHtml += '	</div>';
		layerListHtml += '	<div class="input is-label input-profile-birth is-value mr10">';
		layerListHtml += '		<input type="text" placeholder="소분류 코드를 입력해주세요." max-length="50" id="minorCd01">';
		layerListHtml += '		<div class="label">소분류 코드<span class="star">*</span></div>';
		layerListHtml += '	</div>';
		layerListHtml += '	<div class="input is-label input-profile-birth is-value mr10">';
		layerListHtml += '		<input type="text" placeholder="소분류명을 입력해주세요." max-length="50" id="minorNm01">';
		layerListHtml += '		<div class="label">소분류명<span class="star">*</span></div>';
		layerListHtml += '	</div>';
		layerListHtml += '	<div class="dropdown dropdown-education-category selected is-label">';
		layerListHtml += '		<div class="label" aria-hidden="false">삭제<span class="star">*</span></div>';
		layerListHtml += '		<select class="button buttonChoose" id="delYn01">';
		layerListHtml += '			<option class="button" value="N" selected><span>-</span></option>';
		layerListHtml += '			<option class="button" value="Y"><span>삭제</span></option>';
		layerListHtml += '		</select>';
		layerListHtml += '	</div>';
		layerListHtml += '</div>';
	} else {
		minorSize = minorList.length;
		
		for (var i = 0; i < minorList.length; i++) {
			var idNum = (i + 1).toString().padStart(2, '0');
			layerListHtml += '<div class="row-con">';
			layerListHtml += '	<input type="hidden" id="minorId' + idNum + '" value="' + minorList[i].ID + '">';
			layerListHtml += '	<div class="input is-label input-profile-birth is-value mr10">';
			layerListHtml += '		<div class="label">소분류 코드 순번</div>';
			layerListHtml += '		<input type="number" id="minorCdOrd' + idNum + '" value="' + minorList[i].MINOR_CD_ORD + '">';
			layerListHtml += '	</div>';
			layerListHtml += '	<div class="input is-label input-profile-birth is-value mr10">';
			layerListHtml += '		<input type="text" placeholder="소분류 코드를 입력해주세요." max-length="50" id="minorCd' + idNum + '" value="' + minorList[i].MINOR_CD + '">';
			layerListHtml += '		<div class="label">소분류 코드<span class="star">*</span></div>';
			layerListHtml += '	</div>';
			layerListHtml += '	<div class="input is-label input-profile-birth is-value mr10">';
			layerListHtml += '		<input type="text" placeholder="소분류명을 입력해주세요." max-length="50" id="minorNm' + idNum + '" value="' + minorList[i].MINOR_NM + '">';
			layerListHtml += '		<div class="label">소분류명<span class="star">*</span></div>';
			layerListHtml += '	</div>';
			layerListHtml += '	<div class="dropdown dropdown-education-category selected is-label">';
			layerListHtml += '		<div class="label" aria-hidden="false">삭제<span class="star">*</span></div>';
			layerListHtml += '		<select class="button buttonChoose" id="delYn' + idNum + '">';
			layerListHtml += '			<option class="button" value="N" selected><span>-</span></option>';
			layerListHtml += '			<option class="button" value="Y"><span>삭제</span></option>';
			layerListHtml += '		</select>';
			layerListHtml += '	</div>';
			layerListHtml += '</div>';
		}
	}
	$("#layerList").html(layerListHtml);

	$("majorId").val(dtlData.ID);
	$("#majorCd").val(dtlData.MAJOR_CD);
	$("#majorNm").val(dtlData.MAJOR_NM);
	$("#useYn").val(dtlData.USE_YN);
	
	if (isDtlOpen) {
		popupOpen('popupDialog');
		isDtlOpen = false;
	}
}
</script>
</html>