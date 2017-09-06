<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>

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
		     //console.log(token);
		     //console.log('${user.email}');
		    
			$(document).ajaxSend(function(e, xhr, options) {
		        xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		     });
				
			     
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
                            <form class="halves form-newsletter" data-success="Thanks for your submission, we will be in touch shortly." data-error="Please fill all fields correctly.">
                                <input class="mb16 validate-required validate-email signup-email-field" type="text" placeholder="URL을 입력하세요" name="email">
                                <button class="mb16" type="submit">Notify Me</button>

                            </form>
                            <br><br><br>
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
                    <div class="col-md-2 col-sm-4">
                        <div class="select-option">
                            <i class="ti-angle-down"></i>
                            <select>
                                    <option selected value="Default">Sort By</option>
                                    <option value="Small">Highest Price</option>
                                    <option value="Medium">Lowest Price</option>
                                    <option value="Larger">Newest Items</option>
                                </select>
                        </div>
                        <!--end select-->
                    </div>
                    <div class="col-md-10 text-right">
                        <span class="input-lh">Displaying 8 of 8 results</span>
                    </div>
                </div>
                <!--end of row-->
                <div class="row">
                    <div class="col-sm-12">
                        <hr>
                    </div>
                </div>
                <!--end of row-->
                <div class="row masonry">
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-1.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Adrian
                                    <br /> LambsWool Cap</h5>
                                <span class="display-block mb16">$49.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-2.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Stanley
                                    <br /> Leather Wallet</h5>
                                <span class="display-block mb16">$69.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <span class="label">Sale</span>
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-4.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Logan
                                    <br /> Canvas Backpack</h5>
                                <span class="display-block mb16">$119.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-7.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Vladimir
                                    <br />Stainless Flask</h5>
                                <span class="display-block mb16">$49.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-8.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Nathan
                                    <br /> Cashmere Beanie</h5>
                                <span class="display-block mb16">$45.00</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-5.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Nicholas
                                    <br /> Dune Shades</h5>
                                <span class="display-block mb16">$79.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <span class="label">Hot</span>
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-9.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Bobby
                                    <br />Shaving Brush</h5>
                                <span class="display-block mb16">$27.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-13.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Bradley
                                    <br /> Leather Journal</h5>
                                <span class="display-block mb16">$29.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-11.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Mack
                                    <br /> Steel Canteen</h5>
                                <span class="display-block mb16">$34.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                </div>
                <!--end of row-->
            </div>
            <!--end of container-->
        </section>

    </div>

</body>



</html>



<%@include file="include/footer.jsp"%>


    
				