package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComcodeVo;
import com.spring.board.vo.PageVo;

public interface ComcodeDao {
	
	public List<ComcodeVo> selectComcodeList(ComcodeVo comcodeVo) throws Exception;
}
