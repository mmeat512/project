package com.team404.user.mapper;

import org.apache.ibatis.annotations.Param;

import com.myweb.command.UserVO;

public interface UserMapper {

	public int idCheck(String userId);
	public int insert(UserVO vo);
	//public int loginCheck(UserVO vo);
	public int loginCheck(@Param("userId")String userId, @Param("userPw")String userPw);
	public UserVO getInfo(String userId);
	public int update(UserVO vo);
	
}
