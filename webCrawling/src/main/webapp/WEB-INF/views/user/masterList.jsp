<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<style>
   input placeholder {
      color:#FFFAFA;
   }
   input[type='text'], input[type='password'], select {
      background-color: #F0FFF0;
      border: 1px solid #DCDCDC;
   }
   i.ti-angle-down{
      margin-top: -15px;
   }
   
   #tooltip{
	visibility: hidden;
	margin :0 0 0 30px;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 5px;

    bottom: 100%;
	}

 	.imgTag:hover #tooltip { 
 		visibility: visible; 
 	} 
	#tooltip::after {
	    content: " ";
	    top: 100%; /* At the bottom of the tooltip */
	    left: 50%;
	    margin-left: -5px;
	    border-width: 5px;
	    border-style: solid;
	    border-color: black transparent transparent transparent;
	}
	
</style>
<body>
<div class="main-container">
   <section class="page-title page-title-4 bg-dark" style="height:150px;">
      <div class="container">
         <div class="row">
            <div class="col-md-6 col-md-offset-1">
               <h3 class="uppercase mb0">로그인 계정 관리</h3>
            </div>
         </div>
      </div>
   </section>
   <section>
   <!-- 리스트 -->
   <div class="container">
      <div class="row">
         <div style="margin-left:86px;">
            <input type="hidden" id="_csrf" value="${_csrf.token}">
            <input type="hidden" id="_csrf_header" value="${_csrf.headerName}">
<!--                <a type="button" name="deleteMaster" id="deleteMaster" class="btn btn-sm" style="margin-left:15px;">선택항목 삭제</a> -->
         </div>
         <div>
         	<span style="margin-left: 180px; font-weight:bold; font-size:17px;">사이트</span>
        	<span style="margin-left: 140px; font-weight:bold; font-size:17px;">아이디</span>
	        <a type="button" id="insertForm" class="btn btn-sm btn-filled" style="float:right; position:relative; right:138px;">등록</a>
	        <hr>
         </div>
         <div class="col-md-10 col-md-offset-1">
            <div class="post-snippet mb64">
				<div class="input-with-label" style="width:100%; display:none;">
           			<span class="select-option" style="display:inline; ">
              		 	<i class="ti-angle-down"></i>
               		 	<select id="websiteType"  style="width:20%; display:inline; margin-left:20px;">
               				<option value="empty">사이트 입력</option>
               				<option value="11st">11st</option>
                  			<option value="gmarket">gmarket</option>
                  			<option value="auction">auction</option>
                  			<option value="interpark">interpark</option>
              			</select>
                	</span>
               		<h5 style="display:inline;  margin:0 10px 0 15px;""><span style="display:inline;"></span></h5>
          	  		<input type="text" name="masterId" id="masterId" style="width:20%;" placeholder="아이디">
                  
               		<h5 style="display:inline;  margin:0 10px 0 15px;""><span style="display:inline;"></span></h5>
               		<input type="password" name="masterPassword" id="masterPassword" style="width:25%;"  placeholder="비밀번호">
              		<a type="button" name="masterCancel" class="btn btn-sm" style="float:right; margin-top:10px; margin-right:15px; padding: 0 10px;">취소</a>
              		<a type="button" name="masterRegist" class="btn btn-sm" style="float:right; margin-top:10px; margin-right:5px; padding: 0 10px;">등록</a>
              		<br>
              		<hr>
            	</div>
           		<span id="emptyComment"></span>
            	<div id="listTable"></div>
            </div>
         </div>
      </div>
   </div>
</section>
</div>
</body>
			<script id="list-template" type="text/x-handlebars-template">
					{{#each .}}	
						<div style="height:95px;">
							<ul class="post-meta text-center" style="width: 20%; margin-bottom:20px; margin-left:30px;">
								<li id="first{{@index}}"style="" class="imgTag" >
									<a id="imgTag{{@index}}" target="_blank">
										<img id="img{{@index}}" src="" style="margin-left:10px;  width:100px;" >
									</a>
									<span name="website{{@index}}" style="display:none;">{{website}}</span>
								</li>
							</ul>
							<ul class="post-meta" name="11st{{@index}}" style="width: 100px; margin: 20px 0 30px 50px;">
								<li id="second{{@index}}">
									<span name="websiteId{{@index}}" style=" font-size:20px;">{{websiteId}}</span>
								</li>
							</ul>
							<ul class="post-meta" style="float:right; margin-top:20px;">
								<li id="updateGo{{@index}}">
									<a name="findId{{@index}}" target="_blank" style="position: relative; bottom:10px; padding:0 10px;" >아이디 찾기</a>
									<a name="findPw{{@index}}" target="_blank" style="position: relative; bottom:10px; padding:0 10px; margin-right:10px;" >비밀번호 찾기</a>
									<a type="button" onclick="deleteSubmit({{@index}});" class="btn btn-filled btn-sm" style="background-color:#F34242; border-color:#F34242;">삭제</a>
								</li>
							</ul>
						</div>
						<hr>
					{{/each}}
			</script>
<script>
   // 토큰
	var token = $("#_csrf").attr("value");
	var header = $("#_csrf_header").attr("value");
	
	// 파라미터 얻어오기
	var getParameters = function(paramName) {
		var returnValue;
		var url = location.href;
		var parameters = (url.slice(url.indexOf('?') + 1, url.length))
				.split('&');
		for (var i = 0; i < parameters.length; i++) {
			var varName = parameters[i].split('=')[0];   
			if (varName.toUpperCase() == paramName.toUpperCase()) {
				returnValue = parameters[i].split('=')[1];
				return decodeURIComponent(returnValue);
			}
		}
	};
	
  // 핸들바(board)
	function makeList(result) {
		var source = $("#list-template").html();
		var template = Handlebars.compile(source);
		var html = template(result);
		$("#listTable").html(html);
		if(result.length == 0){
			$("#emptyComment").html("&#187  관리중인 계정이 없습니다.");
		}else{
			$("#deleteChkBtn").show();
		}
		makeUpList(result);
	}
	function makeUpList(result) {
		for(var i = 0; i < result.length; i++){
			var img = $("#img"+i);
			websiteTypeUp = $("#websiteTypeUp"+i);
			var website = $("span[name='website" + i + "']");
			var websitePw = $("span[name='websitePw" + i + "']");
		    var websitePwVal = $("input[name='websitePw" + i + "']");
		    var findId = $("a[name='findId" + i + "']");
		    var findPw = $("a[name='findPw" + i + "']");
		    var imgTag = $("#imgTag" + i);
		   
		    switch(result[i].website){
	          case '11st' : 
	        	 img.attr("src", "/resources/img/11st.gif");
	        	 imgTag.attr("href", "http://www.11st.co.kr");
	        	 
				 findId.attr("href", "https://www.11st.co.kr/register/searchIDForm.tmall");
	        	 findPw.attr("href", "https://www.11st.co.kr/register/searchPWDForm.tmall");

	        	 websiteTypeUp.val('11st').attr("selected", "selected");
	             break;
	           case 'gmarket' :
	        	  img.attr("src", "/resources/img/gmarket.gif");
		          imgTag.attr("href", "http://www.gmarket.co.kr/");

		          findId.attr("href", "https://member.gmarket.co.kr/challenge/neo_member/find_id.asp");
	        	  findPw.attr("href", "https://member.gmarket.co.kr/challenge/neo_member/find_password.asp");
	        	  
	        	  websiteTypeUp.val('gmarket').attr("selected", "selected"); 
	              break;
	           case 'auction' : 
		           imgTag.attr("href", "http://www.auction.co.kr");
	        	   img.attr("src", "/resources/img/auction.gif");

	        	   findId.attr("href", "https://memberssl.auction.co.kr/membership/IDPW/FindID.aspx?url=http://www.auction.co.kr/?redirect=1");
	        	   findPw.attr("href", "https://memberssl.auction.co.kr/membership/IDPW/ResetPassword.aspx?url=https://memberssl.auction.co.kr/Membership/IDPW/ResetPassword.aspx?url=http://www.auction.co.kr/?redirect=1");
	        	   
	        	   websiteTypeUp.val('auction').attr("selected", "selected"); 
	              break;
	           case 'interpark' : 
	        	   img.attr("src", "/resources/img/interpark.gif");
		           imgTag.attr("href", "http://www.interpark.co.kr");

		           findId.attr("href", "https://incorp.interpark.com/member/matchid.do?_method=initialPopUp");
	        	   findPw.attr("href", "https://incorp.interpark.com/member/matchpwd.do?_method=initialPopUp");
	        	   
	        	   websiteTypeUp.val('interpark').attr("selected", "selected"); 
	              break;
	       }
			websitePw.val(result[i].websitePw);
			websitePwVal.val(result[i].websitePw);
		}
	}
	function detail() {
		var email = "${user.email}";
		$.ajax({
			url : "/user/makeMasterList",
			data : {
				email : email
			}
		}).done(makeList);
	}
	detail();
   
	// 등록 폼 
	$("#insertForm").on("click", function() {
		$(".input-with-label").show();
		$("#insertForm").hide();
	})
	
	// 등록 취소
	$("a[name='masterCancel']").on("click", function(){
		$(".input-with-label").hide();
		$("#insertForm").show();
	})
	
   

   // 등록
   $("a[name='masterRegist']").on("click", function() {
	   //등록 토큰
	   $(document).ajaxSend(function(e, xhr, options) {
         xhr.setRequestHeader(header, token);
      });
	   
      var email = "${user.email}";
      var websiteType = $("#websiteType option:selected").text();
      var websiteId = $("#masterId").val();
      var websitePw = $("#masterPassword").val();

      if (websiteType == '사이트 입력') {
         alert('사이트 입력할 것');
      } else if (websiteId == '') {
         alert('아이디 입력할 것');
         $("#masterId").focus();
      } else if (websitePw == '') {
         alert('비밀번호 입력할 것');
         $("#masterPassword").focus();
      }else{
    	  $.ajax({
//  				url : "http://192.168.0.36:3003/checkEmail",
				url : "/user/masterInsert",
				type : "post",
				data : {
					email : email,
					website : websiteType,
					websiteId : websiteId,
					websitePw : websitePw
				}
			}).done(function(result) {
// 				alert(result.result);
				alert(result);
				window.location.reload();
			});
      }
   })
   
   // 삭제
  	function deleteSubmit(index) {
      $(document).ajaxSend(function(e, xhr, options) {
         xhr.setRequestHeader(header, token);
      });
      var email = "${user.email}";
      var website = $("span[name='website" + index + "']").text();
      var websiteId = $("span[name='websiteId" + index + "']").text();

      $.ajax({
         url : "masterDelete",
         type : "POST",
         data : {
            email : email,
            website : website,
            websiteId : websiteId
         }
      }).done(function(result) {
         alert(result);
         window.location.reload();
      });
   }
	
   $(document).ajaxStart(function() {
      $("body").waitMe({
         effect : 'win8',
         text : '',
         bg : 'rgba(255,255,255,0.7)',
         color : '#000',
         source : '/resources/img.svg'
      });
   }).ajaxStop(function() {
      $("body").waitMe("hide");
   });
</script>


<%@include file="../include/footer.jsp" %>