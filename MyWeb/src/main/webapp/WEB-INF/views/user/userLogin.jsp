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
    <script src="${pageContext.request.contextPath }/resources/js/jquery.js"></script>
    <!--개인 디자인 추가-->
    <link href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
	
</head>
<body>
	
    <%@ include file="../include/header.jsp" %>

    <section>
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-7 col-xs-10 login-form">
                    <div class="titlebox">
                        로그인
                    </div>
                    <form action="loginForm" method="POST" id="regForm" name="regForm">
                        <div class="form-group"><!--사용자클래스선언-->
                            <label for="id">아이디</label>
                            <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디">
                         </div>
                         <div class="form-group"><!--사용자클래스선언-->
                            <label for="id">비밀번호</label>
                            <input type="password" class="form-control" id="userPw" name="userPw" placeholder="비밀번호">
                         </div>
                         <div class="form-group">
                            <button type="button" class="btn btn-info btn-block" id="loginBtn">로그인</button>
                            <button type="button" class="btn btn-primary btn-block" id="joinBtn">회원가입</button>
                         </div>
                    </form>                
                </div>
            </div>
        </div>
    </section>
    <%@ include file="../include/footer.jsp" %>
	<script>
		$(document).ready(function(){
			
			//즉시실행 함수로 함수화
			(function(){
				var msg = '${msg}';
				if(msg != ''){
					alert(msg);
				}
			})();
			
			$("#joinBtn").click(function(){
				location.href="userJoin";
			})
			
		})
		$("#loginBtn").click(function(){
			if($("#userId").val()==''){
				alert("아이디를 입력하세요");
			}else if($("#userPw").val()==''){
				alert("비밀번호를 입력하세요");
			}else{
				document.getElementById("regForm").submit();
			}
		})
		

	
	
	</script>
</body>
</html>