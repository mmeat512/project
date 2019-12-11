package com.team404.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.command.UserVO;
import com.team404.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	@Qualifier("userService")
	private UserService userService;
	
	@RequestMapping("/userJoin")
	public String userJoin() {
		return "user/userJoin";
	}
	
	@RequestMapping(value="/joinForm", method=RequestMethod.POST)
	public String joinForm(UserVO vo, RedirectAttributes RA) {
		int result = userService.insert(vo);
		if(result == 1) {
			RA.addFlashAttribute("msg","가입을 축하합니다");
		}else {		
			RA.addFlashAttribute("msg","회원가입에 실패했습니다");
		}
		return "redirect:/user/userLogin";
	}
	
	@RequestMapping("/userLogin")
	public String userLogin() {
		return "user/userLogin";
	}
/*
	@RequestMapping("/loginForm")
	public String loginForm(UserVO vo) {
		int result = userService.loginCheck(vo);
		System.out.println(result);
		return null;
	}
*/
	@RequestMapping("/loginForm")
	public String loginForm(@RequestParam("userId") String userId,
							@RequestParam("userPw") String userPw,
							RedirectAttributes RA,
							HttpSession session) {
		//1개의 카운트가 나왔다는 것은 로그인 성공, 0이 나왔다는 것은 로그인 실패
		int result = userService.loginCheck(userId, userPw);
		/* 핸들러를 사용하지 않은 기존의 방법
		if(result == 1) {
			session.setAttribute("user_Id", userId);//세션에 아이디 저장 
			return "redirect:/";//홈화면
		}else {
			RA.addFlashAttribute("msg","아이디와 비밀번호가 틀렸습니다");//리다이렉트시 1회성 데이터 
			return "redirect:/user/userLogin";
		}
		*/
		
		//Post핸들러와 접목시켜서 사용, 단 죽복 리다이렉트 이동이 일어나면 에러
		if(result == 1) {//로그인성공
			session.setAttribute("user_Id", userId);//세션에 아이디 저장 
			return "home";//홈화면 //인터셉터활용 시 redirect를 2번 사용하면 에러가 일어난다.
		}else {//로그인 실패
			RA.addFlashAttribute("msg","아이디와 비밀번호가 틀렸습니다");//리다이렉트시 1회성 데이터 
			return "redirect:/user/userLogin";
		}
		
		
	}
	//마이페이지화면(페이지 진입시, 조인을 통해서 user에 대한 정보와, user가 쓴 글에 대한 정보를 동시에 처리)
	@RequestMapping("/userMypage")
	public String userMypage(Model model, HttpSession session) {
		String userId = (String)session.getAttribute("user_Id");
		model.addAttribute("userVO", userService.getInfo(userId));
		
		
		return "user/userMypage";
	}
	
	@RequestMapping("/userLogout")
	public String userLogout(HttpSession session) {
		session.removeAttribute("user_Id");
		return "redirect:/";
	}
	
	//비동기 컨트롤러를 만들지 않고 비동기하는 방법
	//일반 컨트롤러에서 @ResponseBody어노테이션을 적어주면 메서드의 리턴값을
	//view리졸버로 가지 않고 해당 메서드를 호출한 곳으로 반환합니다.
	@RequestMapping(value="/idConfirm")
	@ResponseBody //@ResponseBody는 일반컨트롤러에서 비동기통신을 할 때 붙이는 어노테이션
	public int idConfirm(@RequestBody UserVO vo) {//@RequestBody는 요청 받아 들어온 값을 자동으로 json형태를 자동으로 바인딩 해주는 어노테이션  
		return userService.idCheck(vo.getUserId());
	}
	
	@RequestMapping(value="/updateUser")
	@ResponseBody
	public int updateUser(@RequestBody UserVO vo) {
		return userService.update(vo);
	}
}
