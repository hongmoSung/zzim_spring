<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ page session="true" %>
<body>
	<div class="main-container">
		<section>
			<div class="container">
				<div class="row">
					<div class="col-md-4 col-md-offset-4 col-sm-8 col-sm-offset-2">
						<div class="feature bordered text-center">
							<h2 class="uppercase">LOGIN</h2>
							<c:if test="${param.error != null }">
					        	<h3>Username/Password not corrrect</h3>
					        	<h3>Reason : ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message }</h3>
							</c:if>
							<c:url var="loginUrl" value="/login" />
							<form method="POST" action="${loginUrl}" id="loginForm" class="text-left">
								<input type="text" class="mb0"" id="email" placeholder="이메일 " name="username">
								<input type="password" class="mb0" id="password" placeholder="비밀번호 " name="password">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
								<input type="submit" id="loginBtn" value="로그인"/>
							</form>
							<p class="mb0">
								<a href="${pageContext.request.contextPath}/user/joinForm">아직 회원이 아니세요?</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</body>
	<script>
		$(document).ready(function(){
			$("#loginBtn").on("click",function(){
				console.log("aa : " + $("#email").val());
				console.log("aa : " + $("#password").val());
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