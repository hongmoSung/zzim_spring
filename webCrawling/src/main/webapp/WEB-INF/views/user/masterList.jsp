<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../include/header.jsp" %>
<div class="main-container">
	<section class="page-title page-title-4 bg-secondary">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-4">
					<h3 class="uppercase mb0">로그인 계정 관리</h3>
				</div>
			</div>
		</div>
	</section>
	<section>
	<!-- 리스트 -->
	<div class="container">
	<div class="row">
		<div>
			<c:if test="${not empty masterList}">
				<a type="button" name="deleteMaster" id="deleteMaster" class="btn btn-sm">선택항목 삭제</a>
			</c:if>
		</div>
		<div class="col-md-10 col-md-offset-1">
			<div class="post-snippet mb64">
				<c:if test="${empty masterList}">
						<span>&#187  관리중인 계정이 없습니다.</span>
				</c:if>
				<div>
					<ul class="post-meta">
						<li><h6>전체<input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();" /></h6></li>
						<li><h6>관리 사이트</h6></li>
						<li><h6>로그인 아이디</h6></li>
					</ul>
				</div>
				<c:forEach items="${masterList}" var="list" varStatus="status">
					<div>
						<ul class="post-meta" style="width:280px;">
							<li><input type="checkbox" id="checkRow" name="checkRow" value="${list.email},${list.website},${list.websiteId}" onclick="check();" /></li>
							
							<li id="first${status.index}" class="a">
								<span name="website${status.index}">${list.website}</span>
							</li>
							<li id="website${status.index}" class="b">
								<select id="websiteTypeUp${status.index}" onchange="innerSelectUp(this.value)" style="width:100px;" >
									  <option value="empty${status.index}">선택</option>
									  <option value="11st" id="op11st${status.index}">11st</option>
									  <option value="gmarket" id="opGmarket${status.index}">gmarket</option>
									  <option value="auction" id="opAuction${status.index}">auction</option>
									  <option value="interpark" id="opInterpark${status.index}">interpark</option>
									  <option value="etc" id="opEtc${status.index}">직접 입력</option>
					  		    </select>
					  		    <input type="text" value="${list.website}" name="website${status.index}" class="c" style="width:100px;"></input>
				  		    </li>
			  		    </ul>
			  		    <ul class="post-meta" style="width:150px;">
			  		    	<li id="second${status.index}" class="a">
			  		    		<span name="websiteId${status.index}">${list.websiteId}</span>
		  		    		</li>
							<li id="websiteId${status.index}" class="b">
								<input type="text" value="${list.websiteId}" name="websiteId${status.index}">
							</li>
						</ul>
						<ul class="post-meta" style="float:right;">	
							<li id="updateMaster${status.index}" class="a">
								<a type="button" class="updateBtn btn btn-sm" name="updateMaster${status.index}" data-no="${status.index}">편집</a></li>
							<li id="updateGo${status.index}" class="b">
								<a type="button" name="updateSubmit" data-no="${status.index}" class="btn btn-sm">수정</a>
								<a type="button" name="updateCancel" data-no="${status.index}" class="btn btn-sm">취소</a>
							</li>
						</ul>
					</div>
				<hr>
				</c:forEach>
				<div class="input-with-label">
					<a type="button" name="masterRegist" class="btn btn-sm">&#43</a><br>
					<span><h5>사이트</h5></span>
					<select id="websiteType" onchange="innerSelect(this.value)" style="width:20%;">
						<option value="empty">선택</option>
						<option value="11st">11st</option>
						<option value="gmarket">gmarket</option>
						<option value="auction">auction</option>
						<option value="interpark">interpark</option>
						<option value="etc">직접 입력</option>
	  		 	 	</select>
	  		 	 	
	  		 	 	<input type="text" id="insertWebsite" style="width:20%;">
	  		 	 	
	  		 	 	<span><h5>아이디</h5></span>
					<input type="text" name="masterId" id="masterId" style="width:20%;">
					
					<span><h5>비밀번호</h5></span>
					<input type="password" name="masterPassword" id="masterPassword" style="width:20%;">
			</div>
		</div>
	</div>
	</div>
</section>
</div>

<script>
	// 토큰
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
	$("a[name='masterRegist']").on("click", function() {
		var email = "${user.email}";
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
			console.log("등록 website : " + websiteType);
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
		
		if(website == 'etc'){
			c.show();
		}else{
			c.hide();
		}
	  	console.log("편집 website : " + website);
	  	switch(website){
	  		case '11st' : $("#op11st"+dataNo).attr("selected", "selected"); break;
	  		case 'gmarket' : $("#opGmarket"+dataNo).attr("selected", "selected"); break;
	  		case 'auction' : $("#opAuction"+dataNo).attr("selected", "selected"); break;
	  		case 'interpark' : $("#opInterpark"+dataNo).attr("selected", "selected"); console.log("interpark편집"); break;
	  		default : $("#opEtc"+dataNo).attr("selected", "selected"); c.show(); break;
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
		console.log("편집 value : " + value);
		var c = $(".c");
		if(value == 'etc'){
			c.show();
		}
		if(value != 'etc'){
			c.hide();
		}
	}
	
	// 수정
	$("a[name='updateSubmit']").on("click", function(){
		var dataNo = $(this).attr('data-no');
		var email = "${user.email}";
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
	$("a[name='updateCancel']").on("click", function(){
// 		window.location.reload();
		var dataNo = $(this).attr('data-no');
		var website = $("span[name='website" + dataNo + "']").text();
		var websiteId = $("span[name='websiteId" + dataNo + "']").text();
		var websitePw = $("span[name='websitePw" + dataNo + "']").text();
		var a = $(".a");
		var b = $(".b");
		var c = $(".c");
		
		console.log("수정취소 dataNO : " + dataNo);
		console.log("수정 취소 website: " + website);
		console.log("id : " + websiteId);
		console.log("pw : " + websitePw);
	
	// 	$("input[name='website" + dataNo + "']").val(website);
		$("input[name='websiteId" + dataNo + "']").val(websiteId);
		$("input[name='websitePw" + dataNo + "']").val(websitePw);
		if(website == "11st"){
			$("#op11st"+dataNo).attr("selected", "selected");
		}
		console.log("선택된 옵션" + $("#websiteTypeUp"+dataNo+" option:selected").text());
	  switch(website){
			case '11st' : $("#op11st"+dataNo).removeAttr("selected"); console.log(1); break;
			case 'gmarket' : $("#opGmarket"+dataNo).removeAttr("selected"); console.log(2); break;
			case 'auction' : $("#opAuction"+dataNo).removeAttr("selected"); console.log(3); break;
			case 'interpark' : $("#opInterpark"+dataNo).removeAttr("selected"); console.log(4); break;
			default : $("#opEtc"+dataNo).removeAttr("selected"); console.log(5); break;
			case '11st' : $("#op11st"+dataNo).removeAttr("selected"); break;
		}
		
		a.show();
		b.hide();
// 		c.hide();
	})
</script>


<%@include file="../include/footer.jsp" %>