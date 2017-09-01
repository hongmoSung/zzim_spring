<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="true" %>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="_csrf" content="${_csrf.token}"/>
		<meta name="_csrf_header" content="${_csrf.headerName}"/>
		<meta name="format-detection" content="telephone=no" />
	    <meta name="msapplication-tap-highlight" content="no" />
	    <!-- <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width" /> -->
		
        <link href="/web/resources/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="all">
        <link href="/web/resources/css/themify-icons.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/web/resources/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/web/resources/css/flexslider.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/web/resources/css/theme-red.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/web/resources/css/custom.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/web/resources/css/lightbox.min.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/web/resources/css/ytplayer.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/web/resources/css/theme.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Lato:300,400%7CRaleway:100,400,300,500,600,700%7COpen+Sans:400,500,600' rel='stylesheet' type='text/css'>
           
        <!-- <script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
		<script src="https://www.amcharts.com/lib/3/serial.js"></script>
		<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
		<script src="https://www.amcharts.com/lib/3/themes/none.js"></script>
		<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" /> -->
		
        <script src="/web/resources/js/jquery.min.js"></script>
        <script src="/web/resources/js/bootstrap.min.js"></script>
        <script src="/web/resources/js/flexslider.min.js"></script>
        <script src="/web/resources/js/parallax.js"></script>
        <script src="/web/resources/js/scripts.js"></script>
        <script src="/web/resources/js/lightbox.min.js"></script>
        <script src="/web/resources/js/masonry.min.js"></script>
        <script src="/web/resources/js/ytplayer.min.js"></script>
        <script src="/web/resources/js/countdown.min.js"></script>
        <script src="/web/resources/js/smooth-scroll.min.js"></script>
           
       	<script src="/web/resources/handlebars-v4.0.10.js"></script>
		<script src="/web/resources/sb.js"></script>
		<script>
		function logout(){
			$("#logoutForm").submit();
		}
		</script>
	</head>
	<body>
        <div class="nav-container">
            <nav>
                <div class="nav-bar">
                    <div class="module left">
                        <a href="${pageContext.request.contextPath}/">
                            <img class="logo logo-light" alt="Foundry" src="/web/resources/img/logo-light.png">
                            <img class="logo logo-dark" alt="Foundry" src="/web/resources/img/logo-dark.png">
                        </a>
                    </div>
                    <div class="module widget-handle mobile-toggle right visible-sm visible-xs">
                        <i class="ti-menu"></i>
                    </div>
                    <div class="module-group right">

                        <div class="module left">
                            <ul class="menu">
                                <li>
                                    <a href="${pageContext.request.contextPath}/trackingBoard/trackingList">Tracking Board</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/crawling/cart">Cart</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/board/list">Q & A</a>
                                </li>

                            </ul>

                        </div>

                        <div class="module widget-handle left">
                            <ul class="menu">
                            <sec:authorize access="hasRole('ROLE_USER')"> 
							<%-- <sec:authentication property="name"/> --%>
						    <li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
						    <li><a href="${pageContext.request.contextPath}/user/masterList?email=${user.email}"><span class="glyphicon glyphicon-user"></span>Account</a></li>
							</sec:authorize>	   
							<sec:authorize access="!hasRole('ROLE_USER')">
						    <li><a href="${pageContext.request.contextPath}/user/joinForm"><span class="glyphicon glyphicon-user"></span> Join</a></li>
						    <li><a href="${pageContext.request.contextPath}/user/loginForm"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
							</sec:authorize>
                            </ul>
                        </div>
                        <form action="${pageContext.request.contextPath }/logout" method="post" id="logoutForm">
							<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
						</form>
                    </div>

                </div>
            </nav>
        </div>
    
