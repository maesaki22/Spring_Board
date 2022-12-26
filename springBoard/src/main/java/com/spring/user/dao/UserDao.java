package com.spring.user.dao;

import com.spring.user.vo.UserVo;

public interface UserDao {
	
	public String selectTest();
	public int userIdDuplicateCheck(UserVo userVo);
	public int userInsert(UserVo userVo);
	public UserVo userLogin(UserVo userVo);

}
