package com.team404.freereply.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.command.ReplyVO;
import com.team404.freereply.mapper.FreeReplyMapper;
import com.team404.util.Criteria;
import com.team404.util.ReplyPageVO;

@Service("freeReply")
public class FreeReplyServiceImpl implements FreeReplyService{

	@Autowired
	private FreeReplyMapper freeReplyMapper;
	@Override
	public int regist(ReplyVO vo) {

		return freeReplyMapper.regist(vo);
	}
	/*
	 * @Override public ArrayList<ReplyVO> getList(int bno) { return
	 * freeReplyMapper.getList(bno); }
	 */
	@Override //더보기
	public ReplyPageVO getList(Criteria cri, int bno) {
		//1. 페이징된 List를 구해옴
		//2. 게시글에 따른 전체 댓글 수를 구함(각각 다른 2개의 데이터를 마이바티스 전송할 때 @Param 어노테이션 사용)
		//3. list와 replycount를 VO에 저장
		ArrayList<ReplyVO> list = freeReplyMapper.getList(cri, bno);
		int replycount = freeReplyMapper.getTotal(bno);
		ReplyPageVO vo = new ReplyPageVO(list,replycount); 
		return vo;
	}
	@Override
	public int pwCheck(ReplyVO vo) {
		
		return freeReplyMapper.pwCheck(vo);
	}
	@Override
	public int delete(int rno) {
		return freeReplyMapper.delete(rno);
	}
	@Override
	public int update(ReplyVO vo) {
		return freeReplyMapper.update(vo);
	}


	
	
}
