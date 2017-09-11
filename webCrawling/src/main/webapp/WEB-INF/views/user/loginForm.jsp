<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ page session="true" %>
<style>
	input[type='text'], select, input[type='password'] {
		background-color: #F0FFF0;
	}
	input[type='text'] {
		border-bottom: 1px solid #DCDCDC;
	}
	a {
		color:#708090;
	}
</style>
<body>
<div class="main-container">
	<section>
		<div class="row">
			<div class="col-md-4 col-md-offset-4" >
				<div class="feature bordered text-center">
					<h2 class="uppercase">LOGIN</h2>
					<hr>
					<form method="POST" action="/login" id="loginForm" class="text-center">
						<input type="text" class="mb0" id="email" placeholder="이메일 " name="username">
						<input type="password" class="mb0" id="password" placeholder="비밀번호 " name="password" >
						<input type="hidden" id="token">
						<input type="submit" id="loginBtn" value="로그인"/>
					</form>
					<p class="mb0">
						<a href="${pageContext.request.contextPath}/user/joinForm" >아직 회원이 아니세요?</a>
					</p>
				</div>
				
			</div>
		</div>
		<button id="asdasd">asdasd</button>
		
		
	</section>
</div>
</body>
	<script>
		$(document).ready(function(){
			var error = "${param.error}";
			console.log(error);
			if (error == 1){
				alert("아이디와 패스워드를 확인해주세요.");
			}
			$("#loginBtn").on("click",function(){
				if($("#email").val()== ""){
					alert("로그인 이메일을 입력해주세요");
					$("#email").focus();
					return false;
				}else if($("#password").val()== ""){
					alert("패스워드를 입력해주세요");
					$("#password").focus();
					return false;
				}else{
					$("#loginForm").submit();
					
				}
			});
			
			function getToken(){
				$.ajax({
					url : "/user/getToken"
				}).done(function(result){
					var token = result.token;
					var parameterName = result.parameterName;
					var headerName = result.headerName;
					console.log(token);
					console.log(parameterName);
					$("#token").attr("name",parameterName);
					$("#token").attr("value",token);
				})
			};
		
			getToken();
			
			
		});
		
		
		
	</script>
<%@ include file="../include/footer.jsp"%>