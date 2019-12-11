package com.team404.snsboard.service;

import java.util.ArrayList;

import com.myweb.command.SnsBoardVO;

public interface SnsBoardService {

	public int insert(SnsBoardVO vo);
	public ArrayList<SnsBoardVO> getList();
}
