<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../include/header.jsp"%>
<section>
	
	<!-- 본문 -->
	<div>
		
		<!-- 검색/조회 -->
		<div>
			<input type="text" id="searchName"/>
			<button id="searchBtn">검색</button>
			<button id="myQnA" style="float:right;">나의 문의내역</button>
		</div>
		
		<div> 
			전체<c:out value="${bCount}"/>개
			<button id="writeBtn" type="button">문의하기</button>
		</div><hr>
		
		<!-- 게시글 -->	
		<div>
			<table style="width:80%; margin:auto;">
				<thead>
					<tr>
						<th>   </th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>등록일</th>
						<th>조회수</th>
						<th>답변</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="board">
						<tr>
							<c:choose>
								<c:when test="${board.isNotice == 0}">
									<td >&nbsp&nbsp&#42&nbsp&nbsp</td>
								</c:when>
								<c:when test="${board.isNotice == 1}">
									<td>&#62공지&#60</td>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${board.isSecret == 1 and user.email != 'comboy5419@naver.com' and user.email != board.email}">
									<td name="secret"><a style="cursor:pointer;">비밀글 입니다</a></td>
								</c:when>
								<c:otherwise>
									<td><a href="${pageContext.request.contextPath}/board/detail?bNo=${board.bNo}&pageNo=${pageResult.pageNo}" style="cursor:pointer;">${board.bTitle}</a></td>
								</c:otherwise>
							</c:choose>
							<td>${board.email}</td>
							<td><fmt:formatDate value="${board.bRegDate}" pattern="yy/MM/dd" /></td>
							<td>&nbsp&nbsp${board.bHit}</td>
							<td>${board.bReply}</td>
						</tr>
					</c:forEach>
					<c:if test="${bCount eq 0}">
						<tr>
							<td colspan='5'> &#187  검색된 게시글이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		
		
		<!-- 페이징 -->
		<div>
			<c:if test="${pageResult.bCount != 0}">
				<nav>
				<ul class="pagination" style="width:80%;">
					<li class="<c:if test="${pageResult.prev eq false}">disabled</c:if>">
		   			   <a href="<c:if test="${pageResult.prev eq true}">list?pageNo=1</c:if>" aria-label="Previous">
		      			  <span aria-hidden="true">&laquo;</span>
		   			   </a>
		  		  </li>
					<li class="<c:if test="${pageResult.prev eq false}">disabled</c:if>">
						<a href="<c:if test="${pageResult.prev eq true}">javascript:goPage(${pageResult.beginPage - 1})</c:if>"aria-label="Previous">
						 <span aria-hidden="true">&laquo;</span>
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
									<span aria-hidden="true">&raquo;</span>
						</a>
					</li>
					<li class="<c:if test="${pageResult.next eq false}">disabled</c:if>">
				      <a href="<c:if test="${pageResult.next eq true}">list?pageNo=${pageResult.lastPage}</c:if>" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>	
				</ul>
				</nav>
			</c:if>
		</div>
	</div>
</section>

	<script type="text/javascript">
	
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
		
		searchRemain();
		function searchRemain() {
			var sName = getParameters('searchName');
			$("#searchName").val(sName);
			console.log(sName);
		}
		
		// 나의 문의
		$("#myQnA").click(function() {
			location.href =getContextPath()+"/board/list?email=${user}";
			return false;
		});
		
		// 비밀글 클릭
		$("td[name='secret']").click(function() {
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