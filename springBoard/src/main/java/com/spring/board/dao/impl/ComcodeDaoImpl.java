package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.ComcodeDao;
import com.spring.board.vo.ComcodeVo;

@Repository
public class ComcodeDaoImpl implements ComcodeDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ComcodeVo> selectComcodeList(ComcodeVo comcodeVo) throws Exception {
		// TODO Auto-generated method stub
		
		return sqlSession.selectList("board.ComcodemenuList",comcodeVo);
	}
	
	
}
