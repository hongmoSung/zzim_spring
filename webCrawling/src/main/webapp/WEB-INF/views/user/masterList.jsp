<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../include/header.jsp" %>

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
			<thead>
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
						<td><input type="checkbox" id="checkRow" name="checkRow" value="${list.email},${list.website},${list.websiteId}" /></td>
						
						<td id="first${status.index}" class="a"><span name="website${status.index}">${list.website}</span></td>
						<td id="website${status.index}" style="display:none;" class="b">
							<select id="websiteTypeUp" onchange="innerSelectUp(this.value)" >
							  <option value="empty">선택</option>
							  <option value="11st">11st</option>
							  <option value="gmarket">gmarket</option>
							  <option value="auction">auction</option>
							  <option value="interpark">interpark</option>
				  		    </select>
				  		 	<input type="hidden" type="text" id="insertWebsiteUp" ></input></td>
<%-- 						<input type="text" value="${list.website}" name="website${status.index}"></td> --%>
						
						<td id="second${status.index}" class="a"><span name="websiteId${status.index}">${list.websiteId}</span></td>
						<td id="websiteId${status.index}" style="display:none;" class="b">
							<input type="text" value="${list.websiteId}" name="websiteId${status.index}"></td>
						
						<td id="third${status.index}" class="a"><span name="websitePassword${status.index}">${list.websitePassword}</span></td>
						<td id="websitePassword${status.index}" style="display:none;" class="b">
							<input type="text" value="${list.websitePassword}" name="websitePassword${status.index}"></td>

						<td colspan="2" id="updateMaster${status.index}" class="a">
							<button type="button" class="updateBtn" name="updateMaster${status.index}" data-no="${status.index}">편집</button></td>
						<td id="updateGo${status.index}" style="display:none;" class="b">
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
				  		 	 </select>
							<input type="text" id="insertWebsite" style="display:none;"></input></td>
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

// 전체 체크/해제
function checkAll() {
	var param = document.getElementById("th_checkAll").checked;
	var arrcheck = $("#checkRow");
	for (i = 0; i < arrcheck.length; i++) {
		arrcheck.item(i).checked = param;
	}
}

// 개별 체크시 전체 체크 해제
$("#checkRow").on("click", function(){
	var chk = $("#th_checkAll").checked;
	var arrcheck = $("#checkRow")
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
})

// 삭제
$("#deleteMaster").on("click", function() {
	var chk = $("#checkRow");
	var len = chk.length;    
	var checkRow = '';      
	var valueArray = new Array();            


	for(var i = 0; i < len; i++){
		if(chk[i].checked == true){ 
			checkRow = chk[i].value;
			valueArray.push(checkRow); 
			}
		}
	console.log(valueArray);
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

function innerSelect(value){
	if(value == 'etc'){
		$("#intertWebsite").css("display",""); 
	}
	if(value != 'etc'){
		$("#intertWebsite").css("display","none");
	}
}
// 등록
$("button[name='masterRegist']").on("click", function() {
	var email = $("#loginEmail").text();
	var websiteId = $("#masterId").val();
	var websitePassword = $("#masterPassword").val();
	
	var websiteType =  $("#websiteType option:selected").text();
	if(websiteType =='직접입력'){
		websiteType = $("#insertWebsite").val();
	}

	if(websiteType == '선택'){
		alert('사이트 입력할 것');
	}else if(websiteId == ''){
		alert('아이디 입력할 것');
		$("#masterId").focus();
	}else if(websitePassword == ''){
		alert('비밀번호 입력할 것');
		$("#masterPassword").focus();
	}else{
	$.ajax({
		url: "masterInsert",
		type: "POST", 
		data: {
			email : email,
			website : websiteType,
			websiteId : websiteId,
			websitePassword : websitePassword
		}
		}).done(function (result){
			alert(result);
			window.location.reload();
		})
	}
})

// 편집
$(".updateBtn").on("click", function(){
	var dataNo = $(this).attr('data-no');
  // 편집 폼 중복 방지
	var a = $(".a");
	var b = $(".b");
  	for(var i = 0; i < a.length; i++){
  		a[i].css("display","");
  		
  	}
  	for(var i = 0; i < b.length; i++){
  		b[i].css("display","none");
  	}
  
	// 컨텐트 숨기기
	$("#first"+dataNo).css("display","none");
	$("#second"+dataNo).css("display","none");
	$("#third"+dataNo).css("display","none");
	// 편집 버튼 숨기기
	$("#updateMaster"+dataNo).css("display","none");
	// 입력 창 보이기
	$("#website"+dataNo).css("display","");
	$("#websiteId"+dataNo).css("display","");
	$("#websitePassword"+dataNo).css("display","");
	// 수정 버튼 보이기
	$("#updateGo"+dataNo).css("display","");
})

function innerSelectUp(value){
	console.log(value);
	if(value == 'etc'){
		$("#insertWebsiteUp").show();
		$("#insertWebsiteUp").attr("type","");
	}
	if(value != 'etc'){
		$("insertWebsiteUp").css("display","none");
	}
}

// 수정
$("Button[name='updateSubmit']").on("click", function(){
	var dataNo = $(this).attr('data-no');
	var email = $("#loginEmail").text();
	var website = $("span[name='website" + dataNo + "']").text();
	var websiteId = $("span[name='websiteId" + dataNo + "']").text();
	var websitePassword = $("span[name='websitePassword" + dataNo + "']").text();
	var reWebsite = $("input[name='website" + dataNo + "']").val();
	var reWebsiteId = $("input[name='websiteId" + dataNo + "']").val();
	var reWebsitePassword = $("input[name='websitePassword" + dataNo + "']").val();
	 $.ajax({
			url: "masterUpdate",
			type: "POST", 
			data: {
				email : email,
				website : website,
				websiteId : websiteId,
				websitePassword : websitePassword,
				reWebsite : reWebsite,
				reWebsiteId : reWebsiteId,
				reWebsitePassword : reWebsitePassword
				
			}
			}).done(function (result){
				alert(result);
				window.location.reload();
			})
})

// 수정 취소
$("Button[name='updateCancel']").on("click", function(){
	var dataNo = $(this).attr('data-no');
// 	var email = $("#loginEmail").text();
	var website = $("span[name='website" + dataNo + "']").text();
	var websiteId = $("span[name='websiteId" + dataNo + "']").text();
	var websitePassword = $("span[name='websitePassword" + dataNo + "']").text();
	
	$("input[name='website" + dataNo + "']").val(website);
	$("input[name='websiteId" + dataNo + "']").val(websiteId);
	$("input[name='websitePassword" + dataNo + "']").val(websitePassword);
	
	var a = $(".a");
	var b = $(".b");
  	for(var i = 0; i < a.length; i++){
  		a[i].style.display = "";
  	}
  	for(var i = 0; i < b.length; i++){
  		b[i].style.display = "none";
  	}
})
</script>


<%@include file="../include/footer.jsp" %>