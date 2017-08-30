<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="../include/header.jsp"%>

<style>
body {
   height:100px; 
}
</style>

<section>

<!--  모달  안보임 -->
<div class="modal " id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
		<div id="chart2"></div>
			희망가격<input type="text" id="notify"><button id="update" >수정</button>		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- 시작------------------------------------------------------------------------------------ -->

<div id="list" class="container">
	<table class="table">
	    <thead> 
	        <th><input id="allCheck" type="checkbox"></input><button id="delete">삭제</button></th> 
	        <th>이미지</th> 
	        <th>제목</th> 
	        <th>희망가</th> 
	        <th>현재가</th> 
	        <th>차이</th> 
	        <th>체크</th> 
	        <th >더보기</th> 
	    </thead> 
	    <tbody id="listStart"></tbody> 
	</table>
</div>

<script id="entry-template" type="text/x-handlebars-template">
        {{#list}} 
        <tr> 
            <td><input class="chechs" type="checkbox" data-pNo="{{pNo}}" ></input></td>
            <td><img src="{{picUrl}}"></td> 
            <td>{{pName}}</td> 
            <td>{{notifyPrice}}</td>  
            <td>{{pLowest}}</td> 
            <td>{{tt notifyPrice pLowest}}</td> 
            <td>{{cc notifyPrice pLowest}}</td> 
            <td><button class="chartBtn" id="popbutton" data-pNo="{{pNo}}" data-nitify="{{notifyPrice}}" >더보기</button></td> 
        </tr>
        {{/list}}
</script>

<script type="text/javascript">

// 핸들바 함수 
function handle(result){
	//핸들바 템플릿 가져오기
	var source = $("#entry-template").html(); 
	//핸들바 템플릿 컴파일
	var template = Handlebars.compile(source); 
	//헬퍼 notifyPrice - pLowest 차이 표시 
	Handlebars.registerHelper('tt', function (notifyPrice, pLowest) {
	  return notifyPrice-pLowest;
	});
	Handlebars.registerHelper('cc', function (notifyPrice, pLowest) {
	  return (notifyPrice > pLowest)? '체크':'미체크';
	});
	//핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
	var html = template(result);
	//생성된 HTML을 DOM에 주입
	$('#listStart').append(html);
}
	
//첫 리스트 가져오기
	var email = "${user.email}";
	console.log(email);
  	$.ajax({
 		url : getContextPath()+"/trackingBoard/sList",
 		data : {email : email}
 	}).done(function(result){
 		handle(result);
 	}) 

//스크롤 이벤트 -------------------------------------------------------------------------------------------------------
	var page = 2;
	$(window).scroll(function(){
		console.log("스크롤 이벤 트  "+$(window).scrollTop(), $(document).height() , $(window).height());
		if($(window).scrollTop() == $(document).height() - $(window).height()){
			
			$.ajax({
				url : getContextPath()+"/trackingBoard/scroll",
				data:{page:page,
						email:	'${user.email}'
				},
				dataType: "json"
			}).done(function(result){
				if(result.list != ''){
				page++;
				handle(result)
				}
				else{
					alert("게시물이 없습니다.");
					$("body").scrollTop($(window).scrollTop()-20);
				}
			})
		}
	})

//모달 띄우기 + 차트 + 희망가 수정 ------------------------------------------------------------------------------------------------------
// function modal(){
	$('table').delegate( '.chartBtn', 'click' , function(){
    	//모달 띄우기
    	 $('div.modal').modal();
    	// 버튼에 넘버랑 알림가격 가져오기 
    	var pNo = $(this).attr('data-pNo');
    	var nitify = $(this).attr('data-nitify');
    	 $('#update').attr('data-pNo',pNo);
    		//알림가격 넣기 
    		$("#notify").val(nitify);
    	// 그래프 데이타 가져오는 ajax
    	$.ajax({
    		url : getContextPath()+"/trackingBoard/chart",
			data:{pNo:pNo}
    	}).done(function(result){
    		result.unshift("가격");
    		
    	// c3 차트 띄우기  (애니메이션문제)비동기로 시간 늦춤
    		 c3.generate({
				bindto: "#chart2",
			    data: {   columns: [ result  ] },
			    legend: {  show: false },
			    axis: { x: {
			            type: 'category',
			            categories: ['1월', '2월', '3월', '4월', '5월', '6월']
			        }
			    }
			});
    	})// ajax끝
	});
	
// 수정 클릭 
$("#update").click(function(){
	$.ajax({
		url:getContextPath()+"/trackingBoard/priceUpdate",
		data:{pNo:$("#update").data('pno'),
			notifyPrice:$("#notify").val()
			}
	}).done(function(result){
		if(result == 1){
			alert("수정됨")
			location.href = getContextPath()+"/trackingBoard/list"
		}
	})
	return false;
})


//선택 삭제
$("#delete").click(function(){
	var arrr = [];
	$(".chechs").each(function(i){
		if($(".chechs:eq("+i+")").prop("checked")){
			arrr.push($(".chechs:eq("+i+")").attr("data-pNo"))
		}
	})
	$.ajaxSettings.traditional = true;
	$.ajax({
		url:getContextPath()+"/trackingBoard/delete",
		data:{arrr:arrr}
	}).done(function(result){
		if(result > 1){
			alert("삭제했습니다.");
			location.href = getContextPath()+"/trackingBoard/list"
		}
	})
})

//체크박스 체크기능
$(function(){
	//전체선택 체크박스 클릭 
	$("#allCheck").click(function(){
		//만약 전체 선택 체크박스가 체크된상태일경우 
		if($("#allCheck").prop("checked")) { 
			//해당화면에 전체 checkbox들을 체크해준다 
			$(".chechs").prop("checked",true);
			// 전체선택 체크박스가 해제된 경우 
			} else { 
				//해당화면에 모든 checkbox들의 체크를해제시킨다. 
				$(".chechs").prop("checked",false); 
				}
			})
		})
		
//개별선택 해지시 전체체크해제
$('table').delegate( '.chechs', 'click' , function(){
	if($("#allCheck").prop("checked")){
			$("#allCheck").prop("checked", false);
	}
	var k = 0;
	for(var i= 0 ; i<$(".chechs").length; i++){
		if($(".chechs:eq("+i+")").prop("checked")){
			k++;
		}
		if(k == $(".chechs").length){
			$("#allCheck").prop("checked", true);
		}
	}
})
</script>

</section>
