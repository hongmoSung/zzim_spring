<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<div class="main-container">
	<section class="image-bg cover overlay page-title page-title-4"  style="height:250px;">
		<div class="background-image-holder">
			<img alt="image" class="background-image" src="/resources/img/qna_back.jpg" style="height:250px;">
		</div>
		<div class="container">	
			<div class="row">
				<div class="col-md-6 col-md-offset-1">
				<h2 class="uppercase mb0" style="font-weight:bolder;">Q & A</h2>
				</div>
				<div class="col-md-4 text-right">
					<ol class="breadcrumb breadcrumb-2">
						<li><a href="${pageContext.request.contextPath}/home">Home</a></li>
						<li><a href="${pageContext.request.contextPath}/board/list">Q & A</a></li>
						<li class="active">Q&A글 수정</li>
					</ol>
				</div>
			</div>
		</div>
	</section>
	<section>
<div class="container">
	<div class="row">
		<div class="input-with-label text-left">
			<span>제목</span>
				<input type='text' name='title' value="${detail.board.bTitle}" /><br>
			<span>내용</span>
				<textarea name='content' rows='5' cols='70' style="resize:none;">${detail.board.bContent}</textarea><br>
		</div>
		<span>
			<c:if test="${user.email == 'comboy5419@naver.com'}">
				<span>공지사항</span>
				<div id="noticeChk" class="checkbox-option">
					<div class="inner">
						<input type= "checkbox" id="notice" name="notice" value="notice" />
					</div>
				</div>
			</c:if>
		</span>
		<span>
			<span >비밀글 </span>
				<div id="secretChk" class="checkbox-option">
					<div class="inner">
						<input type= "checkbox" id="secret" name="secret" value="secret"/>
					</div>
				</div>
		</span>
			<span id="isSecret" style="display:none;">${detail.board.isSecret}</span>
			<span id="isNotice" style="display:none;">${detail.board.isNotice}</span><br>
			<div class="text-center">
				<a type='submit' class="btn btn-sm"> 수정 </a>
				<a name="list" class="btn btn-sm">목록</a>
			</div>
	</div>
</div>
<div style="height:100px;">
</div>
</section>
</div>
<script>


//파라미터 얻어오기
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

	// 수정
		$("a[type='submit']").click(function() {
			var bContent = $("textarea[name=content]").val();
			var bTitle = $("input[name=title]").val();
			var bNo = getParameters('bNo');
			var isNotice = $("#noticeChk").attr("class");
			if(isNotice == "checkbox-option checked"){
				isNotice = 1;
			}else{
				isNotice = 0;
			}
			var isSecret = $("#secretChk").attr("class");
			if(isSecret == "checkbox-option checked"){
				isSecret = 1;
			}else{
				isSecret = 0;
			}
			
			if (bTitle == "" || bContent == "") {
				alert("내용을 입력할 것");
			} else {
				$.ajax({
					url : getContextPath()+"/update",
					data : {
						'bNo' : bNo,
						'bTitle' : bTitle,
						'bContent' : bContent,
						'isNotice' : isNotice,
						'isSecret' : isSecret
					}
				}).done(function(result) {
					alert(result);
					location.href = getContextPath()+"/detail?bNo=" + bNo + "&pageNo=" +  getParameters('pageNo');
					});
			}
		})

		$("a[name='list']").click(function () {
			var sName = getParameters('searchName');
			var pageNo = getParameters('pageNo');
			if(sName != undefined){
				location.href = getContextPath()+"/list?pageNo=" + pageNo + "&searchName=" + sName;
			}
			else {
				location.href = getContextPath()+"/list?pageNo=" + pageNo;
			}
		});
		
		function hiddenChk() {
			var isSecret = $("#isSecret").text();
			var isNotice = $("#isNotice").text();
			if(isSecret == 1){
				$("#secretChk").attr("class", "checkbox-option checked");
				$("input #secret").attr("checked", true);
			}
			if(isNotice == 1){
				$("#noticeChk").attr("class", "checkbox-option checked");
				$("input #notice").attr("checked", true);
			}
		}
		hiddenChk();
		
</script>
<%@include file="../include/footer.jsp"%>