<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="true" %>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Web Crawling</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/web/resources/handlebars-v4.0.10.js"></script>
	<link rel="stylesheet" href="/web/resources/sb.css">
	<script src="/web/resources/sb.js"></script>
	
	<!--   c3 , d3 차트 -->
	 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>
	 <script src="https://d3js.org/d3.v3.min.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
	
	
	
</head>
<body>
<div class="row">
	<nav class="navbar navbar-inverse">
	  <div class="container-fluid">
	    <div class="navbar-header">
	      <a class="navbar-brand" href="#">Web Crawling Project</a>
	    </div>
	    <ul class="nav navbar-nav">
	      <li><a href="${pageContext.request.contextPath}">Home</a></li>
	      <li><a href="${pageContext.request.contextPath}/crawling/cart">Cart</a></li>
	      <li><a href="${pageContext.request.contextPath}/trackingBoard/list">Board</a></li>
	      <li><a href="${pageContext.request.contextPath}/board/list">Q&A</a></li>
	    </ul>
	    <ul class="nav navbar-nav navbar-right">
<%-- 	    <c:choose> --%>
<%-- 	    	<c:when test="${user != null}"> --%>
<!-- 		      <li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li> -->
<%-- 	    	</c:when> --%>
<%-- 	    	<c:otherwise> --%>
<%-- 		      <li><a href="${pageContext.request.contextPath}/user/join"><span class="glyphicon glyphicon-user"></span> Join</a></li> --%>
<%-- 		      <li><a href="${pageContext.request.contextPath}/user/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li> --%>
<%-- 	    	</c:otherwise> --%>
<%-- 	    </c:choose> --%>
		<sec:authorize access="hasRole('ROLE_USER')"> 
		  <sec:authentication property="name"/>
	      <li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
	      <li><a href="${pageContext.request.contextPath}/user/masterList?email=${user.email}">account : ${user.email}</a></li>
		</sec:authorize>	   
		<sec:authorize access="!hasRole('ROLE_USER')">
	      <li><a href="${pageContext.request.contextPath}/user/joinForm"><span class="glyphicon glyphicon-user"></span> Join</a></li>
	      <li><a href="${pageContext.request.contextPath}/user/loginForm"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
		</sec:authorize>    
	    </ul>
	  </div>
	</nav>
</div>
<form action="${pageContext.request.contextPath }/logout" method="post" id="logoutForm">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>

<script>
	function logout(){
		$("#logoutForm").submit();
	}
	

</script>