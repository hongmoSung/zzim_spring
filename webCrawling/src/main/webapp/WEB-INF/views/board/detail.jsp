<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<div class="main-container">
	<section class="page-title page-title-4 bg-dark" style="height:150px;">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-1">
					<h3 class="uppercase mb0"> Q & A</h3>
				</div>
			</div>
		</div>
	</section>
	<section>
	<div class="container"> 
		<div class="row">
			<input type="hidden" id="_csrf" value="${_csrf.token}">
			<input type="hidden" id="_csrf_header" value="${_csrf.headerName}">
			<div class="col-sm-10 col-sm-offset-1">
				<div class="post-snippet mb64">
					<div class="post-title">
						<span class="label">${detail.board.bHit}</span>
						<h4 class="inline-block">${detail.board.bTitle}</h4>
					</div>
					<ul class="post-meta">
						<li>
							<i class="ti-user"></i>
						<span id='writerId'>${detail.board.email}</span>
						</li>
						<li>
							<i class="ti-tag"></i>
							<span><fmt:formatDate value="${detail.board.bRegDate}" pattern="yy/MM/dd" /></span>
						</li>
							<c:if test="${detail.board.isNotice == 1}">
								<li><img src="/web/resources/img/notice.png" style="width:25px; display:inline;"></li>
							</c:if>
							<c:if test="${detail.board.isSecret == 1}">
								<li><img src="/web/resources/img/secret.png" style="width:20px; display:inline;"></li>
							</c:if>
					</ul><hr>
					<p class="lead">${detail.board.bContent}</p>
					<div style="float:right;">
						<c:if test="${user.email eq detail.board.email}">
							<a name="update" class="btn btn-sm">수정</a>
							<a name="delete" class="btn btn-sm">삭제</a>
						</c:if>
							<a name="list" class="btn btn-sm">목록</a>
					</div>
				</div>
				<hr>
				<div class="comments">
					<h4 class="uppercase">답변</h4>
					<div class="comment">
						<c:choose>
							<c:when test="${detail.rCount eq 0}">
								<div id="reRegisterBtn">
									<span class="uppercase author">답변을 기다려 주세요</span>
									<c:if test="${user.email eq 'comboy5419@naver.com'}">
										<a name="reRegister" class="btn btn-sm" style="float:right;">답변 등록</a>
									</c:if>
								</div>
							</c:when>
							<c:when test="${detail.rCount eq 1}">
								<p id="rNo" style="display:none;">${detail.reply.rNo}</p>
								<p id="reContent" style="display:block;">${detail.reply.rContent}</p>
								<div id='updateReContent' style='display:none;'>
									<textarea rows='5' cols='70' name="reUpContent">${detail.reply.rContent}</textarea>
									<div style="float:right;">
										<a name="upSubmit" class="btn btn-sm">수정</a>
										<a name="canSubmit" class="btn btn-sm">취소</a>
									</div>
								</div>
								<div id="reContentBtn" style="float:right;">
									<a name="reDelete" class="btn btn-sm">답변 삭제</a>
									<a name="reUpdate" class="btn btn-sm">답변 수정</a>
								</div>
							</c:when>
						</c:choose>
					</div>
				</div>
			<br><br>
			
			<div id="answerForm" style='display:none;'>
				<textarea id='answerText' rows='7' cols='150' style='resize:none;'></textarea><br>
				<div style="float:right;">
					<a name='answerCancel' class="btn btn-sm">취소</a>
					<a name='answerSubmit' class="btn btn-sm">등록</a>
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
	$(function() {
	    $(document).ajaxSend(function(e, xhr, options) {
	        xhr.setRequestHeader(header, token);
	    });
	});

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
		
		
// 게시글
	// 수정
	$("a[name='update']").click(function () {
		var pageNo = getParameters('pageNo');
		location.href=getContextPath()+"/board/updateForm?bNo=" + getParameters('bNo') + "&pageNo=" + pageNo;
	});
		
	// 삭제
	$("a[name='delete']").on("click", function () {
		$.ajax({
			url: getContextPath()+"/board/delete",
			data: {
				"bNo": getParameters('bNo')
			},
		})
		.done(function (result) {
			alert(result);
			location.href=getContextPath()+"/board/list";
		});
	});
		
	// 목록
	$("a[name='list']").click(function () {
		var sName = getParameters('searchName');
		var pageNo = getParameters('pageNo');
		if(sName != undefined){
			location.href = getContextPath()+"/board/list?pageNo=" + pageNo + "&searchName=" + sName;
		}
		else {
			location.href = getContextPath()+"/board/list?pageNo=" + pageNo;
		}
	});
	
// 답변
	// 입력폼
	$("a[name='reRegister']").click(function () {
		$("#answerForm").show();
		$("#reRegisterBtn").hide();
	});
	// 입력
	$("a[name='answerSubmit']").click(function(){
		$.ajax({
			url: getContextPath()+"/board/commentRegist",
			type: "POST",
			data: {
				bNo: getParameters('bNo'),
				rContent: $("#answerText").val(),
				email : $("#writerId").text()
			}
		}).done(function (result){
			alert("답변 등록 완료");
			window.location.reload();
		});
	 });
	// 입력 취소
	 $("a[name='answerCancel']").click(function () {
			$("#answerForm").hide();
			$("#reRegisterBtn").show();
			$("#answerText").val("");
		 })
	
	// 수정 폼
	$("a[name='reUpdate']").click(function () {
		$("#reContent").hide();
		$("#updateReContent").show();
		$("#reContentBtn").hide();
	 })
	 
 	// 수정 완료 
 	$("a[name='upSubmit']").click(function () {
 		var reUpContent = $("textarea[name='reUpContent']").val();
 		var rNo = $("#rNo").text();
		$.ajax({
				url: getContextPath()+"/board/commentUpdate",
				type: "POST", 
				data: {
					bNo : getParameters('bNo'),
					rContent : reUpContent,
					rNo : rNo
		}
		}).done(function (result){
			alert("답변 수정 완료");
			window.location.reload();
		})
	 })
	
	 // 수정 취소
	 $("a[name='canSubmit']").click(function () {
		$("#reContent").show();
		$("#updateReContent").hide();
		$("#reContentBtn").show();
		$("textarea[name='reUpContent']").val("");
	 })
	 
	// 삭제
	 $("a[name='reDelete']").click(function () {
		 var rNo = $("#rNo").text();
		 $.ajax({
			 url:getContextPath()+"/board/commentDelete",
			 data:{
				bNo : getParameters('bNo'),
				rNo : rNo
			 }
		 }).done(function(result){
			alert("답변 삭제");	 
			window.location.reload();
		 })
	 })

</script>
<%@include file="../include/footer.jsp"%>