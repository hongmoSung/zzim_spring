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
			<div id="deleteChkBtn" style="display:none;">
               <h5 style="display:inline;"><span style="position:relative; top:-10px;">전체&nbsp<input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();" /></span></h5>
               <a type="button" name="deleteMaster" id="deleteMaster" class="btn btn-sm" style="margin-left:15px;">선택항목 삭제</a>
			</div>
         </div>
         <hr>
         
         <div class="col-md-10 col-md-offset-1">
            <div class="post-snippet mb64">
				<span id="emptyComment"></span>
            	<div id="listTable"></div>
               
            	<div class="input-with-label" style="width:100%;">
                  <a type="button" name="masterRegist" class="btn btn-sm" style="width:20px; padding:0 15px 0 10px; position:relative; top:10px;">&#43</a>
                  <span  class="select-option" style="display:inline; margin-left:30px;">
                     <i class="ti-angle-down"></i>
                     <select id="websiteType"  style="width:20%; display:inline;">
                        <option value="empty">사이트 입력</option>
                        <option value="11st">11st</option>
                        <option value="gmarket">gmarket</option>
                        <option value="auction">auction</option>
                        <option value="interpark">interpark</option>
                     </select>
                  </span>
                  <h5 style="display:inline;  margin:0 10px 0 15px;""><span style="display:inline;"></span></h5>
             	  <input type="text" name="masterId" id="masterId" style="width:25%;" placeholder="아이디">
                  
                  <h5 style="display:inline;  margin:0 10px 0 15px;""><span style="display:inline;"></span></h5>
                  <input type="password" name="masterPassword" id="masterPassword" style="width:25%;"  placeholder="비밀번호">
               </div>
            </div>
         </div>
      </div>
   </div>
</section>
</div>
</body>
			<script id="list-template" type="text/x-handlebars-template">
				{{#each .}}
						<ul class="post-meta" style="width: 250px;">
							<li style="width: 40px; margin-left: 10px;"><input
								type="checkbox" id="checkRow{{@index}}" name="checkRow"
								value="{{email}},{{website}},{{websiteId}}"
								onclick="check();" style="margin-top: 20px;" /></li>

							<li id="first{{@index}}" class="a" style="margin-top: 10px;">
								 <img id="img{{@index}}" src="/resources/img/auction.jpg" style="width:50px; display:inline;">
								&nbsp&nbsp&nbsp&nbsp<span name="website{{@index}}">{{website}}</span>
							</li>
							<li id="website{{@index}}" class="b" style="display:none;">
								<select id="websiteTypeUp{{@index}}" style="width: 100px;">
									<option value="empty{{@index}}" id="empty{{@index}}">선택</option>
									<option value="11st" id="op11st{{@index}}">11st</option>
									<option value="gmarket" id="opGmarket{{@index}}">gmarket</option>
									<option value="auction" id="opAuction{{@index}}">auction</option>
									<option value="interpark" id="opInterpark{{@index}}">interpark</option>
								</select>
							</li>
						</ul>
						<ul class="post-meta" style="width: 150px;">
							<li id="second{{@index}}" class="a">
								<span name="websiteId{{@index}}" style="position: relative; bottom: 5px; line-height: 30px;">{{websiteId}}</span>
							</li>
							<li id="websiteId{{@index}}" class="b" style="display:none;">
								<input type="text" value="{{websiteId}}" name="websiteId{{@index}}">
							</li>
						</ul>
						<ul class="post-meta" style="width: 150px; margin-left: 60px;">
							<li id="third{{@index}}" style="display:none;">
								<span name="websitePw{{@index}}" value="" style="position: relative; bottom: 5px; line-height: 30px;"></span>
							</li>
							<li id="websitePw{{@index}}" class="b" style="display:none;">
								<input type="text" value="" name="websitePw{{@index}}">
							</li>
						</ul>
						<ul class="post-meta" style="float: right; margin-right: -80px;">
							<li id="updateMaster{{@index}}" class="a">
								<a type="button" class="updateBtn btn btn-sm" name="updateMaster{{@index}}" data-no="{{@index}}" onclick="updateForm({{@index}});" style="margin-top: 10px;">편집</a></li>
							<li id="updateGo{{@index}}" class="b" style="position: relative; margin-top: 10px; display: none;">
								<a type="button" onclick="updateSubmit({{@index}});" class="btn btn-sm">수정</a>
								<a type="button" onclick="updateCancel({{@index}});" class="btn btn-sm">취소</a>
							</li>
						</ul>
						<hr>
						<br>
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
			var website = $("span[name='website" + i + "']");
			var websitePw = $("span[name='websitePw" + i + "']");
		    var websitePwVal = $("input[name='websitePw" + i + "']");
		   
		    switch(result[i].website){
	          case '11st' : 
	        	 $("#img"+i).attr("src", "/resources/img/11st.jpg");
	             $("#websiteTypeUp"+i).val('11st').attr("selected", "selected");
	             break;
	           case 'gmarket' :
	        	   $("#img"+i).attr("src", "/resources/img/gmarket.jpg");
	              $("#websiteTypeUp"+i).val('gmarket').attr("selected", "selected"); 
	              break;
	           case 'auction' : 
	        	   $("#img"+i).attr("src", "/resources/img/auction.jpg");
	              $("#websiteTypeUp"+i).val('auction').attr("selected", "selected"); 
	              break;
	           case 'interpark' : 
	        	   $("#img"+i).attr("src", "/resources/img/interpark.jpg");
	              $("#websiteTypeUp"+i).val('interpark').attr("selected", "selected"); 
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
   // 전체 체크/해제
   function checkAll() {
      var param = $("#th_checkAll").is(":checked");
      var arrcheck = document.getElementsByName("checkRow");
      for (i = 0; i < arrcheck.length; i++) {
         arrcheck.item(i).checked = param;
      }
   }
   
   // 개별 체크시 전체 체크 해제
   function check(){
      var chk = $("#th_checkAll").is(":checked");
      var arrcheck = document.getElementsByName("checkRow");
      var j = 0;
      if(chk){
         $("#th_checkAll").attr("checked", false);
      }
      for (i = 0; i < arrcheck.length; i++) {
         if(arrcheck.item(i).checked) {
            j++;
            if(j == arrcheck.length){
               $("#th_checkAll").attr("checked", true);
            }
         }
      }
   }
   
   // 삭제
   $("#deleteMaster").on("click", function() {
      $(document).ajaxSend(function(e, xhr, options) {
         xhr.setRequestHeader(header, token);
      });
      var chk = document.getElementsByName("checkRow");
      var len = chk.length;
      var checkRow = '';
      var valueArray = new Array();

      for (var i = 0; i < len; i++) {
         if (chk[i].checked == true) {
            checkRow = chk[i].value;
            valueArray.push(checkRow);
         }
      }
      $.ajaxSettings.traditional = true; // 배열로 controller에 주기 위해
      $.ajax({
         url : "masterDelete",
         type : "POST",
         data : {
            'valueArray' : valueArray,
         }
      }).done(function(result) {
         alert("삭제 완료");
         window.location.reload();
      });
   })

   // 등록
   $("a[name='masterRegist']").on("click", function() {
	   //등록 토큰
	   $(document).ajaxSend(function(e, xhr, options) {
           xhr.setRequestHeader(header, token);
        });
	   
      var email = "${user.email}";
      var websiteId = $("#masterId").val();
      var websitePw = $("#masterPassword").val();
      var websiteType = $("#websiteType option:selected").text();

      if (websiteType == '선택') {
         alert('사이트 입력할 것');
      } else if (websiteId == '') {
         alert('아이디 입력할 것');
         $("#masterId").focus();
      } else if (websitePw == '') {
         alert('비밀번호 입력할 것');
         $("#masterPassword").focus();
         
      }else{
    	  $.ajax({
// 				url : "http://192.168.0.36:3003/checkEmail",
				url : "/user/masterInsert",
				type : "post",
				data : {
					email : email,
					website : websiteType,
					websiteId : websiteId,
					websitePw : websitePw
				}
			}).done(function(result) {
				alert(result.result);
				window.location.reload();
			});
      }
   })

   // 편집
  function updateForm(index) {
	   console.log(index);
	  var email = "${user.email}";
      var website = $("span[name='website" + index + "']");
      var websitePw = $("span[name='websitePw" + index + "']");
      var websitePwVal = $("input[name='websitePw" + index + "']");
      
      console.log("websitePw : " + websitePw.val());
      console.log("websitePwVal : " + websitePwVal.val());
      
      // 편집 폼 중복 방지
      var a = $(".a");
      var b = $(".b");
      a.show();
      b.hide();
        switch(website){
           case '11st' : $("#op11st"+index).attr("selected", "selected"); break;
           case 'gmarket' : $("#opGmarket"+index).attr("selected", "selected"); break;
           case 'auction' : $("#opAuction"+index).attr("selected", "selected"); break;
           case 'interpark' : $("#opInterpark"+index).attr("selected", "selected"); break;
        }

      // 컨텐트 숨기기
      $("#first" + index).hide();
      $("#second" + index).hide();
      $("#third" + index).hide();
      // 편집 버튼 숨기기
      $("#updateMaster" + index).hide();
      // 입력 창 보이기
      $("#website" + index).show();
      $("#websiteId" + index).show();
      $("#websitePw" + index).show();
      // 수정 버튼 보이기
      $("#updateGo" + index).show();
   }
// 수정
 function updateSubmit(index) {
         $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
         });
         var email = "${user.email}";
         var website = $("span[name='website" + index + "']").text();
         var websiteId = $("span[name='websiteId" + index + "']")
               .text();
         var websitePw = $("span[name='websitePw" + index + "']")
               .text();
         var reWebsite = $(
               "#websiteTypeUp" + index + " option:selected").text();
         var reWebsiteId = $("input[name='websiteId" + index + "']")
               .val();
         var reWebsitePw = $("input[name='websitePw" + index + "']")
               .val();
         $.ajax({
            url : "masterUpdate",
            type : "POST",
            data : {
               email : email,
               website : website,
               websiteId : websiteId,
               websitePw : websitePw,
               reWebsite : reWebsite,
               reWebsiteId : reWebsiteId,
               reWebsitePw : reWebsitePw
            }
         }).done(function(result) {
            alert(result);
            window.location.reload();
         })
      }

   // 수정 취소
  function updateCancel(index) {
         var website = $("span[name='website" + index + "']").text();
         var websiteId = $("span[name='websiteId" + index + "']").text();
         var websitePw = $("span[name='websitePw" + index + "']").val();
         var a = $(".a");
         var b = $(".b");

         // 수정창 입력값 초기화
         $("input[name='websiteId" + index + "']").val(websiteId);
         $("input[name='websitePw" + index + "']").val(websitePw);

         if (website == "11st") {
            $("#op11st" + index).attr("selected", "selected");
         }
         switch (website) {
         case '11st':
            $("#op11st" + index).removeAttr("selected");
            break;
         case 'gmarket':
            $("#opGmarket" + index).removeAttr("selected");
            break;
         case 'auction':
            $("#opAuction" + index).removeAttr("selected");
            break;
         case 'interpark':
            $("#opInterpark" + index).removeAttr("selected");
            break;
         default:
            $("#opEtc" + index).removeAttr("selected");
            break;
         case '11st':
            $("#op11st" + index).removeAttr("selected");
            break;
         }
         switch(website){
          case '11st' : 
             $("#websiteTypeUp"+index).val('11st').attr("selected", "selected");
             break;
           case 'gmarket' : 
              $("#websiteTypeUp"+index).val('gmarket').attr("selected", "selected"); 
              break;
           case 'auction' : 
              $("#websiteTypeUp"+index).val('auction').attr("selected", "selected"); 
              break;
           case 'interpark' : 
              $("#websiteTypeUp"+index).val('interpark').attr("selected", "selected"); 
              break;
       }

         a.show();
         b.hide();
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