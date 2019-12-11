package com.team404.snsboard.mapper;

import java.util.ArrayList;

import com.myweb.command.SnsBoardVO;

public interface SnsBoardMapper {

	public int insert(SnsBoardVO vo);
	public ArrayList<SnsBoardVO> getList();
}
