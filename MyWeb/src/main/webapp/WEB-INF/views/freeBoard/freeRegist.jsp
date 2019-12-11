<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <div class="col-xs-12 content-wrap">
                    <div class="titlebox">
                        <p>자유게시판</p>
                    </div>
                    <form action="registForm" method="post" name="regForm">
	                    <table class="table">
	                        <tbody class="t-control">
	                            <tr>
	                                <td class="t-title">NAME</td>
	                                <td><input class="form-control input-sm" name="writer" value="${sessionScope.user_Id }" readonly></td>
	                            </tr>
	                            <tr>
	                                <td class="t-title" >TITLE</td>
	                                <td><input class="form-control input-sm" name="title"></td>
	                            </tr>
	                            <tr>
	                                <td class="t-title">CONTENT</td>
	                                <td>
	                                <textarea class="form-control" rows="7" id="content" name="content"></textarea>
	                                </td>                 
	                            </tr>
	                        </tbody>
	                    </table>
                    </form>
                    
                    <div class="titlefoot">
                        <button class="btn" id="freeRegist">등록</button>
                        <button class="btn" id="freeList">목록</button>
                    </div>
                </div>
            </div>    
       </div>
    </section>
    
    <%@ include file="../include/footer.jsp" %>
    <script>
    	//목록을 클릭하면 List화면으로 연결
    	var freeList = document.getElementById("freeList");
    	freeList.onclick = function(){
    		location.href = "freeList";
    	}
    	//등록을 클릭하면 작성자, 제목, 내용이 공백인지 확인하고 공백이라면 함수종료, 공백이 아니라면 controller로 전송하는 처리 
    	var freeRegist = document.getElementById("freeRegist");
    	freeRegist.onclick = function(){
    		var writer = document.regForm.writer.value;
    		var title = document.regForm.title.value;
    		var content = document.regForm.content.value;
    		if(writer == ''){
    			alert("작성자를 입력하세요");
    			document.regForm.writer.focus();
    			return;
    		}else if(title == ''){
    			alert("제목을 입력하세요");
    			document.regForm.title.focus();
    			return;
    		}else if(content == ''){
    			alert("내용을 입력하세요");
    			document.regForm.content.focus();
    			return;
    		}else{
    			alert("글을 등록하시겠습니까?")
    			document.regForm.submit();
    		}
    		
    		
    	}
    	
    
    </script>
</body>
</html>