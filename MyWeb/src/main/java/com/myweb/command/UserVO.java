package com.myweb.command;

import java.sql.Timestamp;
import java.util.ArrayList;

import lombok.Data;

@Data
public class UserVO {

	private String userId;
	private String userPw;
	private String userName;
	private String userPhone1;
	private String userPhone2;
	private String userEmail1;
	private String userEmail2;
	private String addrZipNum; //우편번호
	private String addrBasic; //기본주소
	private String addrDetail; //상세주소
	private Timestamp regdate; //등록일

	//마이페이지에 join을 통해 한번에 게시글에 대한 정보를 가져나가기 위한 선언
	private ArrayList<FreeBoardVO> userBoardList;






}
