<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펜타에스</title>
	<%@include file="/WEB-INF/jsp/common/include/static_resource.jsp"%>


<body>
	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
	
	<div class="mainCont">
		<div class="container">
			<div id="sideBar">
			</div>
			<div class="visual_item">
				<div class="reportCont">
					
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="/WEB-INF/jsp/common/include/footer.jsp"%>
</body>

<div id="popupDialog" class="popup-wrap type-basic">
	<section class="popup demo1">
	<div class="popup-head">
		<h3 class="popup-tit">회원가입</h3>
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

</html>