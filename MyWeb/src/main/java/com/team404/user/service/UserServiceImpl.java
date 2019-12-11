package com.team404.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myweb.command.UserVO;
import com.team404.user.mapper.UserMapper;

@Service("userService")
public class UserServiceImpl implements UserService{

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public int idCheck(String userId) {
		return userMapper.idCheck(userId);
	}

	@Override
	public int insert(UserVO vo) {
		
		return userMapper.insert(vo);
	}

	@Override
	public int loginCheck(String userId, String userPw) {
		return userMapper.loginCheck(userId, userPw);
	}

	@Override
	public UserVO getInfo(String userId) {
		return userMapper.getInfo(userId);
	}

	@Override
	public int update(UserVO vo) {
		return userMapper.update(vo);
	}

}
