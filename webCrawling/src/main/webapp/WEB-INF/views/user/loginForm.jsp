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
			<div class="col-md-6 col-md-offset-4 col-sm-8 col-sm-offset-4" style="position:relative; left: 80px;">
				<div class="feature bordered text-center" style="width:50%;">
					<h2 class="uppercase">LOGIN</h2>
					<hr>
					<c:if test="${param.error != null }">
			        	<h3>Username/Password not corrrect</h3>
			        	<h3>Reason : ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message }</h3>
					</c:if>
					<c:url var="loginUrl" value="/login" />
					<form method="POST" action="${loginUrl}" id="loginForm" class="text-left">
						<input type="text" class="mb0"" id="email" placeholder="이메일 " name="username">
						<input type="password" class="mb0" id="password" placeholder="비밀번호 " name="password" >
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
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
		$(document).ready(function(){
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
		});
	</script>
<%@ include file="../include/footer.jsp"%>