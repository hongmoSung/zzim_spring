
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<body class="scroll-assist">

	<div class="main-container">
		<section class="page-title page-title-4 bg-dark">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h3 class="uppercase mb0">메타 장바구니</h3>
					</div>
					<div class="col-md-6 text-right">
						<ol class="breadcrumb breadcrumb-2">
							<li><a href="index.html">Home</a></li>
							<li class="active">Meta cart</li>
						</ol>
					</div>
				</div>
			</div>
		</section>
		<section id="cartSection">
		</section>
	</div>
</body>


<script id="cart-template" type="text/x-handlebars-template">
<div class="container feature boxed bordered"
	style="box-shadow: 5px 5px 10px -1px lightgrey">
	<div class="feature text-center">
		<img class="product-thumb" src="/resources/img/logo/{{shop}}.png" />
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
						var html = template(elevenObj);
						$("#cartSection").append(html);

					}
					if (resultObj['gmarket'] != null) {

						var gmarketObj = resultObj['gmarket'];
						gmarketObj['shop'] = "gm";
						var html = template(gmarketObj);
						$("#cartSection").append(html);
					}
					if (resultObj['auction'] != null) {

						var auctionObj = resultObj['auction'];
						auctionObj['shop'] = "ac";
						var html = template(auctionObj);
						$("#cartSection").append(html);
					}
					if (resultObj['interpark'] != null) {

						var interparkObj = resultObj['interpark'];
						interparkObj['shop'] = "int";
						var html = template(interparkObj);
						$("#cartSection").append(html);
					}
				}

			}
		});

	});
</script>
<%@include file="../include/footer.jsp"%>