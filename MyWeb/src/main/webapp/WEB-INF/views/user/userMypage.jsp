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
	
	<!-- 제이쿼리 추가(가장먼저 로딩 되어야 하기때문에 첫째줄에 선언) -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery.js"></script>
	
	
    <link href="${pageContext.request.contextPath }/resources/css/bootstrap.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
    <!--개인 디자인 추가-->
    <link href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
	

	
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<section>
        <!--Toggleable / Dynamic Tabs긁어옴-->
        <div class="container">
            <div class="row">
                <div class="col-sm-12 col-md-10 col-lg-9 myInfo">
                    <div class="titlebox">
                        MEMBER INFO                    
                    </div>
                    
                    <ul class="nav nav-tabs tabs-style">
                        <li class="active"><a data-toggle="tab" href="#info">내정보</a></li>
                        <li><a data-toggle="tab" href="#myBoard">내글</a></li>
                        <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="info" class="tab-pane fade in active">
 
                            <p>*표시는 필수 입력 표시입니다</p>
                            <form>
                            <table class="table">
                                <tbody class="m-control">
                                    <tr>
                                        <td class="m-title">*ID</td>
                                        <td><input class="form-control input-sm" value="${userVO.userId }" id="userId" readonly></td>
                                    </tr>
                                    <tr>
                                        <td class="m-title">*이름</td>
                                        <td><input class="form-control input-sm" value="${userVO.userName }" id="userName"></td>
                                    </tr>
                                    <tr>
                                        <td class="m-title">*비밀번호</td>
                                        <td><input type="password" class="form-control input-sm" placeholder="변경할 비밀번호를 입력하세요" id="userPw"></td>
                                    </tr>
                                    <tr>
                                        <td class="m-title">*비밀번호확인</td>
                                        <td><input type="password" class="form-control input-sm" placeholder="변경할 비밀번호를 입력하세요" id="pwCheck"></td>
                                    </tr>
                                    <tr>
                                        <td class="m-title">*E-mail</td>
                                        <td>
                                            <input class="form-control input-sm" value="${userVO.userEmail1 }" id="userEmail1">@
                                            <select class="form-control input-sm sel" id="userEmail2">
                                                <option ${userVO.userEmail2 eq 'naver.com' ? 'selected':'' }>naver.com</option>
                                                <option ${userVO.userEmail2 eq 'gmail.com' ? 'selected':'' }>gmail.com</option>
                                                <option ${userVO.userEmail2 eq 'daum.net' ? 'selected':'' }>daum.net</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="m-title">*휴대폰</td>
                                        <td>
                                            <select class="form-control input-sm sel" id="userPhone1">
                                                <option ${userVO.userPhone1 eq 010 ? 'selected' : '' }>010</option>
                                                <option ${userVO.userPhone1 eq 011 ? 'selected' : '' }>011</option>
                                                <option ${userVO.userPhone1 eq 017 ? 'selected' : '' }>017</option>
                                                <option ${userVO.userPhone1 eq 018 ? 'selected' : '' }>018</option>
                                            </select>
                                            <input class="form-control input-sm" value="${userVO.userPhone2 }" id="userPhone2">	
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="m-title">*우편번호</td>
                                        <td><input class="form-control input-sm" id="addrZipNum" value ="${userVO.addrZipNum }" readonly>
                                        	<button type="button" class="btn btn-primary" id="addBtn">주소찾기</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="m-title">*주소</td>
                                        <td><input class="form-control input-sm add" id="addrBasic" value="${userVO.addrBasic }"></td>
                                    </tr>
                                    <tr>
                                        <td class="m-title">*상세주소</td>
                                        <td><input class="form-control input-sm add" id="addrDetail" value="${userVO.addrDetail }"></td>
                                    </tr>
                                </tbody>
                            </table>
                            </form>

                            <div class="titlefoot">
                                <button class="btn" id="updateBtn">수정</button>
                                <!-- <button class="btn" id="">목록</button> -->
                            </div>
                        </div>
                        <!-- 첫번째 토글 끝 -->
                        <div id="myBoard" class="tab-pane fade">
                            <p>*내 게시글 관리</p>
                            <form>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <td>번호</td>
                                        <td>제목</td>
                                        <td>작성일</td>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="list" items="${userVO.userBoardList }">
                                    <tr>
                                        <td>${list.bno }</td>
                                        <td><a href="../freeBoard/freeDetail?bno=${list.bno }">${list.title }</a></td>
                                        <td><fmt:formatDate value="${list.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            </form>
                        </div>
                        <!-- 두번째 토글 끝 -->
                        <div id="menu2" class="tab-pane fade">
                            <h3>Menu 2</h3>
                            <p>Some content in menu 2.</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>


    </section>
    
    <%@ include file="../include/footer.jsp" %>

	<script>
		$("#updateBtn").click(function(){
			
			//1. 이름, 비밀번호, 비밀번호 확인, email, phone, addrzipnum, addrbasic, addrdetail 공백검사
			//2. 비밀번호은 8자 이상 16자리 이하로 처리, 비밀번호확인란은 비밀번호란과 동일할 수 있도록 조건 처리
			//3. 나머지 조건은 공백이면 경고창
			//4. ajax요청을 통해서 json형식으로 updateUser요청으로 전송을 시켜서 업데이트 처리.
			//5. 업데이트 성공이면 "정보가 수정되었습니다"경고창으로 출력 후에 비밀번호와 비밀번호 확인란을 공백처리
			//6. 업데이트가 실패라면 "정보수정에 실패해습니다"경고창으로 출력 후에 비밀번호와 비밀번호 확인란을 공백처리
			console.log($("#userPw").val().length);
			var userId = $("#userId").val();
			var userName = $("#userName").val();
			var userPw =$("#userPw").val();
			var userEmail1 = $("#userEmail1").val();
			var userEmail2 = $("#userEmail2").val();
			var userPhone1 = $("#userPhone1").val();
			var userPhone2 = $("#userPhone2").val();
			var addrZipNum = $("#addrZipNum").val();
			var addrBasic = $("#addrBasic").val();
			var addrDetail = $("#addrDetail").val();
			
			if(userName==''){
				alert("이름을 입력하세요");
				return false;
			}else if(userPw==''||userPw.length < 8 || userPw.length > 16){
				alert("비밀번호를 확인하세요");
				return false;
			}else if($("#pwCheck").val()==''||userPw!=$("#pwCheck").val()){
				alert("비밀번호 확인란을 확인하세요");
				return false;
			}else if(userEmail1==''){
				alert("이메일을 입력하세요");
				return false;
			}else if(userPhone2==''){
				alert("휴대폰번호를 입력하세요");
				return false;
			}else if(addrZipNum==''||addrBasic==''){
				alert("주소를 입력하세요");
				return false;
			}
			
			var jsonData={'userId':userId,
						'userName':userName, 
						'userPw':userPw,
						'userEmail1':userEmail1, 
						'userEmail2':userEmail2, 
						'userPhone1':userPhone1,
						'userPhone2':userPhone2, 
						'addrZipNum':addrZipNum, 
						'addrBasic':addrBasic, 
						'addrDetail':addrDetail}
			
			$.ajax({
				type:"PUT",
				url:"updateUser",
				data:JSON.stringify(jsonData),
				contentType:"application/json; charset=utf-8",
				success:function(result){
					if(result == 1){
						alert("정보가 수정되었습니다");
						$("#userPw").val('');
						$("#pwCheck").val('');
					}else{
						alert("정보수정이 실패했습니다");
						$("#userPw").val('');
						$("#pwCheck").val('');
					}
				},
				error:function(status){
					alert("다시 시도해 주세요"+status);
				}
									
			})
			
			
			
			
			
			
			
			
		})
	
	
	</script>





    
    <script>
	    /* 주소API */
	    var addBtn = document.getElementById("addBtn");
	    addBtn.onclick = goPopup;
	    function goPopup(){
	    	var pop = window.open("${pageContext.request.contextPath}/resources/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");         	
	    }
	
	    function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	    		document.getElementById("addrBasic").value = roadAddrPart1;
	    		document.getElementById("addrDetail").value = addrDetail + roadAddrPart2;
	    		document.getElementById("addrZipNum").value = zipNo;
	    }	
    </script>
    
</body>
</html>