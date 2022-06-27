
window.onpageshow = function(event) {
	
	if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
		var link = document.location.href.split("/")[3]
		console.log(link)
		if(link == "login"){
			location.href="/";
		}
    }
}

var	$window			= null,
	$document		= null,
	$html			= null,
	$body			= null,
	$html_body		= null,
	$wrapper		= null,
	$header			= null,
	$activeFocus	= null,
_;

var popupOptions = {
	$popArr: [],
	zIndexUnit: 1000,
}
function popupOpen(id, callback){
	var $popWrap = $('#'+id);
	var $focus = $popWrap.find('.popup-focus');

	//팝업이 남아있는 경우
	if (popupOptions.$popArr.length){
		$activePopWrap = popupOptions.$popArr[popupOptions.$popArr.length - 1];
		$activePopWrap.addClass('is-disabled');
	}

	$popWrap.data('opener', $activeFocus).addClass('is-active');

	//다중팝업설정
	popupOptions.$popArr.push($popWrap);
	var zIndex = popupOptions.zIndexUnit + popupOptions.$popArr.length;
	$popWrap.css({'z-index':zIndex});
}

function popupClose(id, callback){
	var $popWrap = $('#'+id);
	var $focus = $popWrap.data('opener');
	var $activePopWrap = null;
	$popWrap.removeClass('is-dimmer is-active').removeAttr('style');
	
	//다중팝업 설정
	popupOptions.$popArr.pop();
	
	//팝업이 남아있는 경우
	if (popupOptions.$popArr.length){
		//팝업활성화
		$activePopWrap = popupOptions.$popArr[popupOptions.$popArr.length - 1];
		$activePopWrap.removeClass('is-disabled');

		//접근성초점
		$document.off('focusin.popupEvent click.popupEvent').on('focusin.popupEvent click.popupEvent', function(e){
			if ($activePopWrap.has(e.target).length === 0) { 
				$lastFocus = $activePopWrap.data('opener');
				$lastFocus.focus();
			}
		});
	} 
}

/* Popover */
function popoverInit(){
	$document.off('click.popoverEvent').on('click.popoverEvent', '.js-popover', function(e){
		popoverOpen($(this).data('id'));
	});
	$document.off('focusin.popoverEvent2 click.popoverEvent2').on('focusin.popoverEvent2 click.popoverEvent2', function(e){
		$('div.popover.is-active').each(function(){
			var id = $(this).attr('id');
			if ($('div.popover-area').has(e.target).length === 0 && !$(e.target).hasClass('.js-popover')){
				popoverClose(id);
			}
		})
	});
}
function popoverOpen(id, callback){
	$('div.popover.is-active').each(function(){ popoverClose($(this).attr('id')) });
	$('#'+id).addClass('is-active');
	console.log($('#'+id).hasClass('is-active'));
	$('button[data-id='+id+']').addClass('is-active').attr({'aria-expanded':'true'});
	setCallback(callback);
}
function popoverClose(id, callback){
	$('#'+id).removeClass('is-active');
	$('button[data-id='+id+']').removeClass('is-active').attr({'aria-expanded':'false'});
	setCallback(callback);
}

/**
 * Datepicker 셋팅
 * gw_datepickerInit('#id1, #id2, ...');
 */
function gw_datepickerInit(id) {
	$(id).datepicker({
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
}
