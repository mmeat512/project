package com.team404.user.service;


import com.myweb.command.UserVO;

public interface UserService {

	public int idCheck(String userId);
	public int insert(UserVO vo);
	//public int loginCheck(UserVO vo);
	public int loginCheck(String userId,String userPw);
	public UserVO getInfo(String userId);
	public int update(UserVO vo);
	
}
