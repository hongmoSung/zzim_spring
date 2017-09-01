<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../include/header.jsp"%>
<div class="main-container">
	<section class="page-title page-title-4 bg-secondary">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-5">
					<h3 class="uppercase mb0"> 문의 글 수정</h3>
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
					url : getContextPath()+"/board/update",
					data : {
						'bNo' : bNo,
						'bTitle' : bTitle,
						'bContent' : bContent,
						'isNotice' : isNotice,
						'isSecret' : isSecret
					}
				}).done(function(result) {
					alert(result);
					location.href = getContextPath()+"/board/detail?bNo=" + bNo + "&pageNo=" +  getParameters('pageNo');
					});
			}
		})

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
		
		function hiddenChk() {
			var isSecret = $("#isSecret").text();
			var isNotice = $("#isNotice").text();
			if(isSecret == 1){
				console.log(isSecret);
				console.log($("#secretChk").attr("class"));
				$("#secretChk").attr("class", "checkbox-option checked");
				console.log($("#secretChk").attr("class"));
				$("input #secret").attr("checked", true);
			}
			if(isNotice == 1){
				console.log(isNotice);
				$("#noticeChk").attr("class", "checkbox-option checked");
				$("input #notice").attr("checked", true);
			}
		}
		hiddenChk();
		
</script>
<%@include file="../include/footer.jsp"%>