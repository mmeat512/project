package com.team404.freeboard.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.command.FreeBoardVO;
import com.team404.freeboard.mapper.FreeBoardMapper;
import com.team404.util.Criteria;

@Service("freeBoardService")
public class FreeBoardServiceImpl implements FreeBoardService{

	@Autowired
	private FreeBoardMapper freeBoardmapper;
	
	@Override
	public void regist(FreeBoardVO vo) {
		freeBoardmapper.regist(vo);
	}
//	@Override
//	public ArrayList<FreeBoardVO> getList() {
//		
//		return freeBoardmapper.getList();
//	}
	//기본페이징
//	@Override
//	public ArrayList<FreeBoardVO> getList(Criteria cri) {
//		return freeBoardmapper.getList(cri);
//	}
	
//	@Override
//	public int getTotal() {
//		return freeBoardmapper.getTotal();
//	}
	//검색페이징
	@Override
	public ArrayList<FreeBoardVO> getList(Criteria cri) {
		return freeBoardmapper.getList(cri);
	}	
	@Override
	public int getTotal(Criteria cri) {
		return freeBoardmapper.getTotal(cri);
	}

	@Override
	public FreeBoardVO content(int bno) {
		return freeBoardmapper.content(bno);
	}

	@Override
	public boolean update(FreeBoardVO vo) {
		return freeBoardmapper.update(vo);
	}

	@Override
	public boolean delete(int bno) {
	
		return freeBoardmapper.delete(bno);
	}




	
	
}
