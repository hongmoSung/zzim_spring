
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<body class="scroll-assist">

	<div class="main-container">
		<section class="image-bg cover overlay page-title page-title-4"  style="height:250px;">
			<div class="background-image-holder">
	<!-- 			<img alt="image" class="background-image" src="/resources/img/trkList_back.jpg" style="height:250px;"> -->
				<img alt="image" class="background-image" src="/resources/img/trkList_test.png" style="height:250px;">
			</div>
			<div class="container">	
				<div class="row">
					<div class="col-md-6 col-md-offset-1">
						<h2 class="uppercase mb0" style="font-weight:bolder;">Meta Cart</h2>
					</div>
					<div class="col-md-4 text-right">
						<ol class="breadcrumb breadcrumb-2">
							<li><a href="${pageContext.request.contextPath}/">Home</a></li>
							<li class="active">Meta Cart</li>
						</ol>
					</div>
				</div>
			</div>
		</section>
		<section id="cartSection" style="margin-bottom: 50px;">
		</section>
	</div>
</body>


<script id="cart-template" type="text/x-handlebars-template">
<div class="container feature boxed bordered"
	style="box-shadow: 5px 5px 10px -1px lightgrey">
	<div class="feature text-center">
		<a href="{{mall}}"><img class="product-thumb" src="/resources/img/logo/{{shop}}.png" /></a>
	</div>
	<div class="row ">
		<div class="col-md-12 col-md-offset-0 col-sm-12 col-sm-offset-0">
			<table class="table cart mb48">
				<thead>
					<tr>
						<th width="10%">상품</th>
						<th width="60%">&nbsp;</th>
						<th>수량</th>
						<th>가격</th>
						<th>배송정보</th>
					</tr>
				</thead>
				<tbody>
				{{# each .}}
					<tr>
						<td width="10%"><a href="{{cLink}}"> <img alt="Product" class="product-thumb" src="{{cPic}}" width="80" height="80"/></a></td>
						<td width="60%"><a href="{{cLink}}"> <span>{{#makeName cName}}{{/makeName}}</span> </a></td>
						<td><span>{{#makeCount cCount}}{{/makeCount}}</span></td>
						<td><span>{{#makePrice cPrice}}{{/makePrice}}</span></td>
						<td><span>{{#makeDelivery cDelivery}}{{/makeDelivery}}</span></td>
					</tr>
				{{/ each}}
				</tbody>
			</table>
		</div>
		<!--end of items-->

	</div>
	<!--end of row-->
</div>
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
					return "무료배송";
				}

			} else {
				return "";
			}
		});
		Handlebars.registerHelper("makeName", function(cName) {
			if(cName != null){
				cName += "";
				cName = cName.replace(/(^\s*)|(\s*$)/g, "");
								
			}
			return cName;
		});
		
		Handlebars.registerHelper("makePrice", function(cPrice) {
			if(cPrice != null){
				cPrice += "";
				cPrice = cPrice.replace(/(^\s*)|(\s*$)/g, "");
				var lastCh = cPrice.charAt(cPrice.length - 1);
				var regNumber = /^[0-9]*$/;

				if (regNumber.test(lastCh)) {
					return cPrice + "원";
				} else {
					return cPrice;
				}
			}else{
				
				return "";
			}
			
		});
		Handlebars.registerHelper("makeCount", function(cCount) {
			if (cCount != null) {
				cCount += "";
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
			url : "https://zzim-node.zz.am:3003/cart",
			type : "post",
			data : {
				"email" : email
			}
		}).done(function(result) {
			console.log("result:", result);
			for (var i = 0; i < result.length; i++) {
				var resultObj = result[i];
				var source = $("#cart-template").html();
				var template = Handlebars.compile(source);
				if (resultObj != null) {
					console.log(resultObj);
					if (resultObj['11st'] != null) {

						var elevenObj = resultObj['11st'];
						elevenObj['shop'] = "11";
						elevenObj['mall'] = "https://login.11st.co.kr/login/Login.tmall?returnURL=http%3A%2F%2Fbuy.11st.co.kr%2Fcart%2FCartAction.tmall%3Fmethod%3DgetCartList&xfrom=";
						var html = template(elevenObj);
						$("#cartSection").append(html);

					}
					if (resultObj['gmarket'] != null) {

						var gmarketObj = resultObj['gmarket'];
						gmarketObj['shop'] = "gm";
						gmarketObj['mall'] = "http://escrow.gmarket.co.kr/ko/cart";
						var html = template(gmarketObj);
						$("#cartSection").append(html);
					}
					if (resultObj['auction'] != null) {

						var auctionObj = resultObj['auction'];
						auctionObj['shop'] = "ac";
						auctionObj['mall'] = "http://buy.auction.co.kr/buy/A2014/Cart/Cart.aspx";
						var html = template(auctionObj);
						$("#cartSection").append(html);
					}
					if (resultObj['interpark'] != null) {

						var interparkObj = resultObj['interpark'];
						interparkObj['shop'] = "int";
						interparkObj['mall'] = "http://www.interpark.com/order/cartlist.do?_method=cartList&logintgt=cart&wid1=kang&wid2=cartlist&wid3=02";
						var html = template(interparkObj);
						$("#cartSection").append(html);
					}
				}

			}
		});

	});
</script>
<%@include file="../include/footer.jsp"%>