<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<style>
	input[type='text'], select, input[type='password'] {
		background-color: #F0FFF0;
		border-style: 1px black;
	}
	i.ti-angle-down{
		margin-top: -10px;
	}
</style>
<section>
<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="feature bordered text-center">
				<h2 class="uppercase">JOIN</h2>
				<hr>
				<input type="hidden" id="_csrf" value="${_csrf.token}">
				<input type="hidden" id="_csrf_header" value="${_csrf.headerName}">
				<input type="text" id="email" placeholder="이메일" name="email" style="width:40%;"> @  
				<span class="select-option">
					<i class="ti-angle-down"></i>
					<select id="emailType" onchange="innerSelect(this.value);" style="width:50%;" >
						<option value="empty">선택</option>
						<option value="naver">naver.com</option>
						<option value="daum">daum.net</option>
						<option value="gmail">gmail.com</option>
						<option value="etc">직접입력</option>
					</select> 
				</span>
				<input type="text" id="insertEmail" style="display:none; width:90%;"></input>
				<br>
				<a id="idCheckBtn" class="btn btn-sm" >중복 확인</a>
				<input type="password" id="password" placeholder="비밀번호" name="password" style="width:90%;"><br> 
				<input type="password" id="password2" placeholder="비밀번호 확인" style="width:90%;"><br>
				<input id="joinBtn" type="submit" value="회원가입">
			</div>
		</div>
	</div>
</div>
<div style="height:150px;"></div>
</section>

<script>
	var token = $("#_csrf").attr('value');
	var header = $("#_csrf_header").attr("value");
	$(function() {
	    $(document).ajaxSend(function(e, xhr, options) {
	        xhr.setRequestHeader(header, token);
	    });
	});

	function innerSelect(value) {
		if (value == 'etc') {
			$("#insertEmail").show();
		}
		if (value != 'etc') {
			$("#insertEmail").hide();
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
			url : getContextPath()+"/emailCheck",
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
	
	// 가입 버튼
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
		$.ajax({
			url : getContextPath() + "/join",
			type : "POST",
			data : {
				"email" : email,
				"password" : password
			}
		}).done(function(result) {
			alert("회원가입 성공");
			location.href =  getContextPath() + "/loginForm";
		});
	});
</script>

<%@ include file="../include/footer.jsp"%>