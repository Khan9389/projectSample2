<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/common_header.jsp"%>
<%
	List<PentasMap> apprStatusList = (List<PentasMap>) request.getAttribute("apprStatusList");
	List<PentasMap> mbrList = (List<PentasMap>) request.getAttribute("mbrList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펜타에스</title>
<%@include file="/WEB-INF/jsp/common/include/static_resource.jsp"%>
<%@include file="/WEB-INF/jsp/common/include/gw_static_resource.jsp"%>
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
									<h4 class="subTit tblMb">비용 승인</h4> 
								</div>
							</div>
							<!-- 검색영역 [s] -->
							<div class="row-con-l">
								<div class="list-contn flex">
									<div class="list-contt flex">
										<div class="title-l">조회기간</div>
										<div class="input input-list-l flex mr10">
											<input type="text" maxlength="10" placeholder="시작일"
												id="startDt" class="dpInput">
										</div>
										<div class="input input-list-l flex">
											<input type="text" maxlength="10" placeholder="종료일"
												id="endDt" class="dpInput">
										</div>
									</div>
								</div>
								<div class="list-contss flex">
									<div class="list-contsz flex mr10" style="width: 50%">
										<div class="input input-list flex" style="border: none">
											<select name="searchType" id="searchType">
												<option value="" selected>승인구분</option>
												<%
												for (PentasMap map : apprStatusList) {
												%>
												<option value="<%=map.get("MINOR_CD")%>"><span><%=map.get("MINOR_NM")%></span></option>
												<%
												}
												%>
											</select>
										</div>
									</div>
									<div class="list-contsz flex mr10">
										<div class="input input-list flex" style="border: none">
											<select id="searchType">
												<option value="" selected>사원명</option>
												<%
												for (PentasMap map : mbrList) {
												%>
												<option value="<%=map.get("ID")%>"><span><%=map.get("USR_NAME")%>(<%=map.get("USR_TYPE")%>-<%=map.get("USR_COMPANY")%>)</span></option>
												<%
												}
												%>
											</select>
										</div>
									</div>
								</div>
								<div class="btn_wrap">
									<button type="button" class="btn btn-com" onclick="goSearch()">
										<span>조회</span>
									</button>
								</div>
							</div>
							<!-- 검색영역 [e] -->
							<!-- 버튼영역 [s] -->
							<div class="btn_wrap disbetr mrt-20">
								<button type="button" class="btn btn-com mr10" onclick="goWrite();">
									<span>등록</span>
								</button>
								<button type="button" class="btn btn-list mr10">
									<span>다운로드</span>
								</button>
								<button type="button" class="btn btn-del" onclick="goDelete();">
									<span>삭제</span>
								</button>
							</div>
							<!-- 버튼영역 [e] -->
						</h2>


						<div class="form formProfile pd-0 wi-100">
							<div class="row-con-t">
								<table>
									<colgroup>
										<col style="width: 5%">
										<col style="width: 10%">
										<col style="width: 12%">
										<col style="width: 35%">
										<col style="width: 10%">
										<col style="width: 12%">
										<col style="width: 16%">
									</colgroup>
									<thead>
										<tr class="notice_table_tr_top02">
											<th><input type="checkbox" id="checkAll"></th>
											<th>구분</th>
											<th>비용사용일</th>
											<th>프로젝트명</th>
											<th>승인여부</th>
											<th>정산일자</th>
											<th>금액</th>
										</tr>
									</thead>
									<tbody id="listDiv">
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
			<h3 class="popup-tit">비용관리</h3>
		</div>
		<div class="popup-body">
			<div class="popup-content">
				<div class="formWrap formWrapProfile">
					<h2 class="header">
						<div class="innerContView">
							<h4 class="subTit tblMb">비용상세</h4>
						</div>
						<div class="description">
							<span class="star">*</span> 필수 입력 정보입니다.
						</div>
					</h2>

					<div class="form formProfile">
						<input type="hidden" id="expenseId" value="">
						<div class="row">
							<div class="input is-label input-profile-name is-value mr10">
								<div class="label">
									구분<span class="star">*</span>
								</div>
								<div class="radio-area">
									<div class="radio-tx-area mr10">
										<span class="radio tx"> <input type="radio"
											name="expnPymnt" id="expnPymnt01" value="MONEY" checked>
											<label for="expnPymnt01"><div>현금</div></label>
										</span>
									</div>
									<div class="radio-tx-area mr10">
										<span class="radio tx"> <input type="radio"
											name="expnPymnt" id="expnPymnt02" value="CORPO"> <label
											for="expnPymnt02"><div>법인카드</div></label>
										</span>
									</div>
									<div class="radio-tx-area">
										<span class="radio tx"> <input type="radio"
											name="expnPymnt" id="expnPymnt03" value="PERSO"> <label
											for="expnPymnt03"><div>개인카드</div></label>
										</span>
									</div>
								</div>
							</div>
							<div class="input is-label input-profile-birth is-value">
								<input type="text" id="expnCardNo" placeholder="카드번호를 입력해주세요."
									value="" maxlength="19">
								<div class="label">카드번호</div>
							</div>
						</div>
						<div class="row">
							<div class="input is-label dropdown-profile-sex is-value mr10">
								<input type="text" id="expnDt" placeholder="사용일을 입력해주세요."
									value="" maxlength="10">
								<div class="label">
									사용일<span class="star">*</span>
								</div>
							</div>
							<div class="input is-label input-profile-birth is-value">
								<input type="number" id="expnAmnt" value="0" min="0"
									max="4294967295" step="1">
								<div class="label">
									금액<span class="star">*</span>
								</div>
							</div>
						</div>
						<div class="row">
							<div
								class="dropdown dropdown-education-category selected is-label">
								<select class="button buttonChoose" id="prjName">
									<option class="button" selected><span>프로젝트를
											선택하세요.</span></option>
								</select>
								<div class="label">
									프로젝트명<span class="star">*</span>
								</div>
							</div>
						</div>
						<div class="row filebox">
			                <div class="input input-full is-label dropdown-profile-sex is-value ">
			                	<div class="input-file flex">
								  	<input type="text" id="name_expnBillFile" class="file-name" placeholder="파일업로드" readonly="readonly"/>
			                		<a class="downBtn" id="a_expnBillFile" style="display: none;">다운로드</a>
			                		<a class="delBtn mrl-10" id="del_expnBillFile" style="display: none;" onclick="delFile('expnBillFile')">삭제</a>
								  	<input type="file" id="file_expnBillFile" class="file-upload" onchange="delFile('expnBillFile')"/>
								</div>
			                    <div class="label">영수증등록<span class="star">*</span></div>
			                </div>
			 				<div class="btn_wrap-ll">
								<label for="file_expnBillFile" class="file-label">업로드</label>
							</div>
			            </div>
						<div class="row">
							<div class="textarea is-label is-value">
								<label for="expnReason">지출사유<span class="star">*</span></label>
								<textarea name="Edu[c15].Edu_Cntnt" cols="30" rows="10" maxlength="500"
									id="expnReason" placeholder="지출사유를 적어주세요."></textarea>
							</div>
						</div>
					</div>
					<!-- 버튼 [s] -->
					<div class="btn_wrap" id="layerBtnWrap">
						<button type="button" class="btn btn-com mr10" id="layerBtn01">
							<span>저장</span>
						</button>
						<button type="button" class="btn btn-list" id="layerBtn02">
							<span>취소</span>
						</button>
					</div>
					<!-- 버튼 [e] -->
				</div>
			</div>
		</div>
		<div class="popup-close">
			<button type="button" class="btn btn-close"
				onclick="popupClose('popupDialog')">
				<span><img
					src="../../../static_resources/groupware/image/ico_close01.png"></span>
			</button>
		</div>
	</section>
</div>
<script>
	$(function() {
		/* datepicker 초기화, 설정 [s] */
		gw_datepickerInit("#startDt, #endDt, #expnDt");
		
		$("#startDt").datepicker('option', 'maxDate', 0);
		$("#startDt").datepicker('setDate', '-1y');
		
		$("#endDt").datepicker('option', 'maxDate', 0);
		$("#endDt").datepicker('setDate', 'today');

		$("#expnDt").datepicker('option', 'maxDate', 0);
		$("#expnDt").datepicker('setDate', 'today');
		/* datepicker 초기화, 설정 [e] */

		$("input:radio[name='expnPymnt']").click(function() {
			setCardNoInput();
		});

		/* goSearch();
		setCardNoInput();
		setProjectList(); */
		
		$("#layerBtn02").on("click", function() { 
			popupClose('popupDialog');
		});
		
		$("#checkAll").on("click", function() {
			if ($("#checkAll").prop('checked')) {
				$(".checkOne:enabled").prop('checked', true);
			} else {
				$(".checkOne:enabled").prop('checked', false);
			}
		});
	})

	// 결제수단 값에 따라 카드번호 입력여부 세팅
	function setCardNoInput() {
		if ($("input:radio[name='expnPymnt']:checked").val() == 'MONEY') {
			$("#expnCardNo").val('');
			$("#expnCardNo").prop('disabled', true);
		} else {
			$("#expnCardNo").prop('disabled', false);
		}
	}

	// 사용자에게 배정된 프로그램 목록 호출
	function setProjectList() {
		cf_call("/groupware/expense/getMyPrjList", {}, setProjectListCB);
	}

	function setProjectListCB(data) {
		if (data.rsltStatus !== "SUCC") {
			alert(data.errMsg);
		} else {
			var prjList = data.list;

			$("#prjName").html("");
			var prjNameHtml = "";

			if (prjList.length === 0) {
				prjNameHtml += '<option class="button" value="" selected><span>배정된 프로젝트가 없습니다.</span></option>';
			} else {
				prjNameHtml += '<option class="button" value="" selected><span>프로젝트를 선택하세요.</span></option>';
				for (var i = 0; i < prjList.length; i++) {
					prjNameHtml += '<option class="button" value="' 
		 						+ prjList[i].ID 
		 						+ '"><span>'
								+ prjList[i].PRJ_NAME
								+ ' ('
								+ prjList[i].PRJ_START_DT
								+ ' ~ '
								+ prjList[i].PRJ_END_DT + ')</span></option>';
				}
			}

			$("#prjName").html(prjNameHtml);
			if (prjList.length === 0) {
				$("#prjName").prop('disabled', true);
			}
		}
	}

	// 검색
	function goSearch() {
		/* 조회일 validation [s] */
		var _startDt = $("#startDt").val();
		var _endDt = $("#endDt").val();
		if (!gw_isValidDateRange(_startDt, _endDt, false)) {
			return;
		}
		/* 조회일 validation [e] */

		/* 지불수단 validation [s] */
		var _pymntType = []
		$("input[name='pymntType']:checked").each(function() {
			_pymntType.push($(this).val());
		});
		if (_pymntType.length <= 0) {
			alert('지불수단을 하나 이상 선택하셔야 합니다.');
			return;
		}
		/* 지불수단 validation [e] */

		var params = {
			startDt : _startDt,
			endDt : _endDt,
			pymntType : _pymntType
		}
		cf_call("/groupware/expense/getList", params, goSearchCB);
	}

	function goSearchCB(data) {
		if (data.rsltStatus !== "SUCC") {
			alert(data.errMsg);
		} else {
			g_dataList = data.list;

			$("#listDiv").html("");
			var listDivHtml = "";

			if (g_dataList.length === 0) {
				listDivHtml += '<tr class="notice_table_tr_top2_2">';
				listDivHtml += '	<td class="wi-100">해당하는 정보가 없습니다.</td>';
				listDivHtml += '</tr>';
			} else {
				var totalAmt = 0;

				for (var i = 0; i < g_dataList.length; i++) {
					listDivHtml += '<tr class="notice_table_tr_top2_2">';
					listDivHtml += '	<td><input type="checkbox" class="checkOne"' 
							+ ' value="' + g_dataList[i].ID + '"' 
							+ (g_dataList[i].EXPN_APPR_STATUS === 'AUTHO' ? ' disabled' : '') 
							+ '></td>';
					listDivHtml += '	<td>' + g_dataList[i].EXPN_PYMNT_NM
							+ '</td>';
					listDivHtml += '	<td>' + g_dataList[i].EXPN_DT + '</td>';
					listDivHtml += '	<td><a onclick="goDetail(\''
							+ g_dataList[i].ID + '\')">'
							+ g_dataList[i].PRJ_NAME + '</a></td>';
					listDivHtml += '	<td>' + g_dataList[i].EXPN_APPR_STATUS_NM
							+ '</td>';
					listDivHtml += '	<td>'
							+ (g_dataList[i].PYMNT_DT === undefined
									|| g_dataList[i].PYMNT_DT === null
									|| g_dataList[i].PYMNT_DT === '' ? '-'
									: g_dataList[i].PYMNT_DT) + '</td>';
					listDivHtml += '	<td>'
							+ g_dataList[i].EXPN_AMNT.toLocaleString('ko-KR')
							+ '</td>';
					listDivHtml += '</tr>';

					totalAmt += g_dataList[i].EXPN_AMNT;
				}

				listDivHtml += '<tr class="notice_table_tr_top2_2 notice_table_tr_last_2">';
				listDivHtml += '	<td colspan="6">합계</td>';
				listDivHtml += '	<td>' + totalAmt.toLocaleString('ko-KR')
						+ '</td>';
				listDivHtml += '</tr>';
			}

			$("#listDiv").html(listDivHtml);
			if (g_dataList.length === 0) {
				$(".notice_table_tr_top2_2").last().addClass(
						"notice_table_tr_last_2");
			} else {
				$(".checkOne:enabled").on("click", function() {
					var boxNum = $(".checkOne:enabled").length;
					var checkNum = $(".checkOne:enabled:checked").length;
					if (boxNum === checkNum) {
						$("#checkAll").prop('checked', true);
					} else {
						$("#checkAll").prop('checked', false);
					}
				});
			}
		}
	}
	
	// 작성 팝업 호출
	function goWrite() {
		$("#expenseId, " 
				+ "#expnCardNo, " 
				+ "#prjName, " 
				+ ".file-name, " 
				+ "#expnReason").each(function() {
		    $(this).val('');
		});
		/* 파일 업로드 [s] */
		setAttachFile("expnBillFile", "");
		/* 파일 업로드 [e] */
		$("input:radio[name='expnPymnt'][value='MONEY']").prop('checked', true);
		$("#expnAmnt").val(0);
		$("#expnDt").datepicker('setDate', 'today');
		
		$("input:radio[name='expnPymnt'], " 
				+ "#expnCardNo, " 
				+ "#expnAmnt, " 
				+ "#expnDt, " 
				+ "#prjName, " 
				+ "#file_usrRefFile, " 
				+ "#expnReason").each(function() {
		    $(this).prop('disabled', false);
		});
		setCardNoInput();
		$("#layerBtnWrap").show();
		$("#layerBtn01").off("click").on("click", function() { 
			goSave(); 
		});
		
		popupOpen('popupDialog');
	}
	
	// 작성, 수정 저장
	function goSave(id) {
		if (id === undefined) {
			id = '';
		}
		
		/* validation 구간 [s] */
		if ($("input:radio[name='expnPymnt']:checked").val() !== 'MONEY' && 
				($("#expnCardNo").val() === undefined || $("#expnCardNo").val().trim() === '')) {
			alert('카드번호가 입력되지 않았습니다.');
			$("#expnCardNo").focus();
			return;
		}
		var inputCardNo = $("#expnCardNo").val().replaceAll('-', '').replaceAll(' ', '');
		if ($("input:radio[name='expnPymnt']:checked").val() !== 'MONEY' && 
				!/^\d{13,16}$/.test(inputCardNo)) {
			alert('입력된 카드번호 형식이 올바르지 않습니다.');
			$("#expnCardNo").focus();
			return;
		}
		
		if (!gw_isValidDate($("#expnDt").val(), '사용일')) {
			$("#expnDt").focus();
			return;
		}
		
		if (!/^[1-9]\d{0,9}$/.test($("#expnAmnt").val()) || 
				Number($("#expnAmnt").val().trim()) > 4294967295) {
			alert('입력된 금액이 올바르지 않습니다.');
			$("#expnAmnt").focus();
			return;
		}
		
		if ($("#prjName").val() === undefined || $("#prjName").val().trim() === '') {
			alert('프로젝트가 선택되지 않았습니다.');
			$("#prjName").focus();
			return;
		}
		
		/* 파일 업로드 [s] */
		var fileList = [];
		var upfileIds = [];
		setFileList(fileList, upfileIds, "expnBillFile");
		/* 파일 업로드 [e] */
		
		if (($("#a_expnBillFile").val() === undefined || $("#a_expnBillFile").val().trim() === '') && 
				($("#file_expnBillFile").val() === undefined || $("#file_expnBillFile").val().trim() === '')) {
			alert('영수증이 첨부되지 않았습니다.');
			return;
		}
		
		if ($("#expnReason").val() === undefined || $("#expnReason").val().trim() === '') {
			alert('지출사유가 입력되지 않았습니다.');
			$("#expnReason").focus();
			return;
		}
		/* validation 구간 [e] */
		
		var params = {
			/* 파일 업로드 [s] */
			upfileIds : upfileIds,
			fileUseTable : "WARE_EXPENSE",
			/* 파일 업로드 [e] */
			ID : id,
			PRJ_ID : $("#prjName").val(),
			EXPN_DT : $("#expnDt").val(),
			EXPN_PYMNT : $("input:radio[name='expnPymnt']:checked").val(),
			EXPN_CARD_NO : $("#expnCardNo").val(),
			EXPN_AMNT : Number($("#expnAmnt").val()),
			/* 파일 업로드 [s] */
			EXPN_BILL_FILE : $("#a_expnBillFile").val(),
			/* 파일 업로드 [e] */
			EXPN_REASON : $("#expnReason").val(),
		}
		cf_callWithFiles("/groupware/expense/saveExpense", fileList, params, goSaveCB);
	}
	
	function goSaveCB(data) {
		if (data.rsltStatus !== "SUCC") {
			alert(data.errMsg);
		} else {
			alert('저장이 완료되었습니다.');
			goSearch();
			setProjectList();
			popupClose('popupDialog');
		}
	}
	
	// 삭제 처리
	function goDelete() {
		var _targetList = [];
		$(".checkOne:enabled:checked").each(function() {
			_targetList.push($(this).val());
		});
		
		if (_targetList.length <= 0) {
			alert('삭제항목을 하나 이상 선택하셔야 합니다.');
			return;
		}
		if (!confirm(_targetList.length + '개 항목을 삭제하시겠습니까?')) {
			return;
		}
		var params = {
			targetList : _targetList,
		}
		cf_call("/groupware/expense/goDelete", params, goDeleteCB);
	}
	
	function goDeleteCB(data) {
		if (data.rsltStatus !== "SUCC") {
			alert(data.errMsg);
		} else {
			alert('삭제가 완료되었습니다.');
			goSearch();
			setProjectList();
		}
	}

	// 상세 조회
	function goDetail(id) {
		var params = {
			ID : id,
		}
		cf_call("/groupware/expense/getDetail", params, goDetailCB);
	}

	function goDetailCB(data) {
		if (data.rsltStatus !== "SUCC") {
			alert(data.errMsg);
		} else {
			var rsltData = data.rsltData;

			$("#expenseId").val(rsltData.ID);
			$("input:radio[name='expnPymnt'][value='" + rsltData.EXPN_PYMNT + "']")
					.prop('checked', true);
			$("#expnCardNo").val(rsltData.EXPN_CARD_NO);
			$("#expnAmnt").val(rsltData.EXPN_AMNT);
			$("#expnDt").val(rsltData.EXPN_DT);
			$("#prjName").val(rsltData.PRJ_ID);
			/* 파일 업로드 [s] */
			setAttachFile("expnBillFile", rsltData.EXPN_BILL_FILE);
			/* 파일 업로드 [e] */
			$("#expnReason").val(rsltData.EXPN_REASON);
			
			if (rsltData.EXPN_APPR_STATUS === 'AUTHO') {
				$("input:radio[name='expnPymnt'], " 
						+ "#expnCardNo, " 
						+ "#expnAmnt, " 
						+ "#expnDt, " 
						+ "#prjName, " 
						+ "#file_expnBillFile, " 
						+ "#expnReason").each(function() {
				    $(this).prop('disabled', true);
				});
				$("#del_expnBillFile").hide();
				$("#layerBtnWrap").hide();
				$("#layerBtn01").off("click").on("click", function() { 
					alert('승인된 결제건은 수정할 수 없습니다.'); 
				});
			} else {
				$("input:radio[name='expnPymnt'], " 
						+ "#expnCardNo, " 
						+ "#expnAmnt, " 
						+ "#expnDt, " 
						+ "#prjName, " 
						+ "#file_expnBillFile, " 
						+ "#expnReason").each(function() {
				    $(this).prop('disabled', false);
				});
				setCardNoInput();
				$("#layerBtnWrap").show();
				$("#layerBtn01").off("click").on("click", function() { 
					goSave($("#expenseId").val());
				});
			}
			
			popupOpen('popupDialog');
		}
	}
	
	/* 파일 업로드 [s] */
	// 파일 업로드 시 값 세팅
	function setFileList(fileList, upfileIds, target){
		if(!cf_isFileEmpty("file_" + target)){
			upfileIds.push(target);
			fileList.push($("#file_" + target)[0].files[0]);
		}	
	}

	// 파일 다운로드 시 값 세팅
	function setAttachFile(target, data){
		$("#a_" + target).val(data);
		$("#a_" + target).prop("href", "/fileDn?p=" + data);
		
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
	
	// 파일 삭제 시 값 세팅
	function delFile(target){
		$("#del_" + target).hide();;
		$("#a_" + target).val("");
		$("#a_" + target).hide();
		$("#name_" + target).val( $("#file_" + target).val().substr("12") );
	}
	/* 파일 업로드 [e] */
</script>
</html>