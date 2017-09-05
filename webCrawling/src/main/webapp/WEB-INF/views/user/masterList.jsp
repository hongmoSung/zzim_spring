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
            <c:if test="${not empty masterList}">
               <h5 style="display:inline;"><span style="position:relative; top:-10px;">전체&nbsp<input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();" /></span></h5>
               <a type="button" name="deleteMaster" id="deleteMaster" class="btn btn-sm" style="margin-left:15px;">선택항목 삭제</a>
            </c:if>
         </div>
         <hr>
         <div class="col-md-10 col-md-offset-1">
            <div class="post-snippet mb64">
               <c:if test="${empty masterList}">
                     <span>&#187  관리중인 계정이 없습니다.</span>
               </c:if>
               <c:forEach items="${masterList}" var="list" varStatus="status">
                  <div>
                     <ul class="post-meta" style="width:250px;">
                        <li style="width:40px; margin-left:10px;"><input type="checkbox" id="checkRow" name="checkRow" value="${list.email},${list.website},${list.websiteId}" onclick="check();" style="margin-top:20px;" /></li>
                        
                        <li id="first${status.index}" class="a" style="margin-top:10px;">
                           <c:choose>
                              <c:when test="${list.website == 'auction'}">
                                 <img src="/resources/img/auction.jpg" style="width:50px; display:inline;">
                              </c:when>
                              <c:when test="${list.website == '11st'}">
                                 <img src="/resources/img/11st.jpg" style="width:50px; display:inline;">
                              </c:when>
                              <c:when test="${list.website == 'gmarket'}">
                                 <img src="/resources/img/gmarket.jpg" style="width:50px; display:inline;">
                              </c:when>
                              <c:when test="${list.website == 'interpark'}">
                                 <img src="/resources/img/interpark.png" style="width:50px; display:inline;">
                              </c:when>
                              <c:otherwise>
                                 <img src="/resources/img/etc.png" style="height:20px; width:50px; display:inline;">
                              </c:otherwise>
                           </c:choose>
                           &nbsp&nbsp&nbsp&nbsp<span name="website${status.index}">${list.website}</span>
                        </li>
                        <li id="website${status.index}" class="b" style="display:none;">
                           <select id="websiteTypeUp${status.index}" style="width:100px;" >
                                <option value="empty${status.index}" id="empty${status.index}">선택</option>
                                <option value="11st" id="op11st${status.index}">11st</option>
                                <option value="gmarket" id="opGmarket${status.index}">gmarket</option>
                                <option value="auction" id="opAuction${status.index}">auction</option>
                                <option value="interpark" id="opInterpark${status.index}">interpark</option>
                              </select>
                           </li>
                        </ul>
                        <ul class="post-meta" style="width:150px;">
                           <li id="second${status.index}" class="a">
                              <span name="websiteId${status.index}" style="position:relative; bottom:5px; line-height:30px;">${list.websiteId}</span>
                           </li>
                        <li id="websiteId${status.index}" class="b" style="display:none;">
                           <input type="text" value="${list.websiteId}" name="websiteId${status.index}">
                        </li>
                     </ul>
                        <ul class="post-meta" style="width:150px; margin-left:60px;">
                           <li id="third${status.index}" style="display:none;">
                              <span name="websitePw${status.index}" style="position:relative; bottom:5px; line-height:30px;">${list.websitePw}</span>
                           </li>
                           <li id="websitePw${status.index}" class="b" style="display:none;">
                              <input type="password" value="${list.websitePw}" name="websitePw${status.index}">
                        </li>
                     </ul>
                     <ul class="post-meta" style="float:right; margin-right:-80px;">
                        <li id="updateMaster${status.index}" class="a">
                           <a type="button" class="updateBtn btn btn-sm" name="updateMaster${status.index}" data-no="${status.index}" style="margin-top:10px;">편집</a></li>
                        <li id="updateGo${status.index}" class="b" style="position:relative; margin-top:10px; display:none;" >
                           <a type="button" name="updateSubmit" data-no="${status.index}" class="btn btn-sm">수정</a>
                           <a type="button" name="updateCancel" data-no="${status.index}" class="btn btn-sm">취소</a>
                        </li>
                     </ul>
                  </div>
               <hr>
               </c:forEach>
               <div class="input-with-label" style="width:100%;">
                  <a type="button" name="masterRegist" class="btn btn-sm" style="width:20px; padding:0 15px 0 10px; position:relative; top:10px;">&#43</a>
                  <span  class="select-option" style="display:inline; margin-left:30px;">
                     <i class="ti-angle-down"></i>
                     <select id="websiteType"  style="width:20%; display:inline;" >
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

<script>
   // 토큰
   var token = $("#_csrf").attr("value");
   var header = $("#_csrf_header").attr("value");
   
   
   // hide
   window.onload = function(){
      var b = $(".b");
      b.hide();
   }
   
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
				url : "http://192.168.0.36:3003/checkEmail",
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
   $(".updateBtn").on("click", function() {
      
      var dataNo = $(this).attr('data-no');
      var website = $("span[name='website" + dataNo + "']").text();
      // 편집 폼 중복 방지
      var a = $(".a");
      var b = $(".b");
      a.show();
      b.hide();
        switch(website){
           case '11st' : $("#op11st"+dataNo).attr("selected", "selected"); break;
           case 'gmarket' : $("#opGmarket"+dataNo).attr("selected", "selected"); break;
           case 'auction' : $("#opAuction"+dataNo).attr("selected", "selected"); break;
           case 'interpark' : $("#opInterpark"+dataNo).attr("selected", "selected"); break;
        }

      // 컨텐트 숨기기
      $("#first" + dataNo).hide();
      $("#second" + dataNo).hide();
      $("#third" + dataNo).hide();
      // 편집 버튼 숨기기
      $("#updateMaster" + dataNo).hide();
      // 입력 창 보이기
      $("#website" + dataNo).show();
      $("#websiteId" + dataNo).show();
      $("#websitePw" + dataNo).show();
      // 수정 버튼 보이기
      $("#updateGo" + dataNo).show();
   })

   // 수정
   $("a[name='updateSubmit']").on("click",function() {
         $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
         });
         var dataNo = $(this).attr('data-no');
         var email = "${user.email}";
         var website = $("span[name='website" + dataNo + "']").text();
         var websiteId = $("span[name='websiteId" + dataNo + "']")
               .text();
         var websitePw = $("span[name='websitePw" + dataNo + "']")
               .text();
         var reWebsite = $(
               "#websiteTypeUp" + dataNo + " option:selected").text();
         var reWebsiteId = $("input[name='websiteId" + dataNo + "']")
               .val();
         var reWebsitePw = $("input[name='websitePw" + dataNo + "']")
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
      })

   // 수정 취소
   $("a[name='updateCancel']").on("click",function() {
         var dataNo = $(this).attr('data-no');
         var website = $("span[name='website" + dataNo + "']").text();
         var websiteId = $("span[name='websiteId" + dataNo + "']")
               .text();
         var websitePw = $("span[name='websitePw" + dataNo + "']")
               .text();
         var a = $(".a");
         var b = $(".b");

         // 수정창 입력값 초기화
         $("input[name='websiteId" + dataNo + "']").val(websiteId);
         $("input[name='websitePw" + dataNo + "']").val(websitePw);
         if (website == "11st") {
            $("#op11st" + dataNo).attr("selected", "selected");
         }
         switch (website) {
         case '11st':
            $("#op11st" + dataNo).removeAttr("selected");
            break;
         case 'gmarket':
            $("#opGmarket" + dataNo).removeAttr("selected");
            break;
         case 'auction':
            $("#opAuction" + dataNo).removeAttr("selected");
            break;
         case 'interpark':
            $("#opInterpark" + dataNo).removeAttr("selected");
            break;
         default:
            $("#opEtc" + dataNo).removeAttr("selected");
            break;
         case '11st':
            $("#op11st" + dataNo).removeAttr("selected");
            break;
         }
         switch(website){
          case '11st' : 
             $("#websiteTypeUp"+dataNo).val('11st').attr("selected", "selected");
             break;
           case 'gmarket' : 
              $("#websiteTypeUp"+dataNo).val('gmarket').attr("selected", "selected"); 
              break;
           case 'auction' : 
              $("#websiteTypeUp"+dataNo).val('auction').attr("selected", "selected"); 
              break;
           case 'interpark' : 
              $("#websiteTypeUp"+dataNo).val('interpark').attr("selected", "selected"); 
              break;
       }

         a.show();
         b.hide();
      })
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