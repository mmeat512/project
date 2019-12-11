<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <div class="col-xs-12 col-md-9 write-wrap">
                        <div class="titlebox">
                            <p>수정하기</p>
                        </div>
                        
                        <form action="freeUpdate" method="post" name="regForm">
                            <div>
                                <label>DATE</label>
                                <p><fmt:formatDate value="${vo.updatedate }" pattern="yyyy-MM-dd"/></p>
                            </div>   
                            <div class="form-group">
                                <label>번호</label>
                                <input class="form-control" name='bno' value="${vo.bno}" readonly>
                            </div>
                            <div class="form-group">
                                <label>작성자</label>
                                <input class="form-control" name='writer' value="${vo.writer }"readonly>
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <input class="form-control" name='title' value="${vo.title }">
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <textarea class="form-control" rows="10" name='content'>${vo.content }</textarea>
                            </div>
							
                            <button type="button" class="btn btn-dark" id="freeList">목록</button>    
                            <button type="button" class="btn btn-primary" id="freeUpdate">변경</button>
                            <button type="button" class="btn btn-info" id="freeDelete">삭제</button>
                    </form>
                                    
                </div>
            </div>
        </div>
        </section>
        
        <%@ include file="../include/footer.jsp" %>
        <script>
     		//목록이동
        	var freeList = document.getElementById("freeList");
        	freeList.onclick = function(){
        		location.href="freeList"
        	}
        	//변경기능
        	var freeUpdate = document.getElementById("freeUpdate");
        	freeUpdate.onclick = function(){
        		var writer = document.regForm.writer
        		var title = document.regForm.title
        		var content = document.regForm.content	
        		if(writer.value==''){
        			alert("작성자는 필수사항입니다");
        			writer.focus();
        			return;
        		}else if(title.value==''){
        			alert("제목은 필수사항입니다");
        			title.focus();
        			return;
        		}else if(content.value==''){
        			alert("내용은 필수 사항입니다");
        			content.focus();
        			return;
        		}else if(confirm("수정하시겠습니까?")){
        			document.regForm.submit();//폼전송
        		}
        	}
        	//삭제기능
        	var freeDelete = document.getElementById("freeDelete");
        	freeDelete.onclick = function(){
        		if(confirm("삭제하겠습니까?")){
	        		document.regForm.setAttribute("action","freeDelete");//액션속성을 바꾼다.
	        		document.regForm.submit();//서브밋
        		}
        	}
        </script>
</body>
</html>