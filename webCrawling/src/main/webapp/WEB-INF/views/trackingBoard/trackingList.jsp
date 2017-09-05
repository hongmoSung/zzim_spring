<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<style>
.chartdiv {
	/* 	width		: 100%; */
	height: 400px;
	font-size: 12px;
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

	<div class="main-container">
		<section class="scroll-assist page-title page-title-4 bg-dark">

			<div class="container">
				<div class="row">
					<div class="col-md-6 col-md-offset-1">
						<h3 class="uppercase mb0">Tracking List</h3>
					</div>
				</div>
			</div>
		</section>
		<section>
			<div class="container">
				<div id="sList" class="row">
					<h3 style="font-weight: bolder;">Check List</h3>
						<div class="col-sm-12" " >
							<ul id="correctList" class="accordion " style="box-shadow: 5px 5px 10px 2px lightgrey"> </ul>
						</div><br>
					<h3 style="font-weight: bolder;">Uncheck List</h3>
						<div class="col-sm-12" >
							<ul id="inCorrectList" class="accordion " style="box-shadow: 5px 5px 10px 2px lightgrey" > </ul>
						</div>
				</div>
			</div>
		</section>
	</div >

<!-- <td style="color: limegreen"> -->
<!-- <span style="color: black">조건 확인</span><br> -->
<!-- <strong class="fa-2x">{{check notifyPrice pLowest pNo}}</strong> -->
<!-- </td> -->
	<!--         여기서  부터 스크립트 시작  -->
	<script  id="entry-template" type="text/x-handlebars-template">
        {{#each .}} 
       		 <li class="check{{pNo}}" >
                 <div class="title" data-pNo ="{{pNo}}">
                     <table class="table cart">
                             <tr>
                                 <td rowspan="2" class="text-center col-md-2" >
                                         <img alt="Product" class="product-thumb" src="{{picUrl}}" />
                                 </td>
                                 <th colspan="3"  class="col-md-6">
                                     <h5 style="font-weight: bolder;">{{pName}}</h5>
                                 </th>
							 </tr>

                             <tr>
									<td class="col-md-2">
                                     <span><i class="fa fa-krw" aria-hidden="true"></i> : {{notifyPrice}}원</span>
                                 	</td>
                                     <td >
                                         <span><i class="fa fa-money" aria-hidden="true"></i> :  {{pLowest}}원</span>
                                     </td>
									 <td class="col-md-2">
                                     	<a class="btn btn-sm btn-filled"  href="{{pUrl}}" >구매하기</a>
                                 	</td> 
                                     
                             </tr>
                     </table>
                 </div>
                 
                 <div class="content">
                     
                     <div id="chartdiv{{pNo}}"  class="col-sm-8 col-md-8 chartdiv">
                      	차트    
                     </div>
                
                    <div class="col-sm-4 col-md-4" style="text-align: right">
                         <br>
                         <ul class="lead" >
                             <li id="max{{pNo}}"></li>
                             <li id="min{{pNo}}"></li>
                         </ul>
                         <div>
                         </div>
                         
                         <input id="notify{{pNo}}" class="mb10 " type="text" placeholder="{{notifyPrice}}원" style="margin-bottom: 8px;height: 30px;text-align: right;padding-right: 10px;width: auto;">
                         <br>
                         <a id="update" data-pNo="{{pNo}}" class="btn btn-sm btn-rounded" style="text-align: right; margin-bottom: 1px;">희망가 수정하기</a>
                         <br><br>
                         <a id="delete" data-pNo="{{pNo}}" class="btn btn-sm btn-filled"  style="background: red; border: none;">삭제하기</a>
                     </div>
                 </div>
             </li>
        {{/each}}
</script>

	<script type="text/javascript">
// 더보기 + 차트리스트 가져오기 아코디언
$("body").on( 'click', '.accordion li .title' , function(){
  if ($(this).closest('.accordion').hasClass('one-open')) {
      $(this).closest('.accordion').find('li').removeClass('active');
      $(this).addClass('active');
  } else {
      $(this).parent().toggleClass('active'); // parent추가!!!!!!!!!
  }
  if(typeof window.mr_parallax !== "undefined"){
      setTimeout(mr_parallax.windowLoad, 500);
  }
  var pNo = $(this).attr("data-pNo");
//   console.log(pNo);
  
  $.ajax({
	  url : getContextPath()+"/trackingBoard/priceHistory",
	  data : {"pNo":pNo}
  }).done(function(result){
	  var priceArr = []
	  var max = 0;
	  var min = 0;
	  
	 for(var i = 0 ; i < result.length ; i++){
		// currPrice 배열넣기 
		 priceArr.push(result[i].currPrice); 
		  
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
		$("#max"+pNo).html('<i class="ti-arrow-right"></i> 최고가: '+max+'원');
		$("#min"+pNo).html('<i class="ti-arrow-right"></i> 최소가: '+min+'원');
	}else{
		$("#max"+pNo).html('<i class="ti-arrow-right"></i> 최고가: 0원');
		$("#min"+pNo).html('<i class="ti-arrow-right"></i> 최소가: 0원');
	}
	 
	//차트 만들기 
	 var chart = AmCharts.makeChart("chartdiv"+pNo, {
		    "theme": "light",
		    "type": "serial",
		    "marginRight": 80,
		    "autoMarginOffset": 20,
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
		        "enabled": true
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
 		url : getContextPath()+"/trackingBoard/sList",
 		data : {"email" : email}
 	}).done(function(result){
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
 			$('#sList').html("<h3>등록된 상품이 없습니다.</h3>")
 		}
 	}) 

//스크롤 이벤트 -------------------------------------------------------------------------------------------------------
	var page = 2;
	$(window).scroll(function(){
// 		console.log("스크롤  같은거  "+Math.ceil($(window).scrollTop()+0.01), $(document).height() - $(window).height());
// 		console.log("스크롤 이벤트  "+$(window).scrollTop(), $(document).height() , $(window).height());
		if(Math.ceil($(window).scrollTop()+0.01) > $(document).height() - $(window).height()){
			console.log("들어오라 ")
			$.ajax({
				url : getContextPath()+"/trackingBoard/scroll",
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
		if($("#notify"+pNo).val() != '' ){
			$.ajax({
				url:getContextPath()+"/trackingBoard/priceUpdate",
				data:{'pNo':pNo,
					notifyPrice:$("#notify"+pNo).val()}
			}).done(function(result){
				if(result == 1){
					alert("수정됨")
					location.href = getContextPath()+"/trackingBoard/trackingList"
				}
			})
		}// if 끝
		else{
			alert("수정 값을 입력해주세요");
		}
})


//삭제 
$("body").on("click","#delete",function(){
	$.ajax({
		url:getContextPath()+"/trackingBoard/delete",
		data:{pNo:$(this).attr('data-pNo')}
	}).done(function(result){
		alert("삭제 되었습니다.")	
		location.href = getContextPath()+"/trackingBoard/trackingList"
	})
})

</script>

</body>
<%@include file="../include/footer.jsp"%>
