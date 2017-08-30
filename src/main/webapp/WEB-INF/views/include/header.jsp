<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="true" %>





<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Web Crawling</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="/web/resources/handlebars-v4.0.10.js"></script>
    <script src="/web/resources/template/Documentation/Foundry Docs/js/bootstrap.min.js"></script>
    <script src="/web/resources/template/Documentation/Foundry Docs/js/parallax.js"></script>
    <script src="/web/resources/template/Documentation/Foundry Docs/js/scripts.js"></script>
	
	<link rel="stylesheet" href="/web/resources/sb.css">
	<script src="/web/resources/sb.js"></script>
	
	<link href="/web/resources/template/Documentation/Foundry Docs/css/themify-icons.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/template/Documentation/Foundry Docs/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/template/Documentation/Foundry Docs/css/theme.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/template/Documentation/Foundry Docs/css/custom.css" rel="stylesheet" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400%7CRaleway:100,400,300,500,600,700%7COpen+Sans:400,500,600' rel='stylesheet' type='text/css'>
	
</head>
<body>
<div class="nav-container">
		        <div class="nav-bar">
		            <div class="module left">
		                <a href="${pageContext.request.contextPath}">
		                    <img class="logo logo-dark" alt="//도메인 이름//" src="/web/resources/template/Foundry 1.9.9.1/img/logo-dark.png">
		                </a>
		            </div>
		            <div class="module widget-handle mobile-toggle right visible-sm visible-xs">
		                <i class="ti-menu"></i>
		            </div>
		            <div class="module-group right">
		                <div class="module left">
		                    <ul class="menu">
		                        <li>
		                            <a href="${pageContext.request.contextPath}/crawling/cart">장바구니</a>
		                        </li>
		                        <li>
		                            <a href="#">트래킹 리스트</a>
                                </li>
		                        <li>
		                            <a href="${pageContext.request.contextPath}/board/list">Q & A</a>
                                </li>
                            </ul>
		                </div>
		                
		                <div class="module widget-handle left">
		                    <ul class="menu">
		                        <li class="has-dropdown">
		                            <sec:authorize access="hasRole('ROLE_USER')"> 
								    	<sec:authentication property="name"/>
					                    <ul>
					                        <li><a href="${pageContext.request.contextPath}/user/masterList?email=${user.email}">로그인계정 관리</a></li>
					                        <li><a href="javascript:logout()">로그아웃</a></li>
					                    </ul>
									</sec:authorize>	
									<sec:authorize access="!hasRole('ROLE_USER')">
										<a href="${pageContext.request.contextPath}/user/loginForm">로그인</a>
										<ul>
								     		<li><a href="${pageContext.request.contextPath}/user/joinForm">회원가입</a></li>
								    	</ul>
									</sec:authorize>  
		                        </li>
		                    </ul>
		                </div>
		            </div>
		        </div>
		</div>
		<div class="main-container">
		</div>
		<form action="${pageContext.request.contextPath }/logout" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		</form>
		
<script>
	function logout(){
		$("#logoutForm").submit();
	}
</script>