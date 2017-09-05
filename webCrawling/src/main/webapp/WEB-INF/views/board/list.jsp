<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<style>
	input[type='text'] {
		background-color: #F0FFF0;
		border:1px solid #DCDCDC;
	}
	i.ti-search {
		cursor:pointer;
		position:relative;
		margin-left:10px;
		top:10px;
		margin-top:40px;
	}
</style>
<body>
<div class="main-container">
	<section class="page-title page-title-4 bg-dark" style="height:150px;">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-1">
				<h3 class="uppercase mb0">Q & A</h3>
				</div>
			</div>
		</div>
	</section>
	<section style="margin-top: -50px;">
		<!-- 게시글 -->	
		<div class="container">
			<div class="text-right"> 
				<a id="writeBtn" class="btn btn-sm" style="width:100px; height:50px; padding: 10px 1px; ">문의글 쓰기</a>
			</div>
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<div class="post-snippet mb64" >
					<c:forEach items="${list}" var="board">
							<div class="post-title" style="width:100%;" style="display:inline;">
<!-- 								<span class="label inline-block">조회수 &nbsp&nbsp${board.bHit}</span> -->
								<c:choose>
									<c:when test="${board.isNotice == 1}">
										<img src="/web/resources/img/notice.png" style="width:25px; display:inline;">
									</c:when>
									<c:otherwise>
										<span style="width:50px;">${board.bNo}&nbsp&nbsp&nbsp&nbsp</span>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${board.isSecret == 1 and user.email != 'comboy5419@naver.com' and user.email != board.email}">
										<img src="/web/resources/img/secret.png" style="width:20px; display:inline;">
										<h5 class="inline-block"><a style="cursor:pointer; color:#C0C0C0; font-weight:lighter;" name="secret">&nbsp비밀글 입니다</a></h5>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${board.isNotice == 1}">
<!-- 												<img src="/web/resources/img/notice.png" style="width:25px; display:inline;"> -->
												<h4 class="inline-block" style="width:40%; display:inline;"><a href="${pageContext.request.contextPath}/board/detail?bNo=${board.bNo}&pageNo=${pageResult.pageNo}" style="cursor:pointer; color:black;"> &nbsp&nbsp ${board.bTitle}</a></h4>
											</c:when>
											<c:otherwise>
												<h4 class="inline-block" style="width:40%; display:inline;"><a href="${pageContext.request.contextPath}/board/detail?bNo=${board.bNo}&pageNo=${pageResult.pageNo}" style="cursor:pointer; color:black; font-weight:bolder; " >${board.bTitle}</a></h4>
											</c:otherwise>									
										</c:choose>
									</c:otherwise>
								</c:choose>
								<ul style="display:inline; float:right; width:10%; position:relative; top:15px;">
									<c:if test="${board.bReply == 1}">
										<li><img src="/web/resources/img/hook.png" style="width:30px; display:inline; position:relative; top:-10px;"></li>
									</c:if>
									<li style="display:inline; width:200px; display:none;"><i class="ti-comment-alt"></i> &nbsp<span>${board.bReply}</span></li>
								</ul>
								<ul style="display:inline; float:right; width:15%; position:relative; top:5px;">
									<li style="display:inline; width:200px;"><i class="ti-tag"></i><span>&nbsp<fmt:formatDate value="${board.bRegDate}" pattern="yy/MM/dd" /></span></li>
								</ul>
								<ul style="display:inline; float:right; width:30%; position:relative; top:5px;">
									<li style="display:inline;  width:200px;""><i class="ti-user"></i><span style="width:100px;">&nbsp ${board.email}</span></li>
								</ul>
							</div>
							<hr>
					</c:forEach>
					<c:if test="${bCount eq 0}">
							<span> &#187  검색된 게시글이 없습니다.</span>
					</c:if>
					</div>
					<div class="search text-center">
						<a id="myQnA" class="btn btn-sm" style="position: relative; top:10px; ">나의 문의내역</a>
						<input type="text" id="searchName" style="width:30%; height:30px;"/>
						<i class="ti-search icon-sm" id="searchBtn" style="height:15px;"></i>
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
					<div style="height:60px;"></div>
				</div>
			</div>
		</div>
	</section>
</div>
</body>
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
			if("{user.email}" == ""){
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