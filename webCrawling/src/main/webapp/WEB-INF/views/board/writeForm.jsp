<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../include/header.jsp" %>
<section>

	<div>
		<label>제목 :</label> <input type='text' name='title' /><br>
		<br> <label>내용 :</label> <br>
		<textarea name='content' rows='5' cols='70'></textarea>
		<br>
		 아이디 : ${user.email}
		<c:if test="${user.email == 'comboy5419@naver.com'}">
			<input type="checkbox" id="notice" name="notice" value="notice" />
			<label for="notice">공지사항 등록</label>
		</c:if>
		<input type="checkbox" id="secret" name="secret" value="secret" /> 
		<label for="secret">비밀글 등록</label>
		<div>
			<button type='submit'>등록</button>
			<button name="list">목록</button>
		</div>
	</div>
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

	$("button[type='submit']").click(function() {
		
		var bContent = $("textarea[name=content]").val();
		var bTitle = $("input[name=title]").val();

		//공지사항
		var isNotice = $("#notice").prop("checked");
		if (isNotice) {
			isNotice = 1;
		} else {
			isNotice = 0;
		}
		var isSecret = $("#secret").prop("checked");
		if (isSecret) {
			isSecret = 1;
		} else {
			isSecret = 0;
		}
		// 작성자
		var email = "${user.email}";
		console.log(email);
		var param = getParameters('pageNo')
		if (bTitle == "" || bContent == "") {
			alert("내용 입력 할 것");
		} else {
			$.ajax({
				url : getContextPath()+"/board/write",
				data : {
					"bTitle" : bTitle,
					"bContent" : bContent,
					"email" : email,
					"isNotice" : isNotice,
					"isSecret" : isSecret
				}
			}).done(function(result) {
				alert(result);
				location.href = getContextPath()+"/board/list?pageNo=" + param;
			});
		}
	})

	// 목록
	$("button[name='list']").click(
			function() {
				var sName = getParameters('searchName');
				var pageNo = getParameters('pageNo');
				if (sName != undefined) {
					location.href = getContextPath()+"/board/list?pageNo=" + pageNo
							+ "&searchName=" + sName;
				} else {
					location.href = getContextPath()+"/board/list?pageNo=" + pageNo;
				}
			});
</script>


<%@include file="../include/footer.jsp" %>

