package com.team404.freereply.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.myweb.command.ReplyVO;
import com.team404.util.Criteria;

public interface FreeReplyMapper {

	public int regist(ReplyVO vo);
	//public ArrayList<ReplyVO> getList(int bno);
	public ArrayList<ReplyVO> getList(@Param("cri") Criteria cri,@Param("bno") int bno);//더보기 목록 처리
	public int getTotal(int bno); //게시글에 따른 댓글 수 
	public int pwCheck(ReplyVO vo);
	public int delete(int rno);
	public int update(ReplyVO vo);
}
