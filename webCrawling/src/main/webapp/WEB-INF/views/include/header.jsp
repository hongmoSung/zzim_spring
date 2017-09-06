<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="true" %>



<!-- <html lang="ko"> -->
    
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/resources/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="all">
    <link href="/resources/css/themify-icons.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resources/css/flexslider.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resources/css/theme-red.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resources/css/custom.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resources/css/lightbox.min.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resources/css/ytplayer.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/resources/css/theme.css" rel="stylesheet" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400%7CRaleway:100,400,300,500,600,700%7COpen+Sans:400,500,600' rel='stylesheet' type='text/css'>

	<script src="/resources/js/jquery.min.js"></script>
    <script src="/resources/js/bootstrap.min.js"></script>
    <script src="/resources/js/flexslider.min.js"></script>
    <script src="/resources/js/parallax.js"></script>
    <script src="/resources/js/scripts.js"></script>

	<script src="/resources/js/lightbox.min.js"></script>
    <script src="/resources/js/masonry.min.js"></script>
    <script src="/resources/js/ytplayer.min.js"></script>
    <script src="/resources/js/countdown.min.js"></script>
    <script src="/resources/js/smooth-scroll.min.js"></script>
    
    <script src="/resources/handlebars-v4.0.10.js"></script>
	<script src="/resources/sb.js"></script>
	
	<script src="/resources/waitMe.js"></script>
	<link href="/resources/waitMe.css" rel="stylesheet" type="text/css" />
	
    <script>
		function logout(){
			$("#logoutForm").submit();
		}
	</script>
	    <style>
        body, html {
          height: 100%;
        }
        
        footer {
        }
        
        div.main-container{
            min-height: 100%;
        }
    </style>
    
    
    <!-- FCM설정 -->
	<script src="https://www.gstatic.com/firebasejs/4.3.0/firebase.js"></script>
	<script>
	   
	  // Initialize Firebase
	  var config = {
	    apiKey: "AIzaSyC9xgu1p5RvwAehO_wmdL6VF5uXzFoB_8c",
	    authDomain: "zzim-521a0.firebaseapp.com",
	    databaseURL: "https://zzim-521a0.firebaseio.com",
	    projectId: "zzim-521a0",
	    storageBucket: "zzim-521a0.appspot.com",
	    messagingSenderId: "948220968110"
	  };
	  firebase.initializeApp(config);
	  
	    
	    const messaging = firebase.messaging();
	    
	    
	    messaging.onMessage(function(payload){
	        // alert('알림 도착! payload는 콘솔 확인');
	        console.log('onMessage:', payload);
	        alert(payload.notification.body);
	    });
	    
	</script>
    
</head>


<div class="nav-container">
    <nav>
        <div class="nav-bar">
            <div class="module left">
                <a href="${pageContext.request.contextPath}/">
                    <img class="logo logo-light" alt="Foundry" src="/resources/img/logo-light.png">
                    <img class="logo logo-dark" alt="Foundry" src="/resources/img/logo-dark.png">
                </a>
            </div>
            <div class="module widget-handle mobile-toggle right visible-sm visible-xs">
                <i class="ti-menu"></i>
            </div>
            <div class="module-group right">

                <div class="module left">
                    <ul class="menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/trackingBoard/trackingList">트레킹 리스트</a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/crawling/cart">메타 장바구니</a>
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