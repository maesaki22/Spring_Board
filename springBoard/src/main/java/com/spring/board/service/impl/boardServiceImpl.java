package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.dao.ComcodeDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComcodeVo;
import com.spring.board.vo.PageVo;
import com.spring.user.vo.UserVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	@Autowired
	ComcodeDao comcodeDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoardList(pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		for(int i=0;i<boardVo.getBoardVoList().size();i++) {
			int fResult = boardDao.boardInsert(boardVo.getBoardVoList().get(i));
			result += fResult;
		}

		return result;
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
	
		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardDelete(boardVo);
	}

	@Override
	public List<ComcodeVo> SelectMenuList(String codeType) throws Exception {
		// TODO Auto-generated method stub
		ComcodeVo comcodeVo = new ComcodeVo();
		comcodeVo.setCodeType(codeType);
		return comcodeDao.selectComcodeList(comcodeVo);
	}

}
