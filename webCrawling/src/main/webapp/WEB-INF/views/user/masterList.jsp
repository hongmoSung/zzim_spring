<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../include/header.jsp" %>

<style>
	th {
		text-align:center;
	}

</style>
<section>
	<!-- 리스트 -->
	<div>
	<span id="loginEmail">${user.email}</span>
	<hr>
	<div>
		<c:if test="${not empty masterList}">
			<button type="button" name="deleteMaster" id="deleteMaster">선택항목 삭제</button>
		</c:if>
	</div>
		<table style="text-align:center; width:80%; margin:auto;">
			<thead >
				<tr>
					<th>전체 선택<input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();" /></th>
					<th>사이트</th>
					<th>아이디</th>
					<th>비밀번호</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${masterList}" var="list" varStatus="status">
					<tr>
						<td><input type="checkbox" id="checkRow" name="checkRow" value="${list.email},${list.website},${list.websiteId}" onclick="check();" /></td>
						
						<td id="first${status.index}" class="a"><span name="website${status.index}">${list.website}</span></td>
						<td id="website${status.index}" class="b">
							<select id="websiteTypeUp${status.index}" onchange="innerSelectUp(this.value)"  >
							  <option value="empty${status.index}">선택</option>
							  <option value="11st" id="op11st${status.index}">11st</option>
							  <option value="gmarket" id="opGmarket${status.index}">gmarket</option>
							  <option value="auction" id="opAuction${status.index}">auction</option>
							  <option value="interpark" id="opInterpark${status.index}">interpark</option>
							  <option value="etc" id="opEtc">직접 입력</option>
				  		    </select>
				  		 	<input type="text" value="${list.website}" name="website${status.index}" class="c"></input></td>
						
						<td id="second${status.index}" class="a"><span name="websiteId${status.index}">${list.websiteId}</span></td>
						<td id="websiteId${status.index}" class="b">
							<input type="text" value="${list.websiteId}" name="websiteId${status.index}"></td>
						
						<td id="third${status.index}" class="a"><span name="websitePw${status.index}">${list.websitePw}</span></td>
						<td id="websitePw${status.index}" class="b">
							<input type="text" value="${list.websitePw}" name="websitePw${status.index}"></td>

						<td colspan="2" id="updateMaster${status.index}" class="a">
							<button type="button" class="updateBtn" name="updateMaster${status.index}" data-no="${status.index}">편집</button></td>
						<td id="updateGo${status.index}" class="b">
							<button type="button" name="updateSubmit" data-no="${status.index}">수정</button>
							<button type="button" name="updateCancel" data-no="${status.index}">취소</button></td>
					</tr>
				</c:forEach>
				<c:if test="${empty masterList}">
					<tr>
						<td colspan='4'> &#187  관리중인 계정이 없습니다.</td>
					</tr>
				</c:if>
					<tr id="masterRegistForm" >
						<td><button type="button" name="masterRegist">&#43</button></td>
						<td> <select id="websiteType" onchange="innerSelect(this.value)" >
							  <option value="empty">선택</option>
							  <option value="11st">11st</option>
							  <option value="gmarket">gmarket</option>
							  <option value="auction">auction</option>
							  <option value="interpark">interpark</option>
							  <option value="etc">직접 입력</option>
				  		 	 </select>
							<input type="text" id="insertWebsite"></input></td>
						<td><input type="text" name="masterId" id="masterId"></td>
						<td><input type="text" name="masterPassword" id="masterPassword"></td>
					</tr>
			</tbody>
		</table>
	</div>
	
</section>

<script>

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
 
$(function() {
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
});

// hide
window.onload = function(){
	var a = $(".a");
	var b = $(".b");
	b.hide();
	$("#insertWebsite").hide();
}

// 전체 체크/해제
function checkAll() {
	var param = $("#th_checkAll").is(":checked");
	var arrcheck = document.getElementsByName("checkRow");
	for (i = 0; i < arrcheck.length; i++) {
		arrcheck.item(i).checked = param;
	}
}

// 개별 체크시 전체 체크 해제
function check(){
	var chk = $("#th_checkAll").is(":checked");
	var arrcheck = document.getElementsByName("checkRow");
	var j = 0;
	if(chk){
		$("#th_checkAll").attr("checked", false);
	}
	for (i = 0; i < arrcheck.length; i++) {
		if(arrcheck.item(i).checked) {
			j++;
			if(j == arrcheck.length){
				$("#th_checkAll").attr("checked", true);
			}
		}
	}
}

// 삭제
$("#deleteMaster").on("click", function() {
	var chk = document.getElementsByName("checkRow");
	var len = chk.length;    
	var checkRow = '';      
	var valueArray = new Array();            

	for(var i = 0; i < len; i++){
		if(chk[i].checked == true){ 
			checkRow = chk[i].value;
			valueArray.push(checkRow); 
			}
		}
	$.ajaxSettings.traditional = true; // 배열로 controller에 주기 위해
	$.ajax({
		url: "masterDelete",
		type: "POST",
		data: {
			'valueArray' : valueArray,
		}
		}).done(function (result){
			alert("삭제 완료");
			window.location.reload();
	});
})

// 등록 select박스 이벤트
function innerSelect(value){
	if(value == 'etc'){
		$("#insertWebsite").show(); 
	}
	if(value != 'etc'){
		$("#insertWebsite").hide();
	}
}
// 등록
$("button[name='masterRegist']").on("click", function() {
	var email = $("#loginEmail").text();
	var websiteId = $("#masterId").val();
	var websitePw = $("#masterPassword").val();
	var websiteType =  $("#websiteType option:selected").text();

	if(websiteType == '선택'){
		alert('사이트 입력할 것');
	}else if(websiteId == ''){
		alert('아이디 입력할 것');
		$("#masterId").focus();
	}else if(websitePw == ''){
		alert('비밀번호 입력할 것');
		$("#masterPassword").focus();
	}else{
		console.log(websiteType);
		if(websiteType =='직접 입력'){
			$.ajax({
				url: "masterInsert",
				type: "POST", 
				data: {
					email : email,
					website : $("#insertWebsite").val(),
					websiteId : websiteId,
					websitePw : websitePw
				}
				}).done(function (result){
					alert(result);
					window.location.reload();
				})
		} else {
			$.ajax({
				url: "masterInsert",
				type: "POST", 
				data: {
					email : email,
					website : websiteType,
					websiteId : websiteId,
					websitePw : websitePw
				}
				}).done(function (result){
					alert(result);
					window.location.reload();
				})
		}
	}
})

// 편집
$(".updateBtn").on("click", function(){
	var dataNo = $(this).attr('data-no');
	var website = $("span[name='website" + dataNo + "']").text();
  // 편집 폼 중복 방지
  	var a = $(".a");
  	var b = $(".b");
	var c = $(".c");
	a.show();
	b.hide();
  	c.hide();
  	
  	switch(website){
  		case '11st' : $("#op11st"+dataNo).attr("selected", "selected"); break;
  		case 'gmarket' : $("#opGmarket"+dataNo).attr("selected", "selected"); break;
  		case 'auction' : $("#opAuction"+dataNo).attr("selected", "selected"); break;
  		case 'interpark' : $("#opInterpark"+dataNo).attr("selected", "selected"); break;
  		case 'etc' : $("#opEtc"+dataNo).attr("selected", "selected"); c.show(); break;
  	}
	  	
	// 컨텐트 숨기기
	$("#first"+dataNo).hide();
	$("#second"+dataNo).hide();
	$("#third"+dataNo).hide();
	// 편집 버튼 숨기기
	$("#updateMaster"+dataNo).hide();
	// 입력 창 보이기
	$("#website"+dataNo).show();
	$("#websiteId"+dataNo).show();
	$("#websitePw"+dataNo).show();
	// 수정 버튼 보이기
	$("#updateGo"+dataNo).show();
})

function innerSelectUp(value){
	console.log(value);
	var c = $(".c");
	if(value == 'etc'){
		c.show();
	}
	if(value != 'etc'){
		c.hide();
	}
}

// 수정
$("Button[name='updateSubmit']").on("click", function(){
	var dataNo = $(this).attr('data-no');
	var email = $("#loginEmail").text();
	var website = $("span[name='website" + dataNo + "']").text();
	var websiteId = $("span[name='websiteId" + dataNo + "']").text();
	var websitePw = $("span[name='websitePw" + dataNo + "']").text();
	var reWebsite = $("#websiteTypeUp"+dataNo+" option:selected").text();
	var reWebsiteId = $("input[name='websiteId" + dataNo + "']").val();
	var reWebsitePw = $("input[name='websitePw" + dataNo + "']").val();
	
	 $.ajax({
			url: "masterUpdate",
			type: "POST", 
			data: {
				email : email,
				website : website,
				websiteId : websiteId,
				websitePw : websitePw,
				reWebsite : reWebsite,
				reWebsiteId : reWebsiteId,
				reWebsitePw : reWebsitePw
				
			}
			}).done(function (result){
				alert(result);
				window.location.reload();
			})
})

// 수정 취소
$("Button[name='updateCancel']").on("click", function(){
	var dataNo = $(this).attr('data-no');
	var website = $("span[name='website" + dataNo + "']").text();
	var websiteId = $("span[name='websiteId" + dataNo + "']").text();
	var websitePw = $("span[name='websitePw" + dataNo + "']").text();
// 	$("input[name='website" + dataNo + "']").val(website);
  	switch(website){
		case '11st' : $("#op11st"+dataNo).attr("selected", "selected"); break;
		case 'gmarket' : $("#opGmarket"+dataNo).attr("selected", "selected"); break;
		case 'auction' : $("#opAuction"+dataNo).attr("selected", "selected"); break;
		case 'interpark' : $("#opInterpark"+dataNo).attr("selected", "selected"); break;
		case 'etc' : $("#opEtc"+dataNo).attr("selected", "selected"); break;
//	case '11st' : $("#op11st"+dataNo).attr("selected", "selected"); break;
	}
	$("input[name='websiteId" + dataNo + "']").val(websiteId);
	$("input[name='websitePw" + dataNo + "']").val(websitePw);
	
	var a = $(".a");
	var b = $(".b");
	a.show();
	b.hide();
})
</script>


<%@include file="../include/footer.jsp" %>