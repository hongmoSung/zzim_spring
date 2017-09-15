<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<style>
.chartdiv {
	/* 	width		: 100%; */
	height: 400px;
	font-size: 12px;
}

#tooltip{
	visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    position: absolute;
   
    bottom: 150%;
    left: 50%;
    margin-left: -60px;
}

#ic:hover #tooltip, .ic:hover #tooltip{
	visibility: visible;
}

#tooltip::after {
    content: " ";
    position: absolute;
    top: 100%; /* At the bottom of the tooltip */
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: black transparent transparent transparent;
}

</style>
<!--  am차트 -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script
	src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<!--  am차트 -->

<body>

	<div class="main-container" style="margin-bottom:50px;">
		<section class="image-bg cover overlay page-title page-title-4"  style="height:250px;">
			<div class="background-image-holder">
	<!-- 			<img alt="image" class="background-image" src="/resources/img/trkList_back.jpg" style="height:250px;"> -->
				<img alt="image" class="background-image" src="/resources/img/trkList_test2.png" style="height:250px;">
			</div>
			<div class="container">	
				<div class="row">
					<div class="col-md-6 col-md-offset-1">
						<h2 class="uppercase mb0" style="font-weight:bolder;">Tracking List</h2>
					</div>
					<div class="col-md-4 text-right">
						<ol class="breadcrumb breadcrumb-2">
							<li><a href="${pageContext.request.contextPath}/">Home</a></li>
							<li class="active">Tracking List</li>
						</ol>
					</div>
				</div>
			</div>
		</section>
		<section style="margin-top: -50px;" >
			<div class="container">
				<div id="sList" class="row">
					<h3 style="font-weight: bolder;">Conditions Met</h3>
						<div class="col-sm-12" " >
<!-- 							style="box-shadow: 5px 5px 10px 2px lightgrey;" -->
							<ul id="correctList" class="accordion"  > </ul>
						</div><br>
						<div class="col-sm-12" style="margin-top:60px;" >
							<ul id="inCorrectList" class="accordion  "  > </ul>
						</div>
				</div>
			</div>
		</section>
	</div >

<!-- <td style="color: limegreen"> -->
<!-- <span style="color: black">조건 확인</span><br> -->
<!-- <strong class="fa-2x">{{check notifyPrice pLowest pNo}}</strong> -->
<!-- </td> -->

<!-- border: 1px solid; margin-top: 10px; border-collapse:separate; -->
<!-- 최고 최저가 li 태크 -->
<!--  <ul class="lead " > -->
<!--     <li style="font-size:0.8em;" class=" ic" id="max{{pNo}}"></li> -->
<!--     <li style="font-size:0.8em;" class=" ic" id="min{{pNo}}"></li> -->
<!-- </ul> -->
	<!--         여기서  부터 스크립트 시작  -->
	<script   id="entry-template" type="text/x-handlebars-template">
        {{#each .}} 
       		 <li id="{{pNo}}" class="check{{pNo}} col-sm-12 col-md-12 " style="border: 1px solid; border-radius: 15px; margin-top: 10px; "  >
                 <div class="title col-sm-12 col-md-12" data-pNo ="{{pNo}}" data-price="{{pLowest}}" style="width:100%">
                     <table class=" cart " style="width:100%">
                             <tr>
                                 <th rowspan="2" class="text-center col-md-2" >
                                         <img alt="Product" class="product-thumb" style="margin-bottom:-20px;" src="{{picUrl}}" />
                                 </th>
                                 <th colspan="3"  class="col-md-6">
                                     <h5 style="margin-top:20px; ; font-size: 1.8em; ">{{pName}}</h5>
                                 </th>
							 </tr>

                             <tr>
									<td class="col-md-3">
                                     	<span id="ic" style="font-size:1.2em"><i  class="fa fa-cart-arrow-down" aria-hidden="true"><span id="tooltip">희망가</span></i> : {{notifyPrice}}원</span>
                                 	</td>
                                     <td class="col-md-3" >
                                         <span id="ic" style="font-size:1.2em"><i  class="fa fa-krw" aria-hidden="true"><span id="tooltip">현재가</span></i> :  {{checkPrice pLowest rPLowest}}</span>
                                     </td>
									 <td class="col-md-4" data-pNo="{{pNo}}">
										<div style="text-align: center ;">
                                     	  <a class="btn btn-dm btn-filled" style="margin-bottom:-10px; display:{{checkDisplay pLowest}}"  href="{{pUrl}}" target="_blank" >구매하기</a>
                                        
										{{#nonPrice pLowest }}
                                     	  <a id="delete" data-pNo="{{pNo}}" class="btn btn-md btn-filled" style="margin-bottom:-10px; background: red; border: none;">삭제하기</a>
                                        {{/nonPrice}}
                                 	</td> 
										</div>
                                     
                             </tr>
                     </table>
                 </div>

                 <div class="content col-sm-12 col-md-12" >
                 <hr >
                     
                     <div id="chartdiv{{pNo}}"  class="col-sm-8 col-md-8 chartdiv">
                      	차트    
                     </div>
                
                    <div class="col-sm-4 col-md-4 " data-pNo="{{pNo}}" style="text-align: center ; margin:10px 0px 0px 0px; background: #ececec; ">
                         <br>
							<table class="table" style="text-align: center ;">
								<thead>
									<tr>
										<th style="text-align: center ;">유형</th>
										<th style="text-align: center ;">가격</th>
									</tr>
								</thead>
								<tbody >
									<tr>
										<td>최고가</td>
										<td><li style="font-size:0.8em;" class=" ic" id="max{{pNo}}"></li></td>
									</tr>
									<tr>
										<td>최저가</td>
										<td><li style="font-size:0.8em;" class=" ic" id="min{{pNo}}"></li></td>
									</tr>
									<tr>
										<td>평균가</td>
										<td><li style="font-size:0.8em;" class=" ic" id="aver{{pNo}}"></li></td>
									</tr>
								</tbody>
							</table>
							
                        
                         <input id="notify{{pNo}}" class="mb10 " type="text" placeholder="{{notifyPrice}}원" style="margin-bottom: 8px;height: 30px;text-align: right;padding-right: 10px;width: auto;">
                         <br>
                         <a id="update" data-pNo="{{pNo}}" class="btn btn-md btn-rounded" style=" margin-right: 0px; ">희망가 수정하기</a>
							<br>
                         <a id="delete" data-pNo="{{pNo}}" class="btn btn-md btn-filled" style=" background: red; border: none;">삭제하기</a>
                         
                     </div>
                 </div>
             </li>
        {{/each}}
</script>

	<script type="text/javascript">
	
// 더보기 + 차트리스트 가져오기 아코디언
$("body").on( 'click', '.accordion li .title' , function(){

	var that = $(this);
// 상품 값이 0 이하일떄 아코디언 불가처리
  if(parseInt(that.attr("data-price")) <= 0){
	  
// 	  alert("검색불가");
	  return;
  }	
	
  if (that.closest('.accordion').hasClass('one-open')) {
      that.closest('.accordion').find('li').removeClass('active');
      that.addClass('active');
  } else {
      that.parent().toggleClass('active'); // parent추가!!!!!!!!!
  }
  if(typeof window.mr_parallax !== "undefined"){
      setTimeout(mr_parallax.windowLoad, 500);
  }
  var pNo = $(this).attr("data-pNo");
//   console.log(pNo);
  
  
  //showChart(pNo);
   $.ajax({
	  url : getContextPath()+"/priceHistory",
	  data : {"pNo":pNo}
  }).done(function(result){
	  console.dir("result  "+result[0].currPrice);
	  var priceArr = []
	  var average = 0;
	  var max = 0;
	  var min = 0;
	  
	 for(var i = 0 ; i < result.length ; i++){
// 	  console.log("result1111  "+result[i].currPrice);
		// currPrice 배열넣기 
		 priceArr.push(result[i].acurrPrice); 
		 average +=result[i].currPrice;
		  
// 		 console.log("result[i].currDate:::",result[i].currDate); 
		// 날자값 변환
		 var date = new Date(result[i].currDate);
		 var timeStr = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
// 		 console.log(timeStr); 
		 result[i].currDate = timeStr;
	 }
 	// 배열 오름차순 정열
	 priceArr.sort(function(a,b){return a-b;})
	// max, min 값 넣기 		 
	 max = priceArr[priceArr.length-1]
	 min = priceArr[0]

	//최소값 최대값 넣기 
	if(result != ''){
		$("#max"+pNo).html('  '+max+'원');
		$("#min"+pNo).html('  '+min+'원');
		$("#aver"+pNo).html('  '+Math.round(average / result.length).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원');
	}else{
		$("#max"+pNo).html('  - 원');
		$("#min"+pNo).html('  - 원');
		$("#aver"+pNo).html('  - 원');
	}
	 
	//차트 만들기 
	 var chart = AmCharts.makeChart("chartdiv"+pNo, {
		    "theme": "light",
		    "type": "serial",
		    "marginRight": 80,
		    "autoMarginOffset": 20,
		    "mouseWheelZoomEnabled":true,
		    "marginTop":20,
		    "dataProvider": result,
		    "valueAxes": [{
		        "id": "v1",
		        "axisAlpha": 0.1
		    }],
		    "graphs": [{
		        "useNegativeColorIfDown": true,
		        "balloonText": "[[category]]<br><b>value: [[value]]</b>",
		        "bullet": "round",
		        "bulletBorderAlpha": 1,
		        "bulletBorderColor": "#FFFFFF",
		        "hideBulletsCount": 50,
		        "lineThickness": 2,
		        "lineColor": "#fdd400",
		        "negativeLineColor": "#67b7dc",
		        "valueField": "currPrice"
		    }],
		    "chartScrollbar": {
		        "scrollbarHeight": 5,
		        "backgroundAlpha": 0.1,
		        "backgroundColor": "#868686",
		        "selectedBackgroundColor": "#67b7dc",
		        "selectedBackgroundAlpha": 1
		    },
		    "chartCursor": {
		        "valueLineEnabled": true,
		        "valueLineBalloonEnabled": true
		    },
		    "categoryField": "currDate",
		    "categoryAxis": {
		        "parseDates": true,
		        "axisAlpha": 0,
		        "minHorizontalGap": 60
		    },
		    "export": {
		        "enabled": false
		    }
	 });
	 
  });
  
});
// 핸들바 함수 
function handle(result,target){
	//핸들바 템플릿 가져오기
	var source = $("#entry-template").html(); 
	//핸들바 템플릿 컴파일
	var template = Handlebars.compile(source);
	//핸들바 if
	Handlebars.registerHelper('nonPrice', function(price, block) {
		var accum = '';
		if (price < 0 ) {
			accum += block.fn();
		}
		return accum;
	});
	//헬퍼 pLowestrk 0일때
	Handlebars.registerHelper("checkDisplay", function(price) {
		return price > 0 ?"":"none";
	});
	//헬퍼 pLowestrk 0일때
	Handlebars.registerHelper("checkPrice", function(price,  rprice) {
		return price > 0 ? rprice+"원":"상품이 매진 되었습니다.";
	});
	//헬퍼  pLowest 차이 표시 
	Handlebars.registerHelper('check1', function (notifyPrice, pLowest, pNo) {
		return (notifyPrice >= pLowest)? '√':'×';
	});
	Handlebars.registerHelper('check2', function (notifyPrice, pLowest, pNo) {
		return (notifyPrice - pLowest);
	});
	//핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
	var html = template(result);
	//생성된 HTML을 DOM에 주입
	$(target).append(html);
}
	
//첫 리스트 가져오기
	var email = "${user.email}";
	console.log(email);
  	$.ajax({
 		url : getContextPath()+"/sList",
 		data : {"email" : email}
 	}).done(function(result){
 		console.log("에작스 완료")
 		var sign = true;
 		if(result.correctList != ''){
 			handle(result.correctList,"#correctList");
 			sign = false;
 		}
 		if(result.incorrectList != ''){
 			handle(result.incorrectList,"#inCorrectList");
 			sign = false;
 		}
 		if(sign){
 			$('#sList').html("<h2 style='text-align: center;margin-top: 80px;'>등록된 상품이 없습니다.</h2>")
 		}
 		if(result.correctList == '' && result.inCorrectList == ''){
 			$('#correctList').html("<h4>만족 된 상품이 없습니다.</h4>")
		}
 		
 		
 		
 		
 		var addr = document.location.href;
 		var sharpIndex = addr.indexOf("#");
 		
 		if(sharpIndex != -1){
 			var pNo = addr.substring(sharpIndex)
	 		location.href = pNo;

 			$(pNo+'>div').trigger("click");
 		}
 	}) 

//스크롤 이벤트 -------------------------------------------------------------------------------------------------------
	var page = 2;
	$(window).scroll(function(){
// 		console.log("스크롤  같은거  "+Math.ceil($(window).scrollTop()+0.01), $(document).height() - $(window).height());
// 		console.log("스크롤 이벤트  "+$(window).scrollTop(), $(document).height() , $(window).height());
		if(Math.ceil($(window).scrollTop()+0.01) > $(document).height() - $(window).height()){
// 			console.log("들어오라 ")
			$.ajax({
				url : getContextPath()+"/scroll",
				data:{page:page,
						email:	'${user.email}'
				},
				dataType: "json"
			}).done(function(result){
				if(result.list != ''){
					console.log(result)
				page++;
				handle(result.list , "#inCorrectList")
				}
				else{
// 					$("body").scrollTop($(window).scrollTop()-20);
// 					console.log("--2실험--")
				}
			})
		}
	})
	
	
// 수정 클릭 
$("body").on("click","#update",function(){
	var pNo = $(this).attr('data-pNo');
	var update = $("#notify"+pNo).val();
		if(update != '' ){
			if(isNaN(update)){
				alert("숫자로 입력해주세요")
			}else{
				$.ajax({
					url:getContextPath()+"/priceUpdate",
					data:{'pNo':pNo,
						notifyPrice:update}
				}).done(function(result){
						alert("수정되었습니다.")
						location.href = getContextPath()+"/trackingList"
				})
			}
			
		}// if 끝
		else{
			alert("수정 값을 입력해주세요");
		}
})


//삭제 
$("body").on("click","#delete",function(){
	$.ajax({
		url:getContextPath()+"/delete",
		data:{pNo:$(this).parent().attr('data-pNo'),
			email:email}
	}).done(function(result){
		alert("삭제 되었습니다.")
		location.href = getContextPath()+"/trackingList"
	})
})

</script>

</body>
<%@include file="../include/footer.jsp"%>
