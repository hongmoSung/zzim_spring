package kr.co.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.web.service.MobileService;
import kr.co.web.vo.MobileVO;
import kr.co.web.vo.UserVO;

@RestController
@RequestMapping("/mobile")
public class MobileController {
	
	@Autowired
	private MobileService service;
	
	@ResponseBody
	@RequestMapping("/saveToken")
	public void saveToken(MobileVO vo) {
		System.out.println("토큰저장 컨트롤러 들어옴 ::: \n" + vo.getEmail() + "\n" + vo.getToken());
		service.saveToken(vo);
	}

	@ResponseBody
	@RequestMapping("/login")
	public String login(MobileVO vo) {
		System.out.println("로그인 컨트롤러 들어옴 ::: \n"  + vo.getEmail() + "\n" + vo.getPassword());
//		service.saveToken(vo);
		return "success";
	}
	
	@ResponseBody
	@RequestMapping("/isLogin")
	public String isLogin(HttpSession session) {
		System.out.println("로그인체크 컨트롤러 들어옴 ");
		UserVO user = (UserVO)session.getAttribute("user");
		
		if(user != null) {
			System.out.println(user.getEmail());
			return user.getEmail();
		}
		System.out.println("로그인 안됨 ");
		return "";
		
	}
	
	
	
	
}
