package com.team404.freereply.service;

import java.util.ArrayList;

import com.myweb.command.ReplyVO;
import com.team404.util.Criteria;
import com.team404.util.ReplyPageVO;

public interface FreeReplyService {

	public int regist(ReplyVO vo);
//	public ArrayList<ReplyVO> getList(int bno);
	public ReplyPageVO getList(Criteria cri, int bno);
	public int pwCheck(ReplyVO vo);
	public int delete(int rno);
	public int update(ReplyVO vo);

}
