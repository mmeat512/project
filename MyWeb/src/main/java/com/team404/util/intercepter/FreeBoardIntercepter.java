package com.team404.util.intercepter;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class FreeBoardIntercepter extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//1. 등록클릭했을 때 로그인 인터셉터로 연결
		//2. Regist화면에서는 글쓴이를 세션값을 처리, 작성자를 readonly
		//3. 수정,변경,삭제 클릭 시 인터셉터를 실행시킴(단, 화면에서는 writer에 대한 정보를 반드시 넘겨줘야함)
		
		System.out.println("보드인터셉터탔음");
		String user_id = (String)request.getSession().getAttribute("user_Id");//세션정보
		String writer = request.getParameter("writer");//화면에서 넘어오는 글쓴이에 대한 정보

		if(writer != null && writer.equals(user_id)) {//작성자가null이 아니고, 세션과 작성자가 같다면 컨트롤러를 실행
			return true;
		}else {
			response.setContentType("text/html");//응답 내용에 대한 내용
			response.setCharacterEncoding("utf-8");//응답 내용에대한 한글처리
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('권한이없습니다');");
			out.print("history.go(-1);");
			out.print("</script>");		
			return false;
		}
		
	}
	
	
}
