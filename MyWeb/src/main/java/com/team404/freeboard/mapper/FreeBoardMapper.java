package com.team404.freeboard.mapper;

import java.util.ArrayList;

import com.myweb.command.FreeBoardVO;
import com.team404.util.Criteria;

public interface FreeBoardMapper {

	public void regist(FreeBoardVO vo);
	//public ArrayList<FreeBoardVO> getList(); 일반
	//기본페이징
//	public ArrayList<FreeBoardVO> getList(Criteria cri);
//	public int getTotal();
	//검색페이징
	public ArrayList<FreeBoardVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	public FreeBoardVO content(int bno);
	public boolean update(FreeBoardVO vo);
	public boolean delete(int bno);

}
