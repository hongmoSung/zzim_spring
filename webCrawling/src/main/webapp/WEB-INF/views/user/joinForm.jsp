<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

<%@ include file="../include/header.jsp"%>
<form id="join">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<div style="display: inline;">
		<label for="email">아이디</label> 
		<input type="text" id="email" placeholder="이메일" name="email"> <span>@</span> 
		<select id="emailType" onchange="innerSelect(this.value);">
			<option value="empty">선택</option>
			<option value="naver">naver.com</option>
			<option value="daum">daum.net</option>
			<option value="etc">직접입력</option>
		</select> 
		<input type="text" id="insertEmail" style="display: none;"></input>
		<button type="button" id="idCheckBtn">중복 확인</button>
	</div>
	<br> 
	<label for="password">비밀번호</label> 
	<input type="password" id="password" placeholder="비밀번호" name="password"><br> 
	<label for="password2">비밀번호 확인</label> 
	<input type="password" id="password2" placeholder="비밀번호 확인"><br>

	<button id="joinBtn" type="button">회원가입</button>
</form>

<script>
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	 
	$(function() {
	    $(document).ajaxSend(function(e, xhr, options) {
	        xhr.setRequestHeader(header, token);
	    });
	});

	function innerSelect(value) {
		if (value == 'etc') {
			document.getElementById("insertEmail").style.display = "block";
			document.getElementById("insertEmail").style.display = "inline";
		}
		if (value != 'etc') {
			document.getElementById("insertEmail").style.display = "none";
		}

	}

	var emailCheckSig = 0;
	$("#idCheckBtn").on("click", function() {
		var emailType = $("#emailType option:selected").text();
		if (emailType == '직접입력') {
			emailType = $("#insertEmail").val();
		}
		var email = $("#email").val() + "@" + emailType;

		if ($("#email").val() == "") {
			alert("이메일을 입력해주세요");
			$("#email").focus();
			return false;
		}
		$.ajax({
			url : getContextPath()+"/user/emailCheck",
			data : {
				"email" : email
			}
		}).done(function(result) {
			console.log(result);
			if (result == "true") {
				alert("사용 가능한 이메일");
				emailCheckSig = 1;
			} else {
				alert("이미 사용중인 이메일");
				$("#email").focus();
			}
		});
	});
	$("#joinBtn").on("click", function() {
		var emailType = $("#emailType option:selected").text();

		if (emailType == '직접입력') {
			emailType = $("#insertEmail").val();
		}
		var email = $("#email").val() + "@" + emailType;

		var password = $("#password").val();

		if (emailCheckSig == 0) {
			alert("이메일 중복확인을 해주세요");
			return false;
		}
		if ($("#email").val() == "") {
			alert("이메일을 입력해주세요");
			$("#email").focus();
			return false;
		}
		if ($("#emailType").val() == "empty") {
			alert("이메일 주소를 선택해주세요");
			return false;
		}
		if ($("#password").val() == "") {
			alert("password를 입력해주세요");
			$("#password").focus();
			return false;
		}
		if ($("#password2").val() == "") {
			alert("password를 입력해주세요");
			$("#password2").focus();
			return false;
		}
		if ($("#password").val() != $("#password2").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#password2").val("");
			$("#password").focus().val("");
			return false;
		}
		console.log(email);
		console.log(password);
		$.ajax({
			url : getContextPath() + "/user/join",
			type : "POST",
			data : {
				"email" : email,
				"password" : password
			}
		}).done(function(result) {
			alert("회원가입 성공");
			location.href =  getContextPath() + "/user/loginForm";
		});
	});
</script>
<%@ include file="../include/footer.jsp"%>