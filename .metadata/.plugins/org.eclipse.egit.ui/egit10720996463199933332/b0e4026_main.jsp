<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/jsp/common/include/common_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펜타에스</title>
	<%@include file="/WEB-INF/jsp/common/include/static_resource.jsp" %>
	<%@include file="/WEB-INF/jsp/common/include/gw_static_resource.jsp" %>
</head>
<body>
	<%@include file="/WEB-INF/jsp/common/include/header_gw.jsp"%>
	<div class="mainCont">

		<div class="container">
			<div id="sideBar">
				<!-- <h1></h1> -->
				<%@include file="/WEB-INF/jsp/common/include/lnb.jsp"%>
			</div>
			
			<div class="visual_item">
				<div style="padding-bottom: 20px;">
					1. form태그는
					class="formWrap formWrapProfile"
					부분영역을 사용하시면 됩니다.
					<br>
					2. 두가지 섹션이 생길경우
					class="input input-end"을 추가해주시면 됩니다. (border-top이 없습니다.)
					베이스는 class="input input-end"입니다.
					<br>
					3. popup은
					onclick="popupOpen('popupDialog')" 을 붙여주시면 모달창이 나옵니다.
				</div>
				
				<div id="contents" class="reportCont">
					<div class="formWrap formWrapProfile" style="margin-bottom: 40px;">
					    <h2 class="header">
						    <div class="innerContView">
								<h4 class="subTit tblMb">에이콘 모음</h4>
							</div>
						</h2>
						<i class="bi bi-calendar3"></i>
					 </div>
				
				
					<div class="formWrap formWrapProfile">
					    <h2 class="header">
						    <div class="innerContView">
								<h4 class="subTit tblMb">포트폴리오</h4>
							</div>
							<div class="description"><span class="star">*</span> 필수 입력 정보입니다.</div>
						</h2>
						
						
					    <div class="formWrap formWrapPortfolio" id="formPortfolio">
<!-- 						  <h2 class="header">포트폴리오</h2> -->
							<div class="btn_wrap disbetr mr-b20">
						 		<!-- 버튼 기본 컬러  -->
				                <button type="button" class="btn btn-com" onclick="popupOpen('btnUrlAdd')"><span>URL 추가</span></button>
						 		<!-- 버튼 기본 컬러  -->
				                
				                <!-- 2개있 을때 -->
				                <button type="button" class="btn btn-list"><span>등록</span></button>
				                <button type="button" class="btn btn-del"><span>삭제</span></button>
				                <!-- 2개있 을때 -->
				            </div>		
						  <div class="form formPortfolio">
						      <input id="UserResume_Attach_File_Name" name="UserResume.Attach_File_Name" type="hidden" value="5901103,">
						      <div class="buttons add devButtonArea" style="display:none;">
						          <button type="button" class="button buttonAddUrl is-event is-popup-visible" id="btnUrlAdd2"><span>URL 추가</span></button>
						          <button type="button" class="button buttonAddUrl is-event is-popup-visible" id="btnMyPCAdd2"><span>파일추가</span></button>
						      </div>
								<div class="file-con flex">
							      	<div class="portfolioList cont">
										<ul>
										  <li>
											<div class="filename"></div>
											<input type="hidden" id="idx_c416" value="5901103">
											<input type="hidden" id="FileUpStat_c416" value="2">
										  </li>
										</ul>
							        </div>								
									<div class="btn_wrap disbetr">
										<button type="button" class="btn btn btn-com">삭제</button>
									</div>
								</div>
						    </div>
	
						</div>
				        
			            
					 </div>
					 
					 
					<div class="formWrap formWrapProfile">
					    <h2 class="header">
						    <div class="innerContView">
								<h4 class="subTit tblMb">직원관리</h4>
							</div>
							<div class="description"><span class="star">*</span> 필수 입력 정보입니다.</div>
						</h2>
						
					    <div class="form formProfile">
					        <div class="picture dropped" style="">
				                <div class="guide" style="display: none;">사진추가</div>
				                <a href="#" class="buttonAddFile" style="display: none;">
				                    사진등록
				                </a>
				                <div class="image" aria-hidden="true">
				                    <img src="../../../static_resources/groupware/image/rian.jpg">
				                </div>
				                <span class="file-add">
                                     <input type="text" id="sFileName21" class="input demo1" title="첨부된 파일명" style="display: none;">
                                     <label for="sFilesAdd21" class="btn demo1 btn-file" role="button">
                                         <span><input type="file" style="display: none;" name="sFilesAdd21" id="sFilesAdd21" value="찾아보기" tabindex="-1" aria-hidden="true">첨부</span>
                                     </label>
                                 </span>
					        </div>
					        <div class="row">
				                <div class="input is-label input-profile-name is-value">
				                    <div class="label">구분<span class="star">*</span></div>
				                    <div class="radio-area">
					                    <div class="radio-tx-area">
			                                <span class="radio tx">
			                                    <input type="radio" name="sRadio1" id="sRadio1" checked>
			                                    <label for="sRadio1"><div>직원</div></label>
			                                </span>
			                            </div>
			                            <div class="radio-tx-area">
					                        <span class="radio tx">
			                                    <input type="radio" name="sRadio1" id="sRadio2">
			                                    <label for="sRadio2"><div>프리랜서</div></label>
			                                </span>
			                            </div>
			                            <div class="radio-tx-area">
			                                <span class="radio tx">
			                                    <input type="radio" name="sRadio1" id="sRadio3">
			                                    <label for="sRadio3"><div>협력사</div></label>
			                                </span>
			                            </div>
				                    </div>
	
				                </div>
				                
				                <div class="input is-label input-profile-birth is-value">
				                	<input type="name" placeholder="이름을 입력해주세요." value="엄석대">
				                    <div class="label">이름<span class="star">*</span></div>
				                </div>
				            </div>
				            <div class="row">
				                <div class="input is-label dropdown-profile-sex is-value">
				                	<input type="name" placeholder="이름을 입력해주세요." value="KIMJUNYOUNG">
				                    <div class="label">성명(영문)<span class="star">*</span></div>
				                </div>
				                
	
						            <div class="dropdown dropdown-education-category selected is-label">
						                <div class="label" aria-hidden="false">학교</div>
		 				                <select class="button buttonChoose" >
						                	<option class="button" selected><span>고등학교</span></option>
						                	<option class="button"><span>대학(2,3년)</span></option>
						                	<option class="button"><span>대학교(4년)</span></option>
						                	<option class="button"><span>대학원</span></option>
						                </select>
						            </div>
				            </div>
				        </div>
				        
			            <div class="form-end formProfile">
					        <div class="row">
				                <div class="input input-end is-label input-profile-name is-value">
				                	<input type="name" placeholder="이름을 입력해주세요.">
				                    <div class="label">구분<span class="star">*</span></div>
				                </div>
				                
				                <div class="input input-end is-label input-profile-birth is-value">
				                	<input type="name" placeholder="이름을 입력해주세요.">
				                    <div class="label">이름<span class="star">*</span></div>
				                </div>
							</div>
							<div class="row filebox">
				                <div class="input input-full is-label dropdown-profile-sex is-value ">
				                	<input type="file" id="file" >
								  	<input class="upload-name" placeholder="파일선택">
				                    <div class="label">성명(영문)<span class="star">*</span></div>
				                </div>
					 				<div class="btn_wrap-ll">
									  <label for="file">업로드</label> 
									 </div>

<!-- 								<div class="filebox">  -->
<!-- 								</div> -->
								
				                <div class="file-del-con">
         							<button type="button" class="btn btn-del-l"><span>삭제</span></button>
                                 </div>
				            </div>
							<div class="row">
				                <div class="input input-full is-label dropdown-profile-sex is-value">
				                	<input type="name" placeholder="이름을 입력해주세요." value="KIMJUNYOUNG">
				                    <div class="label">성명(영문)<span class="star">*</span></div>
				                </div>
				                
				            </div>
				            <div class="row">
								<div class="textarea is-label is-value">
				                    <label for="Edu_Edu_Cntnt_c15">내용</label>
				                    <textarea name="Edu[c15].Edu_Cntnt" cols="30" rows="10" id="Edu_Edu_Cntnt_c15" placeholder="이수하신 교육과정에 대해 적어주세요."></textarea>
				                </div>
				            </div>
				        </div>
					 </div>
					
					<!-- 버튼 [s] -->
				 	<div class="btn_wrap">
				 		<!-- 버튼 기본 컬러  -->
		                <button type="button" class="btn btn-com"><span>확인</span></button>
				 		<!-- 버튼 기본 컬러  -->
		                
		                <!-- 2개있 을때 -->
		                <button type="button" class="btn btn-list"><span>목록</span></button>
		                <!-- 2개있 을때 -->
		                
		                <!-- 버튼 3개일때 -->
		                <button type="button" class="btn btn-del"><span>삭제</span></button>
		                <!-- 버튼 3개일때 -->
		            </div>
					<!-- 버튼 [e] -->
					
					 
					<div class="formWrap formWrapProfile">
					    <h2 class="header">
						    <div class="innerContView">
								<h4 class="subTit tblMb">Form태그( selectbox, 검색,  )</h4>
							</div>
							<div class="description"><span class="star">*</span> 필수 입력 정보입니다.</div>
						</h2> 
						
					    <div class="form formProfile">
					        <div class="row-con">
				                <div class="input input-end is-label input-profile-name is-value">
				                	<input type="name" placeholder="이름을 입력해주세요.">
				                    <div class="label">이름<span class="star">*</span></div>
				                </div>
				                <div class="input is-label input-profile-birth is-value">
				                	<input type="name" placeholder="이름을 입력해주세요.">
				                    <div class="label">이름<span class="star">*</span></div>
				                </div>
				             </div>
				           	<div class="row-con">
				                <div class="input is-label input-profile-birth is-value">
				                	<input type="name" placeholder="이름을 입력해주세요.">
				                    <div class="label">이름<span class="star">*</span></div>
				                </div>
				                
				            </div>
				            <div class="row-con">
					            <div class="dropdown dropdown-education-category selected is-label">
					                <div class="label" aria-hidden="false">학교</div>
	 				                <select class="button buttonChoose" >
					                	<option class="button" selected><span>고등학교</span></option>
					                	<option class="button"><span>대학(2,3년)</span></option>
					                	<option class="button"><span>대학교(4년)</span></option>
					                	<option class="button"><span>대학원</span></option>
					                </select>
					            </div>
				                <div class="input input-education-name search is-label is-ellipsis is-value">
					                <label for="HighSchool_Schl_Name_Search">학교명 <span class="star">*</span></label>
					                
					                <input type="text" value="정발고등학교" maxlength="50">
					                
					                <div class="validation hidden" aria-hidden="true"></div>
						              
					                <i class="icon icon-search" aria-hidden="true"></i>
					            </div>
				            </div>
				        </div>
					 </div>
					 
					<div class="formWrap formWrapProfile">
					    <h2 class="header">
						    <div class="innerContView">
								<h4 class="subTit tblMb">상세페이지-증명사진 형식</h4>
							</div>
						</h2> 
						
					    <div class="form formProfile">
					        <div class="resume-view-container">					
								<div class="base profile image">
								    <div class="container">
								            <div class="photo"><img src="../../../static_resources/groupware/image/rian.jpg"></div>
								        <div class="info-container">
								            <div class="info-general">
								                <div class="item name">엄석대</div>
								                <div class="item sex">남</div>
								                <div class="item year">1990년 </div>
								                <div class="item age">32세</div>
								                <div class="item">인턴</div>
								            </div>
								            <div class="info-detail">
						                        <div class="item">
						                            <div class="label">휴대폰</div>
						                            <div class="value">010-0000-0000</div>
						                        </div>
						                        <div class="item item-full">
						                        	<div class="label">주소</div>
						                        	<div class="value">한국서울일본브라질콰데말라중국베이징마카오서울역한국서울일본브라질콰데말라중국베이징마카오서울역한국서울일본브라질콰데말라중국베이징마카오서울역한국서울일본브라</div>
						                   		</div>
								            </div>
								        </div>
									</div>
								</div>
			            	</div>
				        </div>
					 </div>
					 
					<div class="formWrap formWrapProfile">
					    <h2 class="header">
						    <div class="innerContView">
								<h4 class="subTit tblMb">상세페이지</h4>
							</div>
						</h2> 
						
					    <div class="form formProfile">
					        <div class="resume-view-container">					
								<div class="base profile image">
								    <div class="container">
								        <div class="info-container mrl-0">
								            <div class="info-detail disbet">
						                        <div class="item">
						                            <div class="label">휴대폰</div>
						                            <div class="value">010-0000-0000010-000010-0000-0000010-000</div>
						                        </div>
						                        <div class="item item-full wi-50">
						                        	<div class="label">주소</div>
						                        	<div class="value">한국서울일본브라질콰</div>
						                   		</div>
								            </div><div class="info-detail">
						                        <div class="item">
						                            <div class="label">휴대폰</div>
						                            <div class="value">010-0000-0000</div>
						                        </div>
						                        <div class="item item-full">
						                        	<div class="label">주소</div>
						                        	<div class="value">한국서울일본브라질콰데말라중국베이징마카오서울역한국서울일본브라질콰데말라중국베이징마카오서울역한국서울일본브라질콰데말라중국베이징마카오서울역한국서울일본브라</div>
						                   		</div>
								            </div>
								        </div>
									</div>
								</div>
			            	</div>
				        </div>
					 </div>

					 <!-- 테이블형식 -->
					<div class="formWrap formWrapProfile">
					    <h2 class="header">
					    	<div class="shbox">
							    <div class="innerContView">
									<h4 class="subTit tblMb">Table</h4>
								</div>
				            </div>
							<div class="row-con-l">
								<div class="list-contn flex">
									<div class="list-contt flex">
										<div class="title-l">프리랜서 경력조회</div>
						                <div class="input input-list-l flex">
							                <input type="text" maxlength="50" placeholder="2021.09.02">
							            </div>
						                <div class="input input-list-l flex">
							                <input type="text" maxlength="50" placeholder="2021.09.02">
							            </div>
									</div>
								</div>
								<div class="list-contss flex">
									<div class="list-contsz flex" style="/* width: 50%; */">
						                <div class="dropdown dropdown-education-category selected is-label">
							                <div class="label" aria-hidden="false">학교</div>
			 				                <select class="button buttonChoose" >
							                	<option class="button" selected><span>고등학교</span></option>
							                	<option class="button"><span>대학(2,3년)</span></option>
							                	<option class="button"><span>대학교(4년)</span></option>
							                	<option class="button"><span>대학원</span></option>
							                </select>
							            </div>
									</div>
									<div class="list-contsz flex" style="/* width: 50%; */">
						                <div class="input input-type">
						                	<input type="name" placeholder="이름을 입력해주세요.">
						                </div>
									</div>
								</div>
								<div class="btn_wrap">
							 		<!-- 버튼 기본 컬러  -->
					                <button type="button" class="btn btn-com"><span>확인</span></button>
					            </div>
							
							</div>
							
							<div class="row-con-s mrt-20">
								<div class="row-cont flex">
									<div class="list-contn">
										<div class="list-contt flex">
											<div class="title-l">프리랜서 경력조회</div>
							                <div class="input input-list-l flex">
								                <input type="text" maxlength="50" placeholder="2021.09.02">
								            </div>
							                <div class="input input-list-l flex">
								                <input type="text" maxlength="50" placeholder="2021.09.02">
								            </div>
										</div>
									</div>
									<div class="list-contss">
										<div class="list-contsz flex" style="/* width: 50%; */">
											<div class="title-l">조회기간조회기간</div>
							                <div class="input input-list flex">
								                <select type="text" maxlength="50" placeholder="검색어를 입력해주세요.">
								                	<option>협력사</option>
								                	<option>프리</option>
								                	<option>개발</option>
								                	<option>jsp</option>
								                </select>
								            </div>
										</div>
									</div>
								</div>
								<div class="row-cont flex">
									<div class="list-contn">
										<div class="list-contt flex">
											<div class="title-l">프리랜서 경력조회</div>
							                <div class="input input-list-l flex">
								                <input type="text" maxlength="50" placeholder="2021.09.02">
								            </div>
							                <div class="input input-list-l flex">
								                <input type="text" maxlength="50" placeholder="2021.09.02">
								            </div>
										</div>
									</div>
									<div class="list-contss">
										<div class="list-contsz flex" style="/* width: 50%; */">
											<div class="title-l">조회기간조회기간</div>
							                <div class="input input-list flex">
								                <select type="text" maxlength="50" placeholder="검색어를 입력해주세요.">
								                	<option>협력사</option>
								                	<option>프리</option>
								                	<option>개발</option>
								                	<option>jsp</option>
								                </select>
								            </div>
										</div>
									</div>
								</div>
							</div>
							<div class="btn_wrap mrt-20 ">
						 		<!-- 버튼 기본 컬러  -->
				                <button type="button" class="btn btn-com"><span>확인</span></button>
				            </div>
							
				            <div class="btn_wrap disbetr mrt-20">
						 		<!-- 버튼 기본 컬러  -->
				                <button type="button" class="btn btn-com"><span>확인</span></button>
						 		<!-- 버튼 기본 컬러  -->
				                
				                <!-- 2개있 을때 -->
				                <button type="button" class="btn btn-list"><span>목록</span></button>
				                <!-- 2개있 을때 -->
				                
				                <!-- 버튼 3개일때 -->
				                <button type="button" class="btn btn-del"><span>삭제</span></button>
				                <!-- 버튼 3개일때 -->
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
										<col style="width:10%">
									</colgroup>
									<thead>
									<tr class="notice_table_tr_top02">
										<th><input type="checkbox"></th>
										<th>번호</th>
										<th>제목</th>
										<th>진행상태</th>
										<th>시작일</th>
										<th>종료일</th>
									</tr>
									</thead>
									<tbody id="listDiv">
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>1</td>
											<td>
												<a onclick="goDetail('68')">우리카드&nbsp;마이데이터&nbsp;구축&nbsp;사업</a>
											</td>
											<td>
												end
											</td>
											<td>2021-04-01</td>
											<td>2021-06-01</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>2</td>
											<td>
												<a onclick="goDetail('69')">우리카드&nbsp;위비멤버스&nbsp;리뉴얼&nbsp;사업 </a>
											</td>
											<td>ing</td>
											<td>2021-02-01</td>
											<td>2021-12-31</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>3</td>
											<td>
												<a onclick="goDetail('70')">서민금융진흥원&nbsp;디지털혁시(차세대2차) 사업 </a>
											</td>
											<td>end</td>
											<td>2021-02-01</td>
											<td>2021-05-01</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>4</td>
											<td>
												<a onclick="goDetail('72')">화학분야&nbsp;온라인&nbsp;전시관&nbsp;구축 </a>
											</td>
											<td>end</td>
											<td>2020-12-01</td>
											<td>2021-03-01</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>5</td>
											<td>
												<a onclick="goDetail('71')">MyData 플랫폼&nbsp;구축&nbsp;앱&nbsp;백엔드&nbsp;서버개발 </a>
											</td>
											<td>ing</td>
											<td>2020-12-01</td>
											<td>2021-12-01</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>6</td>
											<td>
												<a onclick="goDetail('67')">농협&nbsp;목우촌&nbsp;차세대&nbsp;시스템&nbsp;UI/UX </a>
											</td>
											<td>end</td>
											<td>2020-09-01</td>
											<td>2020-11-01</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>7</td>
											<td>
												<a onclick="goDetail('73')">NH멤버스&nbsp;정보계&nbsp;및&nbsp;마케팅시스템&nbsp;포털&nbsp;구축 </a>
											</td>
											<td>ing</td>
											<td>2020-09-01</td>
											<td>2021-12-01</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>8</td>
											<td>
												<a onclick="goDetail('74')">우리페이&nbsp;은행계좌&nbsp;간편서비스&nbsp;구축&nbsp;&amp; 통합플랫폼&nbsp;사업 </a>
											</td>
											<td>end</td>
											<td>2020-08-01</td>
											<td>2021-02-01</td>
										</tr>
										<tr class="notice_table_tr_top2_2">
											<td><input type="checkbox"></td>
											<td>9</td>
											<td>
												<a onclick="goDetail('66')">기업은행&nbsp;글로벌&nbsp;차세대시스템&nbsp;고도화&nbsp;사업 </a>
											</td>
											<td>end</td>
											<td>2020-04-01</td>
											<td>2020-09-01</td>
										</tr>
										<tr class="notice_table_tr_top2_2 notice_table_tr_last_2">
											<td><input type="checkbox"></td>
											<td>10</td>
											<td>
												<a onclick="goDetail('65')">신세계인터내셔날&nbsp;매장지원&nbsp;통합시스템&nbsp;구축&nbsp;사업 </a>
											</td>
											<td>end</td>
											<td>2020-03-01</td>
											<td>2020-08-01</td>
										</tr>
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
					 
					<div class="formWrap formWrapProfile">
						<h2 class="header">
							<div class="shbox">
								<div class="innerContView">
									<h4 class="subTit tblMb">Table-검색결과 없을때</h4>
								</div>
								<div class="row-con">
									<div class="input input-education-name he-10 wi-100">
										<input type="text" maxlength="50" placeholder="검색어를 입력해주세요.">
										<div class="search-icons">
											<i class="icon icon-search" aria-hidden="true"></i>
										</div>
									</div>
								</div>
							</div>
						</h2>
						
						<div class="form formProfile pd-0 wi-100">
						    <div class="row-con">
								<table>
									<colgroup>
										<col style="width:100%">
									</colgroup>
									<thead>
										<tr class="notice_table_tr_top02">
											<th>번호</th>
											<th>제목</th>
											<th>진행상태</th>
											<th>시작일</th>
											<th>종료일</th>
										</tr>
									</thead>
									<tbody id="listDiv">
										<tr class="notice_table_tr_top2_2">
											<td class="wi-100">검색어가 없습니다.</td>
										</tr>
									</tbody>
								</table>
						    </div>
						</div>
					 </div>
					 
					<section class="g-section in-sec">
						<div class="g-section-head">
						    <h2 class="g-h2">popup Default</h2>
						</div>
						<div class="g-section-body">
					    	<button type="button" class="btn demo1 primary" onclick="popupOpen('popupDialog')" style="border: 1px solid #000;"><span style="color: #000;">Popup Basic</span></button>
					    </div>
					</section>
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
			<h3 class="popup-tit">회원가입</h3>
		</div>
		<div class="popup-body">
			<div class="popup-content">
				<div class="formWrap formWrapProfile">
					<h2 class="header">
					<div class="innerContView">
						<h4 class="subTit tblMb">테이블</h4>
					</div>
					<div class="description">
						<span class="star">*</span> 필수 입력 정보입니다.
					</div>
					</h2>
					<div class="form formProfile">
						<div class="row-con">
							<div class="input input-end is-label input-profile-name is-value">
								<input type="name" placeholder="이름을 입력해주세요." value="엄석대">
								<div class="label">
									이름<span class="star">*</span>
								</div>
							</div>
							<div class="input is-label input-profile-birth is-value">
								<input type="name" placeholder="이름을 입력해주세요.">
								<div class="label">
									이름<span class="star">*</span>
								</div>
							</div>
						</div>
						<div class="row-con">
							<div class="dropdown dropdown-education-category selected is-label">
								<div class="label" aria-hidden="false">
									학교
								</div>
								<select class="button buttonChoose">
									<option class="button" selected><span>고등학교</span></option>
									<option class="button"><span>대학(2,3년)</span></option>
									<option class="button"><span>대학교(4년)</span></option>
									<option class="button"><span>대학원</span></option>
								</select>
							</div>
							<div class="input input-education-name search is-label is-ellipsis is-value">
								<input type="text" value="정발고등학교" maxlength="50">
								<div class="validation hidden" aria-hidden="true"></div>
								<i class="icon icon-search" aria-hidden="true"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="formWrap formWrapProfile">
					<h2 class="header">
					<div class="innerContView">
						<h4 class="subTit tblMb">테이블</h4>
					</div>
					<div class="description">
						<span class="star">*</span> 필수 입력 정보입니다.
					</div>
					</h2>
					<div class="form formProfile">
						<div class="row-con">
							<div class="input input-end is-label input-profile-name is-value">
								<input type="name" placeholder="이름을 입력해주세요.">
								<div class="label">
									이름<span class="star">*</span>
								</div>
							</div>
							<div class="input is-label input-profile-birth is-value">
								<input type="name" placeholder="이름을 입력해주세요.">
								<div class="label">
									이름<span class="star">*</span>
								</div>
							</div>
						</div>
						<div class="row-con">
							<div class="dropdown dropdown-education-category selected is-label">
								<div class="label" aria-hidden="false">
									학교
								</div>
								<select class="button buttonChoose">
									<option class="button" selected><span>고등학교</span></option>
									<option class="button"><span>대학(2,3년)</span></option>
									<option class="button"><span>대학교(4년)</span></option>
									<option class="button"><span>대학원</span></option>
								</select>
							</div>
							<div class="input input-education-name search is-label is-ellipsis is-value">
								<label for="HighSchool_Schl_Name_Search">학교명 <span class="star">*</span></label>
								<input type="text" value="정발고등학교" maxlength="50">
								<div class="validation hidden" aria-hidden="true">
								</div>
								
								<i class="icon icon-search" aria-hidden="true"></i>
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
	<!-- 모달(팝업) [e] -->
</div>


<div class="popup-wrap popupPortfolioFile hidden" id="btnUrlAdd">
	<section class="popup demo2">
		<div class="popup-head">
			<h3 class="popup-tit">이력서 파일 추가</h3>
		</div>
	    <div class="popupContainer">
	        <div class="upload">
	            <span class="file-add wi-100px he-40px">
                    <input type="text" id="sFileName21" class="input demo2" title="첨부된 파일명" style="display: none;">
                    <label for="sFilesAdd21" class="btn demo2 btn-file" role="button">
                        <span><input type="file" style="display: none;" name="sFilesAdd21" id="sFilesAdd21" value="찾아보기" tabindex="-1" aria-hidden="true">첨부</span>
                    </label>
                </span>
	        </div>
	        <div>
	            <div class="cautionBx">
	                <div class="cautionInner">
	                    <p class="virusCheck">개인정보보호를 위해 개인정보가 포함된 파일은 사전동의 없이&nbsp;&nbsp;삭제될 수 있습니다.</p>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="popupFooter">
		 	<div class="btn_wrap">
	            <button type="button" class="btn btn-com"><span>확인</span></button>
               	<button type="button" class="btn btn-list"><span>닫기</span></button>
	         </div>
	    </div>
		<div class="popup-close">
			<button type="button" class="btn btn-close" onclick="popupClose('btnUrlAdd')"><span><img src="../../../static_resources/groupware/image/ico_close01.png"></span></button>
		</div>
	</section>
</div>
</html>

<script>
	$("#file").on('change',function(){
	  var fileName = $("#file").val();
	  $(".upload-name").val(fileName);
	});
</script>