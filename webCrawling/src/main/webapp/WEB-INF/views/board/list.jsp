<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@include file="../include/header.jsp"%>
<div class="main-container">
	<section class="page-title page-title-4 bg-secondary">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-5">
					<h3 class="uppercase mb0"> Q & A</h3>
				</div>
			</div>
		</div>
	</section>
	<section>
		<div class="search text-center">
			<input type="text" id="searchName" style="width:400px; "/>
			<i class="ti-search icon-sm" id="searchBtn" style="cursor:pointer;"></i>
		</div>
		<div class="text-center"> 
			<a id="writeBtn" class="btn btn-sm">문의글 쓰기</a>
			<a id="myQnA" class="btn btn-sm">나의 문의내역</a>
		</div><hr>
		<!-- 게시글 -->	
		<div class="container">
			<span style="float:right;">전체 <c:out value="${bCount}"/>개</span>
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<div class="post-snippet mb64">
					<c:forEach items="${list}" var="board">
							<c:choose>
								<c:when test="${board.isNotice == 1}">
									<span>&#62공지&#60</span>
								</c:when>
							</c:choose>
							<div class="post-title">
								<span class="label">조회수 &nbsp&nbsp${board.bHit}</span>
								<c:choose>
									<c:when test="${board.isSecret == 1 and user.email != 'comboy5419@naver.com' and user.email != board.email}">
										<a style="cursor:pointer;" name="secret"><h4 class="inline-block">비밀글 입니다</h4></a>
									</c:when>
									<c:otherwise>
										<a href="${pageContext.request.contextPath}/board/detail?bNo=${board.bNo}&pageNo=${pageResult.pageNo}" style="cursor:pointer;"><h4 class="inline-block">${board.bTitle}</h4></a>
									</c:otherwise>
								</c:choose>
							</div>
							<ul class="post-meta">
								<li><i class="ti-user"></i><span>작성자&nbsp<span> ${board.email}</span></span></li>
								<li><i class="ti-tag"></i><span>작성일<span> <fmt:formatDate value="${board.bRegDate}" pattern="yy/MM/dd" /></span></span></li>
								<li><i class="ti-comment-alt"></i><span>답글 여부<span>${board.bReply}</span></span></li>
							</ul>
							<hr>
					</c:forEach>
					<c:if test="${bCount eq 0}">
							<span> &#187  검색된 게시글이 없습니다.</span>
					</c:if>
					</div>
		
		<!-- 페이징 -->
		<div class="text-center">
			<c:if test="${pageResult.bCount != 0}">
				<ul class="pagination">
					<li class="<c:if test="${pageResult.prev eq false}">disabled</c:if>">
		   			   <a href="<c:if test="${pageResult.prev eq true}">list?pageNo=1</c:if>" aria-label="Previous">
		      			  <span aria-hidden="true">««</span>
		   			   </a>
		  		 	</li>
					<li class="<c:if test="${pageResult.prev eq false}">disabled</c:if>">
						<a href="<c:if test="${pageResult.prev eq true}">javascript:goPage(${pageResult.beginPage - 1})</c:if>"aria-label="Previous">
						 <span aria-hidden="true">«</span>
					</a>
					</li>
		
					<c:forEach var="i" begin="${pageResult.beginPage}" end="${pageResult.endPage}">
						<c:choose>
							<c:when test="${pageResult.pageNo eq i}">
								<li class="active"><a href="#1">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="javascript:goPage(${i})">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
		
					<li class="<c:if test="${pageResult.next eq false}">disabled</c:if>">
						<a href="<c:if test="${pageResult.next eq true}">javascript:goPage(${pageResult.endPage + 1})</c:if> "aria-label="Next"> 
									<span aria-hidden="true">»</span>
						</a>
					</li>
					<li class="<c:if test="${pageResult.next eq false}">disabled</c:if>">
				      <a href="<c:if test="${pageResult.next eq true}">list?pageNo=${pageResult.lastPage}</c:if>" aria-label="Next">
				        <span aria-hidden="true">»»</span>
				      </a>
				    </li>	
				</ul>
			</c:if>
		</div>
		</div>
		</div>
	</div>
	</section>
</div>

	<script>
		// 파라미터 얻기
		var getParameters = function(paramName) {
			var returnValue;
		
			var url = location.href;
		
			var parameters = (url.slice(url.indexOf('?') + 1, url.length))
					.split('&');
			if(!parameters){
				return"";
			}else{
				for (var i = 0; i < parameters.length; i++) {
					var varName = parameters[i].split('=')[0];
					if (varName.toUpperCase() == paramName.toUpperCase()) {
						returnValue = parameters[i].split('=')[1];
						return decodeURIComponent(returnValue);
					}
				}
			}
		};
		
		// 검색
		$("#searchBtn").on("click", function () {
			var sName = $("#searchName").val();
			location.href = getContextPath()+"/board/list?searchName=" + sName;
			return false;
		});
		
		// 검색후 파라미터 남기기
		searchRemain();
		function searchRemain() {
			var sName = getParameters('searchName');
			$("#searchName").val(sName);
		}
		
		// 나의 문의
		$("#myQnA").click(function() {
			location.href =getContextPath()+"/board/list?email=${user.email}";
			return false;
		});
		
		// 비밀글 클릭
		$("a[name='secret']").click(function() {
			if($("#loginId").text() == ""){
				alert("로그인 해주세요");
				location.href = "/board/member/loginForm";
			}else{
				alert("비밀글은 본인만 확인할 수 있습니다.")
			}
		})
		
		
		// 글쓰기
		$("#writeBtn").click(function() {
			var param = getParameters('pageNo'); 
			var sName = getParameters('searchName');
			
			if (param == undefined) {param = 1;}
			if (sName != undefined){
				location.href = getContextPath()+"/board/writeForm?pageNo=" + param + "&searchName=" + sName;
			}else{
				location.href = getContextPath()+"/board/writeForm?pageNo=" + param;
			}
		});
		
		// 페이징
		function goPage(pageNo, text) {
			var sName = getParameters('searchName');
			var email = getParameters('email');
			if(sName == undefined) {sName = "";}
			if(email != undefined){
				location.href = "list?pageNo=" + pageNo + "&email=" + email;
			}else{
				location.href = "list?pageNo=" + pageNo + "&searchName=" + sName;
			}
		}

	</script>	
<%@include file="../include/footer.jsp"%>