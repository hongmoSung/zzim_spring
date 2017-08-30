<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="include/header.jsp" %>
<section>
	<h1>
		Hello world!  
	</h1>
	<form action="http://192.168.0.36:3003/url" method="post">
		<h3>url :::::</h3>
		<input type="text" name="url" size="200">
		<button>submit</button>
	</form>
	
	<form id="srchFRM_TOP" name="srchFRM_TOP" style="margin:0px;" method="get" action="http://search.danawa.com/dsearch.php">
		<input type="text" name="k1" id="AKCSearch" autocomplete="off" title="검색어 입력">
		<input id="module" name="module" value="goods" type="hidden">
		<input id="act" name="act" value="dispMain" type="hidden">
		<button class="btn_search_submit"><span>검색</span></button>
	</form>
	
	<article>
		
	</article>	
</section>


<%@include file="include/footer.jsp" %>

