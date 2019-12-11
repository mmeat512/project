package com.team404.snsboard.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.command.SnsBoardVO;
import com.team404.snsboard.mapper.SnsBoardMapper;

@Service("snsBoardService")
public class SnsBoardServiceImpl implements SnsBoardService{

	@Autowired
	private SnsBoardMapper snsBoarMapper;
	
	@Override
	public int insert(SnsBoardVO vo) {
		
		System.out.println(vo.toString());
		return snsBoarMapper.insert(vo);
	}

	@Override
	public ArrayList<SnsBoardVO> getList() {
		return snsBoarMapper.getList();
	}

	
}
