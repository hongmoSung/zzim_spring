<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ page session="true" %>
<style>
	input[type='text'], input[type='password'] {
		background-color: #F0FFF0;
		width:90%;
	}
	input[type='submit'] {
		width:90%;
	}
	a {
		color:#708090;
	}
</style>
<body>
<div class="main-container">
	<section>
		<div class="row">
			<div style="width:20%; margin:auto;">
				<div class="feature bordered text-center">
					<h2 class="uppercase">LOGIN</h2>
					<hr>
					<form method="POST" action="/login" id="loginForm" class="text-center">
						<input type="text" class="mb5" id="email" placeholder="이메일 " name="username" autocomplete="off">
						<input type="password" class="mb5" id="password" placeholder="비밀번호 " name="password"  >
						<input type="hidden" id="token">
						<input type="hidden" id="_csrf_token" name="_csrf" value="${_csrf.token}">
						<input type="hidden" id="_csrf_token_header" name="_csrf_header" value="${_csrf.headerName}">
						<input type="submit" id="loginBtn" value="로그인"/>
					</form>
					<p class="mb0">
						<a href="${pageContext.request.contextPath}/user/joinForm" >아직 회원이 아니세요?</a>
					</p>
				</div>
				
			</div>
		</div>
	</section>
</div>
</body>
	<script>

	
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader($("#_csrf_token_header").val(), $("#_csrf_token").val());
		});
		
		
		$(document).ready(function() {
			var error = "${param.error}";
			console.log(error);
			if (error == 1) {
				alert("아이디와 패스워드를 확인해주세요.");
			}
			$("#loginBtn").on("click", function() {
				if ($("#email").val() == "") {
					alert("로그인 이메일을 입력해주세요");
					$("#email").focus();
					return false;
				} else if ($("#password").val() == "") {
					alert("패스워드를 입력해주세요");
					$("#password").focus();
					return false;
				} else {
					$("#loginForm").submit();
				}
			});

			$("#a").on("click", function() {
				$.ajax({
					url : "/login",
					type : "post",
					data : {
						"username" : $("#email").val(),
						"password" : $("#password").val(),
						"mobile" : "true"
					}

				}).done(function(result) {
					console.log(result);
				});
			});

		});
	</script>
<%@ include file="../include/footer.jsp"%>