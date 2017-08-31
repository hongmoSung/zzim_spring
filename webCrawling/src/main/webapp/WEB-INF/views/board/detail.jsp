<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<%@include file="../include/header.jsp"%>

<section>
<!-- 전체 -->
<div> 

	<!-- 머리단 -->
	<hr>
	<!-- 본문 -->
	<div>
		<table>
			<thead>
				<tr>
					<th></th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<c:choose>
						<c:when test="${detail.board.isSecret == 1}">
							<td>비밀글</td>
						</c:when>
						<c:when test="${detail.board.isNotice == 1}">
							<td>공지사항</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					
					</c:choose>
					<td>${detail.board.bTitle}</td>
					<td id='writerId'>${detail.board.email}</td>
					<td><fmt:formatDate value="${detail.board.bRegDate}" pattern="yyyy-MM-dd" /></td>
				</tr>
			</tbody>
		</table>
		<br>
		<div>
			<label style="font-weight:bold;">내용</label><br>
			<p>${detail.board.bContent}</p>
		</div>
		<br>
		<div>
			<c:if test="${user.email eq detail.board.email}">
				<button name="update">수정</button>
				<button name="delete">삭제</button>
			</c:if>
			<button name="list">목록</button>
			<hr>
			<div><br>
				<label style="font-weight:bold;">답변</label><br>
				<c:choose>
					<c:when test="${detail.rCount eq 0}">
						<p>답변을 기다려 주세요</p>
						<c:if test="${user.email eq 'comboy5419@naver.com'}">
							<button name="reRegister" style="float:right;">답변 등록</button>
						</c:if>
					</c:when>
					<c:when test="${detail.rCount eq 1}">
						<p id="rNo" style="display:none;">${detail.reply.rNo}</p>
						<p id="reContent" style="display:block;">${detail.reply.rContent}</p>
						<div id='updateReContent' style='display:none;'>
							<textarea rows='5' cols='70' name="reUpContent">${detail.reply.rContent}</textarea>
							<button name="upSubmit">수정</button>
							<button name="canSubmit">취소</button>
						</div>
						<button name="reDelete" style="float:right;">답변 삭제</button>
						<button name="reUpdate" style="float:right;">답변 수정</button>
					</c:when>
				</c:choose>
			</div>
			<br><br>
			<div id="answerForm" style='display:none;'>
				<textarea id='answerText' rows='7' cols='150' style='resize:none;'></textarea><br>
				<button name='answerSubmit'>등록</button>
				<button name='answerCancel'>취소</button>
			</div>
			
		</div>
	</div>
					
</div>
</section>
<script>	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	 
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
	$("button[name='update']").click(function () {
		var pageNo = getParameters('pageNo');
		location.href=getContextPath()+"/board/updateForm?bNo=" + getParameters('bNo') + "&pageNo=" + pageNo;
	});
		
	// 삭제
	$("button[name='delete']").on("click", function () {
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
	$("button[name='list']").click(function () {
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
	$("button[name='reRegister']").click(function () {
		$("#answerForm").show();
	});
	// 입력
	$("button[name='answerSubmit']").click(function(){
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
	 $("button[name='answerCancel']").click(function () {
			$("#answerForm").hide();
		 })
	
	// 수정 폼
	$("button[name='reUpdate']").click(function () {
		$("#reContent").hide();
		$("#updateReContent").show();
	 })
	 
 	// 수정 완료 
 	$("button[name='upSubmit']").click(function () {
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
	 $("button[name='canSubmit']").click(function () {
		$("#reContent").show();
		$("#updateReContent").hide();
	 })
	 
	// 삭제
	 $("button[name='reDelete']").click(function () {
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