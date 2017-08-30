<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/header.jsp"%>
<%@ page session="true" %>
	<div id="form_div">
		<h2> Login</h2>
		${param.error}
		<c:if test="${param.error != null }">
        	<h3>Username/Password not corrrect</h3>
        	<h3>Reason : ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message }</h3>
		</c:if>
		<c:if test="${param.logout != null }">
        	<h3>logout success</h3>
		</c:if>
		<c:url var="loginUrl" value="/login" />
		<form method="POST" action="${loginUrl}" id="loginForm">
			<div class="form-group">
				<label for="email">email:</label> 
				<input type="text" class="form-control" id="email" placeholder="Enter email " name="username">
			</div>
			<div class="form-group">
				<label for="password">Password:</label> 
				<input type="password" class="form-control" id="password" placeholder="Enter password" name="password">
			</div>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<button id="loginBtn" class="btn btn-default" style="float: right;">login</button>
		</form>
	</div>
	
	<script>
		$(document).ready(function(){
			$("#loginBtn").on("click",function(){
				console.log("aa : " + $("#email").val());
				console.log("aa : " + $("#password").val());
				if($("#email").val()== ""){
					alert("로그인 이메일을 입력해주세요");
					$("#email").focus();
				}else if($("#password").val()== ""){
					alert("패스워드를 입력해주세요");
					$("#password").focus();
				}else{
					$("#loginForm").submit();
				}
			});
		});
	</script>
<%@ include file="../include/footer.jsp"%>