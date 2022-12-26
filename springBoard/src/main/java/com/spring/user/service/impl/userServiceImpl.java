package com.spring.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.vo.BoardVo;
import com.spring.user.dao.UserDao;
import com.spring.user.service.userService;
import com.spring.user.vo.UserVo;

@Service
public class userServiceImpl implements userService{
	
	@Autowired
	private UserDao userDao;

	@Override
	public String SelectTest() throws Exception {
		// TODO Auto-generated method stub
		return userDao.selectTest();
	}

	@Override
	public int userIdDuplicateCheck(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		
		return userDao.userIdDuplicateCheck(userVo);
	}

	@Override
	public int userInsert(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return userDao.userInsert(userVo);
	}

	@Override
	public UserVo userLogin(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub

		return userDao.userLogin(userVo);
	}

}
