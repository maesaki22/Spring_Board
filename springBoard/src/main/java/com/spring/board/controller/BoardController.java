package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComcodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;
import com.spring.user.vo.UserVo;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	 
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo, HttpServletRequest request) throws Exception{
		
		//HttpSession session = request.getSession(false);
		//UserVo user =(UserVo)session.getAttribute("loginUser"); 
		//if(user !=null) {
		//	System.out.println("session ::" + user.getUserId());
		//}else
		//	System.out.println("session :: is null");
		// checked 항목 db에서 가져옵니다.
		List<ComcodeVo> comCodeList = new ArrayList<ComcodeVo>(); 
		String codeType = "menu";
		comCodeList = boardService.SelectMenuList(codeType);
		// checkedbox 항목을  pageVo에 담는 과정
		String[] boardTypeAll =  new String[comCodeList.size()];
		for(int i=0; i<comCodeList.size();i++) {
			boardTypeAll[i] =comCodeList.get(i).getCodeId();
		}
		
		pageVo.setBoardSelectType(boardTypeAll);
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt();
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		model.addAttribute("comCodeList", comCodeList);		
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{

		
		
		BoardVo boardVo = new BoardVo();
	
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		List<ComcodeVo> comCodeList = new ArrayList<ComcodeVo>();
		String codeType = "menu";
		comCodeList = boardService.SelectMenuList(codeType);
		model.addAttribute("comCodeList", comCodeList);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo, PageVo pageVo, HttpServletRequest request) throws Exception{	

		HttpSession session = request.getSession(false);
		UserVo user =(UserVo)session.getAttribute("loginUser");
		for(int i=0;i<boardVo.getBoardVoList().size();i++) {
			boardVo.getBoardVoList().get(i).setUserVo(user);
		}		
		//boardVo.setUserVo(user);
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
			
		int resultCnt = boardService.boardInsert(boardVo);

		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model 
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
        //model.addAttribute("boardType", boardType);
        //model.addAttribute("boardNum", boardNum);
        model.addAttribute("board",boardVo);
		
		return "/board/boardUpdate"; 
	}

	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale,BoardVo boardVo, PageVo pageVo) throws Exception{	
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
	
		int resultCnt = boardService.boardUpdate(boardVo);

		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}	
	
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDeleteAction(Locale locale,BoardVo boardVo, PageVo pageVo) throws Exception{	
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardDelete(boardVo);

		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result); 
		System.out.println("callbackMsg::"+callbackMsg);
		 		
		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardSelectTypeList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<BoardVo> boardSelectTypeListAction(Locale locale,PageVo pageVo) throws Exception{	
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		int page = 1;
		//int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		// 이 dao를 변경해줘야할듯하다.
		boardList = boardService.SelectBoardList(pageVo);	
		return boardList;
	}
	
}
