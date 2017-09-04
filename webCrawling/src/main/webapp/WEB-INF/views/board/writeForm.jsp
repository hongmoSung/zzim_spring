<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../include/header.jsp" %>
<style>
	input[type='text'], textarea {
		background-color: #F0FFF0;
		border: 1px solid #DCDCDC;
	}
</style>
<div class="main-container">
	<section class="page-title page-title-4 bg-dark" style="height:150px;">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-1">
					<h3 class="uppercase mb0"> Q & A 글쓰기</h3>
				</div>
			</div>
		</div>
	</section>
	<section>
		<div class="container">
			<div class="row">
				<div class="input-with-label text-left" style="width:60%; position:relative; left:250px;">
					<span><h4 style="font-weight: bolder;">제목</h4></span> 
					<input type='text' name='title' /><br>
			
					<span><h4 style="font-weight: bolder;">내용</h4></span>
					<textarea name='content' rows='5' cols='70' style="resize:none;"></textarea>
				</div>
				<div class="text-center">
					<span>
						<c:if test="${user.email == 'comboy5419@naver.com'}">
						<span style="position:relative; top:10px;">공지사항</span>
						<div class="checkbox-option text-left">
							<div class="inner">
								<input type= "checkbox" id="notice" name="notice" value="notice" />
							</div>
						</div>
						</c:if>
					</span>
					<span>
					<span style="position:relative; top:10px;">비밀글 </span>
						<div class="checkbox-option text-left">
							<div class="inner">
								<input type= "checkbox" id="secret" name="secret" value="secret"/>
							</div>
						</div>
					</span>
					<div>
						<a type='submit' class="btn btn-sm">등록</a>
						<a name="list" class="btn btn-sm">목록</a>
					</div>
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

	// 등록
	$("a[type='submit']").click(function() {
		var bContent = $("textarea[name=content]").val();
		var bTitle = $("input[name=title]").val();
		var email = "${user.email}";
		var param = getParameters('pageNo');

		// 공지사항 여부
		var isNotice = $("#notice").prop("checked");
		if (isNotice) {
			isNotice = 1;
		} else {
			isNotice = 0;
		}
		// 비밀글 여부
		var isSecret = $("#secret").prop("checked");
		if (isSecret) {
			isSecret = 1;
		} else {
			isSecret = 0;
		}
		
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
	$("a[name='list']").click(
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

