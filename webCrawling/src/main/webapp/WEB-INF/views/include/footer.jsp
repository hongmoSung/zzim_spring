<footer class="footer-2 bg-dark text-center-xs" style="margin-top: -10em;">
    <div class="container">
        <div class="row">
            <div class="col-sm-4">
                <a href="#"><img class="image-xxs fade-half" alt="Pic" src="/resources/img/logo-light.png"></a>
            </div>

            <div class="col-sm-4 text-center">
                <span class="fade-half">
                                © Copyright 2015 Medium Rare - All Rights Reserved
                            </span>
            </div>

            <div class="col-sm-4 text-right text-center-xs">
                <ul class="list-inline social-list">
                    <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                    <li><a href="#"><i class="ti-facebook"></i></a></li>
                    <li><a href="#"><i class="ti-dribbble"></i></a></li>
                    <li><a href="#"><i class="ti-vimeo-alt"></i></a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<!-- FCM설정 -->
	<script src="https://www.gstatic.com/firebasejs/4.3.0/firebase.js"></script>
	<script>
	  // Initialize Firebase
	  var config = {
	    apiKey: "AIzaSyC9xgu1p5RvwAehO_wmdL6VF5uXzFoB_8c",
	    authDomain: "zzim-521a0.firebaseapp.com",
	    databaseURL: "https://zzim-521a0.firebaseio.com",
	    projectId: "zzim-521a0",
	    storageBucket: "zzim-521a0.appspot.com",
	    messagingSenderId: "948220968110"
	  };
	  firebase.initializeApp(config);
	  
	    
	    const messaging = firebase.messaging();
	    
	    
	    messaging.onMessage(function(payload){
	        alert('알림 도착! payload는 콘솔 확인');
	        console.log('onMessage:', payload); 
	    });
	      
	    function isTokenSentToServer() {
		    	return window.localStorage.getItem('sentToServer');
	    }
	    
	    function setTokenSentToServer(sent) {
		    	window.localStorage.setItem('sentToServer', sent ? true : false);
	    }
	    
	    if('${user.email}' != ''){
	    		//console.log("퍼미션 요청 if문 들어");

	    		messaging.requestPermission()
			 .then(function(){
			     alert('Have permission! 콘솔에서 토큰 확인!');
			     return messaging.getToken();
			 })
			 .then(function(token){
			     // 여기에서 flag가 false면 서버로 보내서 저장하기(by ajax)
			     // true라면, 그냥 끝? 아님 그냥 콘솔에 찍어주기
			//     alert(token);
			     console.log(token);
			     console.log('${user.email}');
			    
			     
			     /* 
				if(!isTokenSentToServer()){
				     $.ajax({
							url : getContextPath()+"/trackingBoard/scroll",
							data:{page: page,
								  email:	'${user.email}'
							}
							//dataType: "json"
						})
				}			     
 */
			 })
			 .catch(function(err){
			     alert('Error occured! Check console');
			     console.log(err);
			 });	 
	    	
	    }
	</script>