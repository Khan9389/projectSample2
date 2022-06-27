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
									<h4 class="subTit tblMb">공지사항</h4>
								</div>
				            </div>
				            
				            <div class="row-con-l" style="justify-content: space-between;">
								<div class="list-contn flex">
					            	<div class="title-l">제목조회</div>
									<div class="list-contsz flex" style="/* width: 50%; */">
							            <div class="input input-type">
							            	<input type="text" id="word" onkeyup="if( event.keyCode==13 ){ goSearch();}" placeholder="검색어를 입력해주세요.">
						                </div>
									</div>
								</div>
								<div class="btn_wrap">
								
					                <button type="button" class="btn btn-com" onclick="goSearch()"><span>조회</span></button>
					            </div>
							
							</div>
							
				            <div class="btn_wrap disbetr mrt-20">
				                <button type="button" class="btn btn-com wi-10 mr10"  onclick="clearPopupOpen()"><span>등록</span></button>
				                <button type="button" class="btn btn-del wi-10" onclick="goDelete()"><span>삭제</span></button>
				            </div>
						</h2> 
												
					    <div class="form formProfile pd-0 wi-100">
					        <div class="row-con-t">
				               <table>
									<colgroup>
										<col style="width:5%">
										<col style="width:10%">
										<col style="width:60%">
										<col style="width:10%">
										<col style="width:10%">
									</colgroup>
									<thead>
									<tr class="notice_table_tr_top02">
										<th><input type="checkbox" id="selectAll"></th>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
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
		<h3 class="popup-tit">공지사항</h3>
	</div>
	<div class="popup-body">
		<div class="popup-content">
			<!-- 여기에 추가해주시면 됩니다. -->	
			<div class="formWrap formWrapProfile">
				<h2 class="header">
					<div class="innerContView">
						<h4 class="subTit tblMb">공지사항</h4>
					</div>
					<div class="description">
						<span class="star">*</span> 필수 입력 정보입니다.
					</div>
				</h2>
				<div class="form formProfile">
		           	<div class="row-con">
		                <div class="input is-label input-profile-birth is-value">
		                	<input type="name" placeholder="제목을 입력해주세요." id="notiTitle">
		                    <div class="label">제목<span class="star">*</span></div>
		                </div>
		            </div>
		            <div class="row-con">
		            	<div class="textarea is-label is-value">
		                    <label for="Edu_Edu_Cntnt_c15">내용</label>
		                    <textarea name="Edu[c15].Edu_Cntnt" cols="30" rows="10" id="notiContent" placeholder="수행실적에 대해 적어주세요."></textarea>
		                </div>
		            </div>
	            </div>
            </div>
            <div class="btn_wrap">
		 		<!-- 버튼 기본 컬러  -->
                <button type="button" class="btn btn-com" onclick="goSave()"><span class="changeBtn">등록</span></button>
		 		<!-- 버튼 기본 컬러  -->
            </div>
		</div>
	</div>
	<div class="popup-close">
		<button type="button" class="btn btn-close" onclick="popupClose('popupDialog')"><span><img src="../../../static_resources/groupware/image/ico_close01.png"></span></button>
	</div>
	</section>
</div>
<script>
var ID = "";

$(function(){
	goSearch();
})

function goSearch(){
	cv_pageInfo.func = goSearch;
	var pageInfo = {
			pageNo : cv_pageInfo.pageNo,
			orders : [
				{target : "NOTI_NO", isAsc : false},
			],
			limit : 10
	}
	params = {
		word : $("#word").val().trim()
	}
	cf_callPage("/groupware/notice/getList", params, pageInfo, goSearchCB);
}
function goSearchCB(data){
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
			listDivHtml += '	<td>' + g_dataList[i].NOTI_NO + '</td>';
			listDivHtml += '	<td><a onclick="getInfo(\'' + g_dataList[i].ID + '\')">' + g_dataList[i].NOTI_TITLE + '</a></td>';
			listDivHtml += '	<td>' + g_dataList[i].AUTHOR_ID + '</td>';
			listDivHtml += '	<td>' + g_dataList[i].REG_DT + '</td>';
			listDivHtml += '</tr>';
		}
	}
 	
	$("#listDiv").html(listDivHtml);
	
	checkBoxSet();
}

function clearPopupOpen(){
	this.ID = "";
	$("#notiTitle").val("");
	$("#notiContent").val("");
	$(".changeBtn").text("등록");
	$(".subTit").text("공지사항 등록");
	
	popupOpen('popupDialog');
}

function validate(){
	if(cf_isEmpty($("#notiTitle").val().trim())){
		alert("제목을 입력하세요.");
		$("#notiTitle").focus();
		return false;
	}
	
	if(cf_isEmpty($("#notiContent").val().trim())){
		alert("내용을 입력하세요.");
		$("#notiContent").focus();
		return false;
	}
    
	return true;
}

function goSave(){
	if(!validate()) return;
	
	params = {
			ID : this.ID,
			notiTitle : $("#notiTitle").val(),
			notiContent : $("#notiContent").val(),
			USR_LOGID : "<%=USR_LOGID%>"
	};
	
	cf_call("/groupware/notice/saveInfo", params, goSaveCB);
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
	cf_call("/groupware/notice/getInfo", params, getInfoCB);
}
function getInfoCB(data){
	$("#notiTitle").val(data.NOTI_TITLE),
	$("#notiContent").val(data.NOTI_CONTENT),
	$(".changeBtn").text("수정");
	$(".subTit").text("공지사항 상세");
	popupOpen('popupDialog');
}

function goDelete(){
	
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	
	idList = [];
	
	$("input[name='ID']:checked").each(function(e){
        idList.push($(this).val())
    })
    
    params = {
		idList : idList
	}
	cf_call("/groupware/notice/goDelete", params, goDeleteCB);
}

function goDeleteCB(data){
	if(data.rsltStatus == "SUCC"){
		alert("삭제가 완료되었습니다.");
		location.reload();
	}else{
		alert("삭제에 실패하였습니다.");
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