package com.team404.util.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class UserIntercepter extends HandlerInterceptorAdapter{
	//세션에 user_id가 없는 경우만 실행
	public void saveURI(HttpServletRequest request) {
		String uri = request.getRequestURI(); //요청 정보 중에 URI정보를 받음
		String query = request.getQueryString(); //요청 정보 중에 매개값을 받음
		HttpSession session = request.getSession();
		session.setAttribute("uri",uri + (query == null ? "" : "?"+query)); //세션에 uri요청과 데이터값을 세션에 저장
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String userId= (String)session.getAttribute("user_Id");//세션얻음
		if(userId==null) {
			saveURI(request);//주소에 대한 정보를 얻음
			response.sendRedirect(request.getContextPath()+"/user/userLogin");//절대경로
			return false;//컨트롤러 실행을 막음
		}else {
			System.out.println(userId);
			return super.preHandle(request, response, handler);//컨트롤러실행
		}
	}
	
	
}
