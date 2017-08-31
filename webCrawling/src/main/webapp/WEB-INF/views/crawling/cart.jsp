
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../include/header.jsp"%>
<section>
	<h1>
		장바구니 크롤링 <br> ajax로 node서버에 요청
	</h1>
	<div id="gmarket">
		<h3>gmarket</h3>
	</div>
	<div id="11st">
		<h3>11st</h3>
	</div>
	<div id="auction">
		<h3>auction</h3>
	</div>
	<div id="interpark">
		<h3>interpark</h3>
	</div>
</section>
<script id="cart-template" type="text/x-handlebars-template">
		<table class="table" style="text-align:left">
			<tr>
				<td colspan="2">상품</td>
				<td>수량</td>
				<td>가격</td>
				<td>배송정보</td>
			<tr>
			{{#each .}}
			<tr>
				<td><img src="{{cPic}}" width="80" height="80"></td>
				<td><a href="{{cLink}}">{{#makeName cName}}{{/makeName}}</a></td>
				<td>{{#makeCount cCount}}{{/makeCount}}</td>
				<td>{{cPrice}}원</td>
				<td>{{#makeDelivery cDelivery}}{{/makeDelivery}}</td>
			<tr>
			{{/each }}
		</table>
</script>

<script>
	$(document).ready(function() {

		Handlebars.registerHelper("makeDelivery", function(cDelivery) {
			if (cDelivery != null) {
				var lastCh = cDelivery.charAt(cDelivery.length - 1);
				var regNumber = /^[0-9]*$/;

				if (regNumber.test(lastCh)) {
					return cDelivery + "원";
				} else {
					return cDelivery;
				}

			} else {
				return "";
			}
		});
		Handlebars.registerHelper("makeName", function(cName) {
			cName = cName.replace(/(^\s*)|(\s*$)/g, "");
			return cName;
		});
		Handlebars.registerHelper("makeCount", function(cCount) {
			if (cCount != null) {
				cCount += cCount+"";
				var firstCh = cCount.charAt(0);
				var regNumber = /^[0-9]*$/;
				if (regNumber.test(firstCh)) {
					return cCount + "개";
				} else {
					return cCount;
				}
			} else {
				return "";
			}
		});

		var email = '${user.email}';

		$.ajax({
			url : "http://192.168.0.36:3003/cart",
			type : "post",
			data : {
				"email" : email
			}
		}).done(function(result) {
			for (var i = 0; i < result.length; i++) {
				var resultObj = result[i];
				console.log(resultObj);
				var source = $("#cart-template").html();
				var template = Handlebars.compile(source);

				if (resultObj['11st'] != null) {

					var elevenObj = resultObj['11st'];
					var html = template(elevenObj);
					$("#11st").append(html);

				}
				if (resultObj['gmarket'] != null) {

					var gmarketObj = resultObj['gmarket'];
					var html = template(gmarketObj);
					$("#gmarket").append(html);
				}
				if (resultObj['auction'] != null) {

					var auctionObj = resultObj['auction'];
					var html = template(auctionObj);
					$("#auction").append(html);
				}
				if (resultObj['interpark'] != null) {

					var interparkObj = resultObj['interpark'];
					var html = template(interparkObj);
					$("#interpark").append(html);
				}

			}
		});

	});
</script>
<%@include file="../include/footer.jsp"%>

