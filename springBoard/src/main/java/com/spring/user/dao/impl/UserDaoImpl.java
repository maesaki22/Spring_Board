package com.spring.user.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.user.dao.UserDao;
import com.spring.user.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public String selectTest() {
		// TODO Auto-generated method stub
		String test = sqlSession.selectOne("user.userList");
		return test;
	}

	@Override
	public int userIdDuplicateCheck(UserVo userVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.userselect",userVo);
	}

	@Override
	public int userInsert(UserVo userVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("user.userInsert",userVo);
	}

	@Override
	public UserVo userLogin(UserVo userVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.userLogin",userVo);
	}
	
	
}
