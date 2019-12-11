<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>인덱스를 만들어 보자</title>

    <link href="${pageContext.request.contextPath }/resources/css/bootstrap.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!--개인 디자인 추가-->
    <link href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
	
	
</head>
<body>

	<%@ include file="../include/header.jsp" %>
   	<!--게시판-->
    <section>
        <div class="container">
            <div class="row">
                <!--lg에서 9그리드, xs에서 전체그리드-->   
                <div class="col-lg-9 col-xs-12 board-table">
                    <div class="titlebox">
                        <p>자유게시판</p>
                    </div>
                    <hr>
                    
                    <!--form select를 가져온다 -->
					<form action="freeList" method="get" name="searchForm" id="searchForm">
						<div class="search-wrap">
							<span>총 ${pageVO.total}</span>
							<button type="button" class="btn btn-info search-btn" id="searchBtn">검색</button>
							<input type="text" class="form-control search-input" name="searchName" value="${pageVO.cri.searchName }">
							<select class="form-control search-select" name="searchType">
								<option value="title"  ${pageVO.cri.searchType eq 'title' ? 'selected' : '' }>제목</option>
								<option value="content" ${pageVO.cri.searchType eq 'content' ? 'selected' : '' }>내용</option>
								<option value="writer" ${pageVO.cri.searchType eq 'writer' ? 'selected' : '' }>작성자</option>
								<option value="titcont" ${pageVO.cri.searchType eq 'titcont' ? 'selected' : '' }>제목+내용</option>
							</select>
						</div>
						<!-- 검색 클릭시 pageNum을 1부터 시작하게 처리  -->
						<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="amount" value="${pageVO.amount }">
					</form>
                   
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th class="board-title">제목</th>
                                <th>작성자</th>
                                <th>등록일</th>
                                <th>수정일</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="vo" items="${boardList }">
                            <tr>
                                <td>${vo.bno }</td>
                                <td><a href="freeDetail?bno=${vo.bno }">${vo.title }</a></td>
                                <td>${vo.writer }</td>
                                <td><fmt:formatDate value="${vo.regdate }" pattern="yyyy년MM월dd일  ahh:mm"/></td>
                                <td><fmt:formatDate value="${vo.updatedate }" pattern="yyyy년MM월dd일 ahh:mm"/></td>
                            </tr>
                         	</c:forEach>
                        </tbody>
                        
                    </table>

	                    <!--페이지 네이션을 가져옴-->
					    <form action="freeList" name="pageForm" id="pageForm">
			                    <div class="text-center">
			                    <hr>
		 						<ul class="pagination pagination-sm">
			                    	<c:if test="${pageVO.prev }">
				                        <li><a href="${pageVO.startPage-1 }" onclick="page(${pageVO.startPage-1})">이전</a></li>
			                        </c:if>
			                        <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
			            	            <li  class="${num==pageVO.pageNum ? 'active' : '' }"><a href="${num }" onclick="page(${num})">${num}</a></li>
			                        </c:forEach>
			                        <c:if test="${pageVO.next }">
			                       		<li><a href="${pageVO.endPage+1 }" onclick="page(${pageVO.endPage+1})" >다음</a></li>
			                        </c:if>
			                    </ul>
			                    <input type="hidden" name="pageNum" id="pageNum" value="${pageVO.cri.pageNum }">
			                    <input type="hidden" name="amount" id="amount" value="${pageVO.cri.amount }">
			                    <input type="hidden" name="searchType" id="searchType" value="${pageVO.cri.searchType }">
			                    <input type="hidden" name="searchName" id="searchName" value="${pageVO.cri.searchName }">
			                    
			                    <button type="button" class="btn btn-info" id="freeRegist">글쓰기</button>
			                    </div>
					    </form>
			                    <%-- <ul class="pagination pagination-sm">
			                    	<c:if test="${pageVO.prev }">
				                        <li><a href="freeList?pageNum=${pageVO.startPage-1 }">이전</a></li>
			                        </c:if>
			                        <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
			            	            <li  class="${num==pageVO.pageNum ? 'active' : '' }"><a href="freeList?pageNum=${num }">${num}</a></li>
			                        </c:forEach>
			                        <c:if test="${pageVO.next }">
			                       		<li><a href="freeList?pageNum=${pageVO.endPage+1 }">다음</a></li>
			                        </c:if>
			                   		</ul> 
								--%>
                </div>
            </div>
        </div>
	</section>
</body>
<%@ include file="../include/footer.jsp" %>

<script>
	//window.onload : 창 로딩 시 실행되는 스크립트 함수
	//컨트롤러에서 전달 된 msg를 받아옴. 공백이 아니라면 msg를 경고창으로 출력
	window.onload = function(){
		//뒤로가기 실행 후에 앞으로 가기 했을 때 변경된 기록이 공백이라면 함수 종료
		if(history.state == ''){
			return;
		}
		var msg = '${msg}';
		if(msg != ''){
			alert(msg);
			history.replaceState('',null,null);//현재 히스토리 기록을 변경
		}
	}
	//등록처리
	var freeRegist = document.getElementById("freeRegist");
	freeRegist.onclick = function(){
		location.href = "freeRegist";
	}
	
	//1. search폼, page폼을 2개의 폼으로 분리
	//2. 두 form에서 pageNum, amount, searchType, searchName을 동시에 전송
	//3. page폼을 a태그 -> 폼전송 방식으로 변경
	//4. Criteria에 searchType, searchName추가
	//5. 게시글쿼리, 전체게시글 수 쿼리를 동적 쿼리로 변경
	//6. 검색 후에 검색의 정보를 select박스에 키워드 처리, input태그에 키워드 처리
	//7. 

	//검색처리(버튼 클릭시 폼 전송)
	var searchBtn = document.getElementById("searchBtn");
	searchBtn.onclick = function(){
		
		document.getElementById("searchForm").submit();//폼전송
	}
	//검색처리(페이지 클릭시 폼 전송)
	function page(num){
		event.preventDefault(); //현재 실행되는 이벤트의 실행을 막는 방법
		var pageNum = document.querySelector("#pageForm #pageNum").setAttribute("value",num);//페이지 폼의 pageNum을 변경
		console.log(document.pageForm.pageNum);
		document.getElementById("pageForm").submit();//페이지 폼 전송
	}
	
</script>








</html>

