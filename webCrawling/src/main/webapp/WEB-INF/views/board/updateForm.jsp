<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../include/header.jsp"%>
<section>
			
					<label>제목</label>
					<input type='text' name='title' value="${detail.board.bTitle}" /><br>
					<label>내용</label>
					<textarea name='content' rows='5' cols='70' >${detail.board.bContent}</textarea><br>
			
			<c:if test="${user.email == 'comboy5419@naver.com'}">
				<input type= "checkbox" id="notice" name="notice" value="notice" /> <label for="notice">공지사항</label>
			</c:if>
			<input type= "checkbox" id="secret" name="secret" value="secret"/> <label for="secret">비밀글</label>
			
			<span id="isSecret" style="display:none;">${detail.board.isSecret}</span>
			<span id="isNotice" style="display:none;">${detail.board.isNotice}</span><br>
			<button type='submit'> 수정 </button>
			<button name="list">목록</button>
</section>
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
		$("button[type='submit']").click(function() {
			var bContent = $("textarea[name=content]").val();
			var bTitle = $("input[name=title]").val();
			var bNo = getParameters('bNo');
			var isNotice = $("#notice").prop("checked");
			if(isNotice){
				isNotice = 1;
			}else{
				isNotice = 0;
			}
			var isSecret = $("#secret").prop("checked");
			if(isSecret){
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
		
		function hiddenChk() {
			var isSecret = $("#isSecret").text();
			var isNotice = $("#isNotice").text();
			if(isSecret == 1){
				$("#secret").attr("checked", true);
			}
			if(isNotice == 1){
				$("#notice").attr("checked", true);
			}
		}
		hiddenChk();
		
</script>
<%@include file="../include/footer.jsp"%>