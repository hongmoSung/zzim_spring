<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<html lang="ko">
<script>
	function isTokenSentToServer() {
	    	return window.localStorage.getItem('sentToServer');
	}
	
	function setTokenSentToServer(sent) {
	    	window.localStorage.setItem('sentToServer', sent);
	}
	
	function sendTokenToServer(currentToken) {
		
	}
	
	
	if('${user.email}' != ''){
			//console.log("퍼미션 요청 if문 들어");
	
			messaging.requestPermission()
		 .then(function(){
		     //alert('Have permission! 콘솔에서 토큰 확인!');
		     return messaging.getToken();
		 })
		 .then(function(token){
		     // 여기에서 flag가 false면 서버로 보내서 저장하기(by ajax)
		     // true라면, 그냥 끝? 아님 그냥 콘솔에 찍어주기
		     console.log(token);
		     console.log('${user.email}');
		    
			if(!isTokenSentToServer()){
				//console.log('토큰 저장 로직 들어옴 ');
				
				$(document).ajaxSend(function(e, xhr, options) {
		            xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		         });
				
			     $.ajax({
			    	 		type:"POST",
						url: getContextPath() + "/mobile/saveToken",
						data:{token: token,
							  email:	'${user.email}'}
						//dataType: "json"
					}).done(function(result) {
						setTokenSentToServer(true);
						//console.log('마무리. 토큰테이블이랑 window.localStorage.getItem()해보자 ')
					});
			     
			}	
			
		 })
		 .catch(function(err){
		     //alert('Error occured! Check console');
		     console.log(err);
		 });	 
		
	}
	
	
	messaging.onTokenRefresh(function() {
	    messaging.getToken()
	    .then(function(refreshedToken) {
	    	
		    console.log('토큰 onRefresh 로직 들어옴 ');
	    		localStorage.removeItem('sentToServer');
	      
	    })
	    .catch(function(err) {
	      console.log('Unable to retrieve refreshed token ', err);
	    });
	  });
	
	var email = "${user.email}";
	function sendUrl() {
		var url = $('input[name="url"]').val();
		console.log(url);
		console.log(email);
		
		$.ajax({
			url : "http://192.168.0.25:3003/track",
			type : "post",
			data : {
				"url" : url
			}
		}).done(function(result) {
			console.log(result);
			if(!result.err) {
				$("#myModal").modal();
				$("#picUrl").attr('src', result.picUrl);
				$("#pName").text(result.pName);
				$("p#pLowest").text('현재 최저가 : ' + result.pLowest + ' 원');
				$("p#crawlingUrl").text(result.crawlingUrl);
			} else {
				alert('err!');
			}
		});
		
		return false;
	}
	
	function sendPrice() {
		var notifyPrice = $('input[name="notifyPrice"]').val();
		var pName = $("#pName").text();
		var crawlingUrl = $("p#crawlingUrl").text();
		
		if(notifyPrice == "") {
		    alert("알림가격을 입력해주세요");
		    return;
		  }

		if(isNaN(notifyPrice)){
			alert("알림가격은 숫자만 입력 가능합니다.");
		    return;
		};
		  
		$.ajax({
			url : "http://192.168.0.25:3003/addDB",
			type : "post",
			data : {
				'pName': pName,
			    'notifyPrice': notifyPrice,
			    'crawlingUrl': crawlingUrl,
			    'email': email
			}
		})
		.done(function(result) {
			alert(result.msg);
			console.log(result.msg);
		});
		
		return false;
	}
	
	function recent(){
		$.ajax({
			url: getContextPath() +"/home/recent"
		}).done(makeDown);
	}
	function rank(){
		$.ajax({
			url: getContextPath() +"/home/rank"
		}).done(makeDown);
	}
	function down() {
		$.ajax({
			url: getContextPath() +"/home/drop"
		}).done(makeDown);
	}
	function makeDown(result) {
		var source = $("#list-template").html();
		var template = Handlebars.compile(source);
		
		Handlebars.registerHelper('checkDrop', function (dRate, cPNo) {
			var msg = "";
			if(dRate != null){
				msg = " - " + dRate + "%";
			}else if(cPNo != 0){
				msg = "등록 수 : " + cPNo + "회";
			}
			return msg;
		});
		Handlebars.registerHelper('emailcheck', function (option) {
			if(email != ''){
				return option.fn(this);
			}
			else {
			    return option.inverse(this);
			  }
		});
		
		var html = template(result);
		$("#listTable").html(html);
	}
	down();
	
	
</script>
<body>

    <div class="main-container">

        <section class="cover fullscreen image-bg overlay">
            <div class="background-image-holder">
                <img alt="image" class="background-image" src="/resources/img/cover8.jpg">
            </div>

            <div class="container v-align-transform">
                <div class="row">
                    <div class="col-sm-12 text-center">
                        <img alt="Pic" src="/resources/img/logo-light.png" class="image-small">
                    </div>
                </div>

                <br><br><br>

                <div class="row">
                    <div class="col-md-6 col-md-offset-3 col-sm-10 col-sm-offset-1">
                        <div class="feature bordered text-center">
                            <h3 class="uppercase">start tracking</h3>
                            <br>
                            <form class="halves form-newsletter" onsubmit="javascript:sendUrl();" data-success="Thanks for your submission, we will be in touch shortly." data-error="Please fill all fields correctly.">
                                <input class="mb16 validate-required validate-email signup-email-field" type="text" placeholder="URL을 입력하세요" name="url">
                                <button class="mb16" type="submit">Notify Me</button>
                            </form>
                            <br><br><br><br>
                            <p>
                                해당 상품이 원하는 가격에 도달하면 알려드립니다 !
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>









        <section>
            <div class="container">
                <div class="row">
                    <div>
                    	<ul class="nav nav-tabs" >
							<li class="active"><a data-toggle="tab" onclick="down();" style="cursor:pointer;">가격 하락율</a></li>
						    <li><a data-toggle="tab" onclick="recent();" style="cursor:pointer;" >최신 등록</a></li>
						    <li><a data-toggle="tab" onclick="rank();" style="cursor:pointer;">등록 횟수</a></li>
						</ul>
                    </div>
                </div>
                <br>
                <!--end of row-->
                <div class="row masonry text-center" >
               		<div id="listTable"></div>
                <!-- =========================================================================================== -->
                <script id="list-template" type="text/x-handlebars-template">
					{{#each.}}
	                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
    	                    <div class="image-tile outer-title text-center">
        	                    {{#emailcheck}}
        	                    	<a href="{{pUrl}}">
            	                	    <img src="{{picUrl}}" class="product-thumb"/>
                	           		</a>	
								{{else}}
        	                    	<a href="/user/loginForm">
            	                   		 <img src="{{picUrl}}" class="product-thumb"/>
                	            	</a>
								{{/emailcheck}}
                    	        <div class="title">
                        	        <h5 class="mb0">{{pName}}
                            	        <br />{{checkDrop dRate cPNo}}</h5>
                                	<span class="display-block mb16">{{rPLowest}}원</span>
                	            </div>
            	            </div>
         	           </div>
					{{/each}}
				</script>
                <!-- =========================================================================================== -->
                </div>
                <!--end of row-->
            </div>
            <!--end of container-->
        </section>

    </div>
    
    <div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">×</button>
	          <h4 class="modal-title" id="pName">Modal Header</h4>
	        </div>
	        <div class="modal-body">
	        	<div class="image-tile outer-title text-center">
		          <img id="picUrl" class="product-thumb" src="" />
		          <p id="pLowest"></p>
		          <p id="crawlingUrl" style="display: none;"></p>
	          	</div>
	          <form class="halves form-newsletter" onsubmit="javascript:sendPrice();">
		          <input class="mb16 validate-required validate-email signup-email-field" type="text" placeholder="알림가격을 입력하세요" name="notifyPrice">
	              <button class="mb16" type="submit">tracking!!</button>
              </form>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	      
	    </div>
  	</div>



</body>



</html>



<%@include file="include/footer.jsp"%>


    
				