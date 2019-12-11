package com.team404.controllerTest;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.myweb.command.TestVO;

@RestController
@RequestMapping("/restControl")
public class RestBasicController {

	// 1. RestController는 기본적으로 return에 실린값이 리졸버 뷰로 전달되는 것이 아닌
	// 요청된 주소로 반환됩니다.

	// 나는 문자열로 반환보낼게
	@RequestMapping(value = "/getText", produces = "text/plain; charset=utf-8")
	public String getText() {
		return "안녕하세요";
	}

	// 나는 객체로 반환보낼게(단, 잭슨-데이터바인딩 라이브러리가 필요)
	@RequestMapping(value = "/getObject")
	public TestVO getObject() {
		TestVO vo = new TestVO(20, "홍길순", "kkk123");
		return vo;
	}

	// 나 num을 받고, 컬렉션 보낼게
	@RequestMapping(value = "/getCollection")
	public ArrayList<TestVO> getCollection(@RequestParam("num") int num) {

		ArrayList<TestVO> list = new ArrayList<TestVO>();
		for (int i = 0; i <= num; i++) {
			TestVO vo = new TestVO(i, "길자" + i, "kkk" + i);
			list.add(vo);
		}
		return list;
	}

	// String으로 값을 2개 받고, Map형태로 반환할게
	@RequestMapping("/getPath/{id}/{pw}")
	public HashMap<String, TestVO> getPath(@PathVariable("id") String id, @PathVariable("pw") String pw) {

		System.out.println(id);
		System.out.println(pw);
		HashMap<String, TestVO> map = new HashMap<String, TestVO>();
		map.put("info", new TestVO(10, "홍길순", "hh"));

		return map;
	}

	// @RequestBody json객체를 자바 vo에 자동맵핑합니다
	// 구글확장프로그램 res client설치
	// http://localhost:8181/myweb/restControl/getJson에 json형식으로 요청
	@RequestMapping("/getJson")
	public ArrayList<TestVO> getJson(@RequestBody TestVO vo, HttpServletRequest request) {
		// 크롬에 구글확장프로그램검색
		// 검색창 rest client검색
		//
		ArrayList<TestVO> list = new ArrayList<TestVO>();
		list.add(new TestVO(20, "신사임당", "kkkk123"));

		System.out.println("요청주소:" + request.getRemoteAddr());
		System.out.println(vo.toString());
		return list;
	}

	// REST API에서 getMember/값1/값2의 url로 호출하여
	// 두 값이 동일하다면 TestVO에 (40, 값1, 홍길동)을 담아 반환하고, 그렇지 않으면 null을 반환하는 메서드를 생성
	// rest Client호출해서 결과 확인
	 @RequestMapping("/getMember/{id}/{pw}") 
	 public TestVO getMember( @PathVariable("id") String id,
 							  @PathVariable("pw") String pw) { 
	 if(id.equals(pw)) { 
		 return new TestVO(40,id,"홍길동"); 
	 }else { 
		return null; 
		} 
	 }
	 
	 @RequestMapping("/getMember")
	 public TestVO getMember2 (@RequestBody TestVO vo) {
		 if(vo.getId().equals(vo.getName())) {
			 return new TestVO(40,vo.getId(),"홍길동");
		 }else {
			 return null;
		 }
	 }


}
