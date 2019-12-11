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
                            <p>상세보기</p>
                        </div>
                        
                        <form action="freeModify" method="post" name="regForm">
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
                                <!-- 화면에서 writer값을 form으로 넘김 -->
                                <input class="form-control" name='writer' value="${vo.writer }"readonly>
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <input class="form-control" name='title' value="${vo.title }" readonly>
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <textarea class="form-control" rows="10" name='content' readonly>${vo.content }</textarea>
                            </div>

                            <button type="button" class="btn btn-primary" id="freeModify">수정</button>
                            <button type="button" class="btn btn-dark" id="freeList">목록</button>
                    </form>
                </div>
            </div>
        </div>
        </section>
        
        <section style="margin-top: 80px;">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-md-9 write-wrap">
                        <form class="reply-wrap">
                            <div class="reply-image">
                                <img src="../resources/img/profile.png">
                            </div>
                            <!--form-control은 부트스트랩의 클래스입니다-->
	                    <div class="reply-content">
	                        <textarea class="form-control" rows="3" id="reply"></textarea>
	                        <div class="reply-group">
	                              <div class="reply-input">
	                              <input type="text" class="form-control" id="replyId" placeholder="이름" >
	                              <input type="password" class="form-control" id="replyPw" placeholder="비밀번호" >
	                              </div>
	                              
	                              <button type="button" class="right btn btn-info" id="replyRegist">등록하기</button>
	                        </div>
	
	                    </div>
                        </form>

                        <!--여기에접근 반복-->
                        <div id="replyList">

                        </div>
                        <button type="button" class="btn btn-default btn-block" id="moreList">더보기</button>
                    </div>
                </div>
            </div>
        </section>
        	<!-- 모달 -->
			<div class="modal fade" id="replyModal" role="dialog">
				<div class="modal-dialog modal-md">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="btn btn-default pull-right" data-dismiss="modal">닫기</button>
							<h4 class="modal-title">댓글수정</h4>
						</div>
						<div class="modal-body">
							<!-- 수정폼 id값을 확인하세요-->
								<div class="reply-content">
								<textarea class="form-control" rows="4" id="modalReply" placeholder="내용입력"></textarea>
								<div class="reply-group">
									<div class="reply-input">
									    <input type="hidden" id="modalRno">
										<input type="password" class="form-control" placeholder="비밀번호" id="modalPw">
									</div>
									<button class="right btn btn-info" id="modalModBtn">수정하기</button>
									<button class="right btn btn-info" id="modalDelBtn">삭제하기</button>
								</div>
								</div>
							<!-- 수정폼끝 -->
						</div>
					</div>
				</div>
			</div>
        
        <%@ include file="../include/footer.jsp" %>
        <script>
		var freeList = document.getElementById("freeList");
		freeList.onclick = function(){
			location.href="freeList";
		}
		
		var freeModify = document.getElementById("freeModify");
		freeModify.onclick = function () {
			document.regForm.submit();
		}
		
		</script>

		<!-- 댓글처리영역 -->
		<script>
			$(document).ready(function(){
				
				$("#replyRegist").click(function(){
					add();
					
				})
				
				//댓글 등록
				function add(){
					//1. 필요한 값을 취득
					//2. 조건 검사
					//3. ajax요청
					var replyId = $("#replyId").val();
					var replyPw = $("#replyPw").val();
					var reply = $("#reply").val();
					var bno = '${vo.bno}';
					
					if(reply == '' || replyId == '' || replyPw == ''){
						alert("이름,비밀번호,내용은 필수사항입니다.");
						return false;//함수 강제종료
						
					}
					//에이잭스 요청
					$.ajax({
						type:"POST",//전송형식
						url:"../reply/new",//전송할 url
						data:JSON.stringify({"bno":bno, "reply":reply, "replyId":replyId, "replyPw":replyPw}),//전송데이터
						contentType:"application/json; charset=utf-8", //전송할 타입
						success:function(result){
							$("#replyId").val('');
							$("#reply").val('');
							$("#replyPw").val('');
							getList(1, true);
						},//전송 성공 시 돌려받을 익명 함수(결과를 매개변수에 저장)
						error:function(status){
							alert("댓글 등록에 실패했습니다"+status);
						}//응답 실패 시 실행되는 익명함수
					})
					
				}
				//더보기처리
				$("#moreList").click(function(){
					getList(++pageNum,false); //str을 리셋하지 않기 위해 false전달
				})
				
				//댓글 목록
				getList(1, true);
				var str = "";//화면에 뿌려줄 태그를 문자열의 형태로 저장하는 전역변수
				var pageNum = 1;
				function getList(page, reset){
					var bno = '${vo.bno}';
					pageNum = page; //전달 받은 페이지 번호를 멤버변수에 다시 저장
					//select구문을 이용할 때는 getJSON(규칙)
					$.getJSON(
						"../reply/getReply/" + bno +"/"+ pageNum, //요청보낼 주소
						function(data){ //성공 시 전달받을 익명함수 
						
							var list = data.list;	//컨트롤러에서 넘어온 댓글 목록
							var count = data.replycount; //컨트롤러에서 넘어온 토탈 카운트
							
							if(reset == true){ //reset은 str의 초기화 여부
								str = "";
							}
							if(pageNum*20 >= count){//게시글에 전체 댓글 수 보다 pageNum에 따른 게시글 수가 큰 경우는 더보기 삭제
								$("#moreList").hide();								
							}else{
								$("#moreList").show();
							}
							for(var i = 0; i < list.length; i++){
								console.log(list[i].updatedate);
		                        str += "<div class='reply-wrap'>";
	                            str += "<div class='reply-image'>";
	                            str += "<img src='../resources/img/profile.png'>";
	                            str += "</div>";
	                            str += "<div class='reply-content'>";
	                            str += "<div class='reply-group'>";
	                            str += "<strong class='left'>"+list[i].replyId+"</strong>"; 
	                            str += "<small class='left'>"+timeStamp(list[i].updatedate)+"</small>";
	                            str += "<a href='"+list[i].rno+"' class='right' id='replyModify'><span class='glyphicon glyphicon-pencil' ></span>수정</a>";
	                            str += "<a href='"+list[i].rno+"' class='right' id='replyDelete'><span class='glyphicon glyphicon-remove' ></span>삭제</a>";
	                            str += "</div>";
	                            str += "<p class='clearfix'>"+list[i].reply+"</p>";
	                            str += "</div>";
	                        	str += "</div>";
							}//for문끝

							$("#replyList").html(str); //replyList아래에 문자열을 통째로추가
							console.log("순서1");
						}
					)
					
				}//목록처리 끝
				
				console.log("순서2");
				//삭제, 수정 클릭 시 모달 창 띄우는 이벤트 처리
				//실제로 에이젝스의 실행이 더 늦게 완료가 되므로, 이벤트 선언이 먼저 일어나게 됩니다.
				//그렇다면 화면에 댓글과 관련된 이벤트는 아무것도 등록되지 않은 형태이므로, 일반적인 클릭이벤트는 동작하지 않습니다.
				//이때 이미 존재하는 요소$("#replyList")에 이벤트를 등록하고, 해당 태그의 내부 요소를 클릭하여 동작하는 이벤트 위임방식을 사용합니다.
/* 				$("a[href=#]").click(function() {//댓글목록이 비동기 형식이기 때문에 click이벤트를 먼저 실행한다. (따라서 선택자가 없기 때문에 클릭이벤트가 실행되지 않음)
					alert("이벤트확인");
				}) */
				$("#replyList").on("click","a",function(event){
					event.preventDefault();//a태그 이용을 막는다.
					//수정 클릭 시, modal-title에 접근해서 "댓글 수정" 변경
					//textarea태그를 보여지도록 처리
					//수정버튼을 보여지도록 처리
					//삭제버튼을 가리도록 처리

					//삭제 클릭시, modal-title에 접근해서 "댓글 삭제"변경
					//textarea태그를 숨겨지도록 처리
					//삭제버튼이 보여지도록 처리
					//수정버튼을 가리도록 처리
				
					//this는 이벤트가 적용되는 태그를 가져온다.(a태그가 여러가지라면 이벤트가 실행되는 하나의 태그를 가져온다.)
					if($(this).attr("id")=="replyModify"){//수정인a태그 클릭 시 $(this)는 a태그 replymodify를 가져온다.
						console.log($(this).attr("id"));
						var rno = $(this).attr("href"); //클릭요소의 href값을 가져온다.
						$("#modalRno").val(rno);//modalRno에 값을 세팅ㄴ
						$(".modal-title").html("댓글 수정"); //모달창 제목 변경
						$("textarea").css("display","inline");//textarea창을 보이게 한다
						$("#modalModBtn").css("display","inline");//수정버튼을 보이게 한다
						$("#modalDelBtn").css("display","none");//삭제버튼을 감춘다
						$("#replyModal").modal("show");//모달창띄우기
						
					}else if($(this).attr("id")=="replyDelete"){//삭제인  a태그 클릭 시 $(this)는 a태그 replydelete를 가져온다.
						console.log($(this).attr("id"));
						var rno = $(this).attr("href"); //클릭요소의 href값을 가져온다.
						$("#modalRno").val(rno);//modalRno에 값을 세팅
						$(".modal-title").html("댓글 삭제");
						$("textarea").hide();
						$("#modalModBtn").hide();
						$("#modalDelBtn").show();
						$("#replyModal").modal("show");//모달창띄우기
					}
				})//수정, 삭제 클릭 시 이벤트 동작 처리 끝

				//삭제처리
				$("#modalDelBtn").click(function(){
					//1. modalRno값을 얻고, modalPw값을 얻음
					//2. ajax를 통해서 reply/delete로 json형식으로 요청처리
					//3. pwCheck()메서드를 통해서 비밀번호가 맞는지 확인 
					//4. 비밀번호가 맞다면 delete()메서드로 삭제를 진행
					//콜백함수로 삭제성공이 돌아오면, 비밀번호창을 비우고, 모달창을 modal("hide")로 처리 
					//콜백함수로 삭제실패가 돌아오면 "비밀번호가 틀렸습니다"를 출력
					
					var rno = $("#modalRno").val();
					var replyPw = $("#modalPw").val();
					console.log(rno);
					console.log(replyPw);
					<%--
					$.getJson(
						 "../reply/delete/"+rno+"/"+modalPw,
						function(data){
							if(data==1){
								$("#modalPw").html("");
								$("#replyModal").modal("hide");
								getList(1, true);
							}else{
								alert("비밀번호가 틀렸습니다");
							}
						}
					)--%>
					<%--
					$.ajax({
						type:"POST",
						url:"../reply/delete/"+rno+"/"+modalPw,
						success:function(data){
							if(data==1){
								$("#modalPw").html("");
								$("#replyModal").modal("hide");
								getList(1, true);
							}else{
								alert("비밀번호가 틀렸습니다");
							}
						},
						error:function(){
							alert("비밀번호가 틀렸습니다");
						}
					})--%>
					
					$.ajax({
						type:"DELETE",
						url:"../reply/delete",
						data:JSON.stringify({"rno": rno, "replyPw":replyPw}),
						contentType:"application/json; charset=utf-8",
						success:function(result){
							if(result==1){
								alert("댓글 삭제");
								$("#modalPw").val("");//비밀번호비우기
								$("#replyModal").modal("hide");
								getList(1, true);//삭제 후에 목록메서드 호출 
							}else{
								$("#modalPw").val("");//비밀번호비우기
								alert("비밀번호틀림");
							}
						},
						error:function(status){
							alert("다시 시도하세요"+status);
						}
					})
				})
				
				//수정처리
				$("#modalModBtn").click(function(){
					var rno = $("#modalRno").val();
					var reply = $("#modalReply").val();
					var replyPw = $("#modalPw").val();
					console.log(rno);
					$.ajax({
						type:"PUT",
						url:"../reply/update",
						data:JSON.stringify({"rno":rno,"reply":reply,"replyPw":replyPw}),
						contentType:"application/json; charset=utf-8",
						success:function(result){
							if(result==1){
								alert("수정되었습니다");
								$("#modalReply").val("");
								$("#replyModal").modal("hide");
								$("#modalPw").val("");
								getList(1,true);
							}else{
								alert("비밀번호가 틀립니다");
								$("#modalPw").val("");
							}
						},
						error:function(status){
							alert("다시 시도하세요"+status);
						}
						
						
					})
					
				})//수정 끝
				console.log(timeStamp(1575513888000));
				//날짜 처리
				function timeStamp(milis){
					var date = new Date();//오늘 날짜
					//console.log(date.getTime());//오늘 날짜의 밀리초
					var gap = date.getTime() - milis;//경과 시간차
				
					var time;//리턴할 문자열
					if( gap < 1000*60*60*24){//등록일 기준 하루 미만인 경우
						
						if(gap < 1000* 60 * 60){//1시간 미만인 경우 
							time = "방금 전"
						}else{//1시간 이상인 경우
							time = parseInt(gap/(1000*60*60)) +"시간 전";
						}
					}else{//등록일 기준 하루 이상인 경우
						var today = new Date(milis);//밀리초 기반 날짜
						var year = today.getFullYear();//년도 구함
						var month = today.getMonth() + 1;//월
						var day = today.getDate();//일
						var hour = today.getHours();//시
						var minute = today.getMinutes();//분
						var second = today.getSeconds();//초
						time = year+"년"+month+"월"+day+"일"+hour+":"+minute+":"+second;
					}
					return time;
				}
				
			})//ready끝
		
		
		</script>



        


</body>
</html>