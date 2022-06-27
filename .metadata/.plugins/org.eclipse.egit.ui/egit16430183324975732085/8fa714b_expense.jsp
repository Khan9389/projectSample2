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
									<h4 class="subTit tblMb">비용조회</h4>
								</div>
				            </div>
				            <!-- 검색영역 [s] -->
							<div class="row-con-l">
								<div class="list-contn flex mr10">
									<div class="list-contt flex">
										<div class="title-l">사용일자</div>
						                <div class="input input-list-l flex mr10">
							                <input type="text" maxlength="50" placeholder="2021.09.02" id="startDt">
							            </div>
						                <div class="input input-list-l flex">
							                <input type="text" maxlength="50" placeholder="2021.09.02" id="endDt">
							            </div>
									</div>
								</div>
								<div class="list-contss flex">
									<div class="list-contsz flex" style="/* width: 50%; */">
						                <input type="checkbox" name="pymntType" id="pymntType01" value="MONEY" checked>
										<label for="pymntType01">현금</label>
						                <input type="checkbox" name="pymntType" id="pymntType02" value="CORPO" checked>
										<label for="pymntType02">법인카드</label>
						                <input type="checkbox" name="pymntType" id="pymntType03" value="PERSO" checked>
										<label for="pymntType03">개인카드</label>
									</div>
								</div>
								<div class="btn_wrap">
							 		<!-- 버튼 기본 컬러  -->
					                <button type="button" class="btn btn-com" onclick="goSearch();"><span>검색</span></button>
					            </div>
							</div>
							<!-- 검색영역 [e] -->
							<!-- 버튼영역 [s] -->
							<div class="btn_wrap disbetr mrt-20">
				            	<button type="button" class="btn btn-com mr10"><span>등록</span></button>
				            	<button type="button" class="btn btn-list mr10"><span>인쇄</span></button>
				            	<button type="button" class="btn btn-del"><span>삭제</span></button>
				        	</div>
				        	<!-- 버튼영역 [e] -->
						</h2> 
						
						
					    <div class="form formProfile pd-0 wi-100">
					        <div class="row-con-t">
				               <table>
									<colgroup>
										<col style="width:5%">
										<col style="width:10%">
										<col style="width:12%">
										<col style="width:28%">
										<col style="width:10%">
										<col style="width:12%">
										<col style="width:23%">
									</colgroup>
									<thead>
									<tr class="notice_table_tr_top02">
										<th><input type="checkbox"></th>
										<th>구분</th>
										<th>비용사용일</th>
										<th>프로젝트명</th>
										<th>승인여부</th>
										<th>정산일자</th>
										<th>금액</th>
									</tr>
									</thead>
									<tbody id="listDiv">
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>법인카드</td>
											<td>2021-04-01</td>
											<td><a onclick="goDetail('68')">국민주택기금 고도화</a></td>
											<td>승인</td>
											<td>2021-04-01</td>
											<td>400,000,000</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>법인카드</td>
											<td>2021-04-01</td>
											<td><a onclick="goDetail('68')">국민주택기금 고도화</a></td>
											<td>승인</td>
											<td>2021-04-01</td>
											<td>400,000,000</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>법인카드</td>
											<td>2021-04-01</td>
											<td><a onclick="goDetail('68')">국민주택기금 고도화</a></td>
											<td>승인</td>
											<td>2021-04-01</td>
											<td>400,000,000</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>법인카드</td>
											<td>2021-04-01</td>
											<td><a onclick="goDetail('68')">국민주택기금 고도화</a></td>
											<td>승인</td>
											<td>2021-04-01</td>
											<td>400,000,000</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>법인카드</td>
											<td>2021-04-01</td>
											<td><a onclick="goDetail('68')">국민주택기금 고도화</a></td>
											<td>승인</td>
											<td>2021-04-01</td>
											<td>400,000,000</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>법인카드</td>
											<td>2021-04-01</td>
											<td><a onclick="goDetail('68')">국민주택기금 고도화</a></td>
											<td>승인</td>
											<td>2021-04-01</td>
											<td>400,000,000</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>법인카드</td>
											<td>2021-04-01</td>
											<td><a onclick="goDetail('68')">국민주택기금 고도화</a></td>
											<td>승인</td>
											<td>2021-04-01</td>
											<td>400,000,000</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>법인카드</td>
											<td>2021-04-01</td>
											<td><a onclick="goDetail('68')">국민주택기금 고도화</a></td>
											<td>승인</td>
											<td>2021-04-01</td>
											<td>400,000,000</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>법인카드</td>
											<td>2021-04-01</td>
											<td><a onclick="goDetail('68')">국민주택기금 고도화</a></td>
											<td>승인</td>
											<td>2021-04-01</td>
											<td>400,000,000</td>
										</tr>
										<tr class="notice_table_tr_top2_2 notice_table_tr_last_2">
											<td colspan="6">합계</td>
											<td>400,000,000</td>
										</tr>
									</tbody>
								</table>
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
		<h3 class="popup-tit">팝업제목</h3>
	</div>
	<div class="popup-body">
		<div class="popup-content">
			<!-- 여기에 추가해주시면 됩니다. -->	
		</div>
	</div>
	<div class="popup-close">
		<button type="button" class="btn btn-close" onclick="popupClose('popupDialog')"><span><img src="../../../static_resources/groupware/image/ico_close01.png"></span></button>
	</div>
	</section>
</div>
<script>
$(function() {
	goSearch();
	gw_datepickerInit("#startDt, #endDt");
	$("#startDt, #endDt").datepicker('setDate', 'today');
})

function goSearch() {
	var pymntType = []
	$("input[name='pymntType']:checked").each(function()
	{
		pymntType.push($(this).val());
	});
	console.log(pymntType);
	var params = {
		pymntType : pymntType
	}
	console.log(params);
	//cf_call("/groupware/cmmnCd/getMinorList", params, getDtlDataCB);
}
</script>
</html>