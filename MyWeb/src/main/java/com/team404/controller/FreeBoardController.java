package com.team404.controller;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.command.FreeBoardVO;
import com.team404.freeboard.service.FreeBoardService;
import com.team404.util.Criteria;
import com.team404.util.PageVO;

@Controller
@RequestMapping("/freeBoard")
public class FreeBoardController {

	@Autowired
	@Qualifier("freeBoardService")
	private FreeBoardService freeBoardService;
	
	
	//목록화면
	@RequestMapping(value="/freeList", method=RequestMethod.GET)
	public String freeList(Model model, Criteria cri) {
		//서비스에서 getList호출 mapper에서 getList를 호출
		//컨트롤러에서는 모델에 bardList이름으로 결과를 담아서 화면에서 출력
		
		//일반
		//model.addAttribute("boardList",freeBoardService.getList());
		
		//기본페이징
//		ArrayList<FreeBoardVO> list = freeBoardService.getList(cri);	
//		PageVO pageVO = new PageVO(cri, freeBoardService.getTotal());
		
		//검색페이징
		ArrayList<FreeBoardVO> list = freeBoardService.getList(cri);
		int total = freeBoardService.getTotal(cri);
		PageVO pageVO = new PageVO(cri,total);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("boardList", list);
		//댓글
		
		return "freeBoard/freeList";
	}
	
	//등록화면
	@RequestMapping(value="/freeRegist", method=RequestMethod.GET)
	public String freeRegist() {
		return"freeBoard/freeRegist";
	}
	
	//게시글 등록
	@RequestMapping(value="/registForm", method=RequestMethod.POST)
	public String registForm(FreeBoardVO vo,RedirectAttributes ra) {
		//서비스의 regist메서드를 생성하고, mapper에 regist메서드를 생성한 후에 
		//mybatis xml에서 db에 insert처리
		freeBoardService.regist(vo);
		ra.addFlashAttribute("msg","게시물이 성공적으로 등록되었습니다.");
		return "redirect:/freeBoard/freeList";
	}		
/*	
	//상세화면
	@RequestMapping(value="/freeDetail", method=RequestMethod.GET)
	public String freeDetail(@RequestParam("bno") int bno,Model model) {
		model.addAttribute("vo",freeBoardService.content(bno));
		return "freeBoard/freeDetail";
	}
	
	//수정화면
	@RequestMapping(value="/freeModify",method=RequestMethod.POST)
	public String freeModify(@RequestParam("bno") int bno,Model model) {
		model.addAttribute("vo",freeBoardService.content(bno));
		return "freeBoard/freeModify";
	}
*/
	//상세보기, 수정화면(동일한 기능이기 때문에 {}로 묶어서 사용)
	@RequestMapping(value= {"/freeDetail","/freeModify"})
	public void view(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("vo",freeBoardService.content(bno));
		//요청의 경로로 리졸버 뷰로 전달됩니다.
	}
	
	//게시글 수정요청
	@RequestMapping(value="/freeUpdate",method=RequestMethod.POST)
	public String freeupdate(FreeBoardVO vo, RedirectAttributes RA) {
		//서비스의 update메서드 실행, mapper의 update메서드 실행
		//컨트롤러에는 결과를 반환받아서 수정 성공 시 RA에 msg이름으로 "게시물이 수정이 정상처리 되었습니다"
		//수정 실패시 RA에 msg이름으로 "게시물 수정에 실패했습니다"
		//화면처리를 List화면으로 이동
		if(freeBoardService.update(vo)) {
			RA.addFlashAttribute("msg", "게시물 수정이 정상처리 되었습니다");
		}else {
			RA.addFlashAttribute("msg","게시물 수정에 실패했습니다");
		}
		return "redirect:/freeBoard/freeList";
	}
	
	//게시글 삭제요청
	@RequestMapping(value="/freeDelete")
	public String freeDelete(@RequestParam("bno") int bno,RedirectAttributes RA) {
		
		if(freeBoardService.delete(bno)) {
			RA.addFlashAttribute("msg","게시물 삭제가 정상처리 되었습니다");
		}else{
			RA.addFlashAttribute("msg","게시물 삭제에 실패했습니다");
		};
		return "redirect:/freeBoard/freeList";
	}


	
	
}
