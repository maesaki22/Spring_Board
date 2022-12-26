package com.spring.user.service;

import com.spring.board.vo.BoardVo;
import com.spring.user.vo.UserVo;

public interface userService {
	public String SelectTest() throws Exception;
	public int userIdDuplicateCheck(UserVo userVo) throws Exception;
	public int userInsert(UserVo userVo) throws Exception;
	public UserVo userLogin(UserVo userVo) throws Exception;
}
