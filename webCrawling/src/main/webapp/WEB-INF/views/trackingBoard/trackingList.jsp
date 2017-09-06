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
	background-color: tomato;
}

#ic:hover #tooltip{
	visibility: visible;
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
<!-- 							style="box-shadow: 5px 5px 10px 2px lightgrey;" -->
							<ul id="correctList" class="accordion"  > </ul>
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

<!-- border: 1px solid; margin-top: 10px; border-collapse:separate; -->
	<!--         여기서  부터 스크립트 시작  -->
	<script   id="entry-template" type="text/x-handlebars-template">
        {{#each .}} 
       		 <li class="check{{pNo}}  " style="border: 1px solid; border-radius: 15px; margin-top: 10px; "  >
                 <div class="title" data-pNo ="{{pNo}}">
                     <table class=" cart">
                             <tr>
                                 <td rowspan="2" class="text-center " >
                                         <img alt="Product" class="product-thumb" style="margin-bottom:-20px;" src="{{picUrl}}" />
                                 </td>
                                 <th colspan="3"  class="col-md-9">
                                     <h5 style="margin-top:20px; ; font-size: 1.8em; ">{{pName}}</h5>
                                 </th>
							 </tr>

                             <tr>
									<td class="col-md-2">
                                     	<span style="font-size:1.2em"><i id="ic" class="fa fa-krw" aria-hidden="true"><span id="tooltip">희망가</span></i> : {{notifyPrice}}원</span>
                                 	</td>
                                     <td >
                                         <span style="font-size:1.2em"><i class="fa fa-money" aria-hidden="true"></i>현재가 :  {{pLowest}}원</span>
                                     </td>
									 <td class="col-md-2">
                                     	<a class="btn btn-dm btn-filled" style="margin-bottom:-10px;"  href="{{pUrl}}" >구매하기</a>
                                 	</td> 
                                     
                             </tr>
                     </table>
                 </div>

                 <div class="content">
                 <hr style="width:95%;" class="center">
                     
                     <div id="chartdiv{{pNo}}"  class="col-sm-8 col-md-8 chartdiv">
                      	차트    
                     </div>
                
                    <div class="col-sm-4 col-md-4" style="text-align: center; margin-top:50px;">
                         <br>
                         <ul class="lead " >
                             <li style="font-size:1em;" class="text-center " id="max{{pNo}}"></li>
                             <li style="font-size:1em;" class="text-center " id="min{{pNo}}"></li>
                         </ul>
                         <div>
                         </div>
                         
                         <input id="notify{{pNo}}" class="mb10 " type="text" placeholder="{{notifyPrice}}원" style="margin-bottom: 8px;height: 30px;text-align: right;padding-right: 10px;width: auto;">
                         <br>
                         <a id="update" data-pNo="{{pNo}}" class="btn btn-md btn-rounded" style="text-align: right; margin-bottom: 1px;">희망가 수정하기</a>
                         <br><br>
                         <a id="delete" data-pNo="{{pNo}}" class="btn btn-md btn-filled"  style="background: red; border: none;">삭제하기</a>
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
	  url : getContextPath()+"/priceHistory",
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
		$("#max"+pNo).html('<i class="fa fa-level-up" aria-hidden="true"></i> 최고가 :  '+max+'원');
		$("#min"+pNo).html('<i class="fa fa-level-down" aria-hidden="true"></i> 최저가 :  '+min+'원');
	}else{
		$("#max"+pNo).html('<i class="fa fa-level-up" aria-hidden="true"></i> 최고가 :  0원');
		$("#min"+pNo).html('<i class="fa fa-level-down" aria-hidden="true"></i> 최저가 :  0원');
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
 		url : getContextPath()+"/sList",
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
 		if(result.correctList == ''){
 			$('#correctList').html("<h4>만족 된 상품이 없습니다.</h4>")
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
		if($("#notify"+pNo).val() != '' ){
			$.ajax({
				url:getContextPath()+"/priceUpdate",
				data:{'pNo':pNo,
					notifyPrice:$("#notify"+pNo).val()}
			}).done(function(result){
				if(result == 1){
					alert("수정됨")
					location.href = getContextPath()+"/trackingList"
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
		url:getContextPath()+"/delete",
		data:{pNo:$(this).attr('data-pNo')}
	}).done(function(result){
		alert("삭제 되었습니다.")	
		location.href = getContextPath()+"/trackingList"
	})
})

</script>

</body>
<%@include file="../include/footer.jsp"%>
