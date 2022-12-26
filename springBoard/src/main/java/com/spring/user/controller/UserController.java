package com.spring.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComcodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;
import com.spring.user.service.userService;
import com.spring.user.vo.UserVo;

@Controller
public class UserController {
	
	@Autowired
	userService userService;
	@Autowired
	boardService boardService;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/user/userJoin.do", method = RequestMethod.GET)
	public String userJoin(Locale locale, Model model,PageVo pageVo) throws Exception{

		// checked 항목 db에서 가져옵니다.
		List<ComcodeVo> comCodeList = new ArrayList<ComcodeVo>();
		String codeType = "phone";
		comCodeList = boardService.SelectMenuList(codeType);
		model.addAttribute("comCodeList", comCodeList);	
		return "user/userJoin";
	}
	
	@RequestMapping(value = "/user/userIdDuplicateCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public String userIdDuplicateCheck(Locale locale,Model model
			,@RequestParam("userId") String userId) throws Exception{	

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		UserVo userVo = new UserVo();
		userVo.setUserId(userId);	
		int resultCnt = userService.userIdDuplicateCheck(userVo);

		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result); 
		System.out.println("callbackMsg::"+callbackMsg);
		 		
		return callbackMsg;	
	}
	
	@RequestMapping(value = "/user/userJoinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String userJoinAction(Locale locale,UserVo userVo) throws Exception{	
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = userService.userInsert(userVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	
	@RequestMapping(value="/user/userLogin.do", method=RequestMethod.GET)
	public String userLogin(Locale locale,Model model,PageVo pageVo) throws Exception{

		return "user/userLogin";
	}	
	
	@RequestMapping(value = "/user/userLoginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public UserVo userLoginAction(Locale locale, UserVo userVo, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(true);
		UserVo loginUser = new UserVo();
		loginUser = userService.userLogin(userVo);
		if (loginUser != null) {
			session.setAttribute("loginUser", loginUser);		
			return loginUser;
		}
		return null;
	}
	@RequestMapping(value="/user/uesrLogout.do", method=RequestMethod.GET)
	public String userLogout(Locale locale,Model model,PageVo pageVo , HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession(false);
		session.invalidate(); 
		return "redirect:/board/boardList.do";
	}
}
