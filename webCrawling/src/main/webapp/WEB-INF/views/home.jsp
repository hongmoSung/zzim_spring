<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>

<html lang="ko">
<script>
	$(document).ajaxStart(function () {
	    $("body").waitMe({
	        effect: 'win8',
	        text: '기다려',
	        bg: 'rgba(255,255,255,0.7)',
	        color: '#000',
	        source: '/resources/img.svg'
	    });
	})
	.ajaxStop(function () {
	    $("body").waitMe("hide");
	});
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
	console.log('email..................', email);
	function sendUrl() {
		var url = $('input[name="url"]').val();
		console.log(url);
		console.log(email);
		
		$.ajax({
			url : "http://localhost:3003/track",
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
				$("p#pLowest").html('현재 최저가 : <span id="pLowest">' + result.pLowest + '</span> 원');
				$("p#crawlingUrl").text(result.crawlingUrl);
			} else {
				alert('err!');
			}
		});
		
		return false;
	}
	
	function sendPrice() {
		console.log('1');
		console.log('2');
			var notifyPrice = $('input[name="notifyPrice"]').val();
			var pName = $("#pName").text();
			var crawlingUrl = $("p#crawlingUrl").text();
			var pLowest = $('span#pLowest').text().trim().replace(/,/gi, '');
			console.log('notifyPrice:::::::::::', notifyPrice);
			console.log('pLowest:::::::::::', pLowest);
			if(notifyPrice == "") {
			    alert("알림가격을 입력해주세요");
			    return;
			  }

			if(isNaN(notifyPrice)){
				alert("알림가격은 숫자만 입력 가능합니다.");
			    return;
			};
			  
			 $.ajax({
				url : "http://localhost:3003/addDB",
				type : "post",
				data : {
					'pName': pName,
				    'notifyPrice': notifyPrice,
				    'crawlingUrl': crawlingUrl,
				    'email': email,
				    'pLowest': pLowest
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
				if (dRate < 0){
					msg = " ( + " + dRate + "% )";
				}
				else{
					msg = " ( - " + dRate + "% )";
				}
			}else if(cPNo != 0){
				msg = " ( " + cPNo + "회 )";
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

        <section class="image-bg cover overlay" style="height:650px; ">
            <div class="background-image-holder">
                <img alt="image" class="background-image" src="/resources/img/main_back.jpg">
                
            </div>

            <div class="container v-align-transform" style="margin-top:-30px;">
                <div class="row">
                    <div class="col-sm-12 text-center" >
                        <img alt="Pic" src="/resources/img/main_zzim.png" class="image-md" style="margin-bottom:-50px;">
                    </div>
                </div>

                <br><br><br>

                <div class="row">
                    <div class="col-md-6 col-md-offset-3 col-sm-10 col-sm-offset-1" >
                        <div class="feature bordered text-center" style="background-color:rgba( 0, 0, 0, 0.6 );">
                            <h3 class="uppercase">start tracking</h3>
                            <br>
                            <form id="urlForm" class="halves form-newsletter" onsubmit="javascript:sendUrl();" data-success="Thanks for your submission, we will be in touch shortly." data-error="Please fill all fields correctly.">
                                <input class="mb16 validate-required validate-email signup-email-field" type="text" placeholder="URL을 입력하세요" name="url">
                                <button id="urlBtn" class="mb16 btn-fiiled" type="submit" style="background-color:#47b475; color:white;">Notify Me</button>
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
        	                    	<a href="{{pUrl}}" target="_blank">
            	                	    <img src="{{picUrl}}" class="product-thumb"/>
                	           		</a>	
								{{else}}
        	                    	<a href="/user/loginForm">
            	                   		 <img src="{{picUrl}}" class="product-thumb"/>
                	            	</a>
								{{/emailcheck}}
                    	        <div class="title">
                        	        <h5 class="mb0">{{pName}}</h5><br>
                                	<span class="display-block mb16">{{rPLowest}}원<span style="color:red;" class="dRateColor">{{checkDrop dRate cPNo}}</span></span>
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
		<div style="height:50px;"></div>
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
	          <form id="addDbForm" class="halves form-newsletter" onsubmit="javascript:sendPrice();">
		          <input class="mb16 validate-required validate-email signup-email-field" type="text" placeholder="알림가격을 입력하세요" name="notifyPrice">
	              <button class="mb16" type="submit" id="addDbBtn">tracking!!</button>
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


    
				