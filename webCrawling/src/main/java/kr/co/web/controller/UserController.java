package kr.co.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.web.vo.LoginDTO;
import kr.co.web.service.UserService;
import kr.co.web.vo.UserMasterVO;
import kr.co.web.vo.UserVO;

@RequestMapping("/user")
@Controller
public class UserController {

	@Autowired
	private UserService service;
	
	
	@RequestMapping("/joinForm")
	public void joinForm() {
	}

	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(UserVO user) {
		service.join(user);
		return "/user/loginForm";
	}

	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public void login(LoginDTO login, @ModelAttribute("error") String error, @ModelAttribute("logout") String logout) {
	}
	
	@RequestMapping("/emailCheck")
	@ResponseBody
	public String emailCheck(String email) {
		String check = service.checkEmail(email);
		if (check == null) {
			return "true";
		} else {
			return "false";
		}
	}

	@ResponseBody
	@RequestMapping("/makeMasterList")
	public List<UserMasterVO> list(String email) {
		return service.masterList(email);
	}
	
	@RequestMapping("/masterList")
	public void list() {
	}

	@RequestMapping("/masterDelete")
	@ResponseBody
	public String list(UserMasterVO user) {
		return service.deleteMaster(user);
	}

	@RequestMapping("/masterInsert")
	@ResponseBody
	public String write(UserMasterVO user) {
		System.out.println(user.toString());
		return service.writeMaster(user);
	}

	@RequestMapping("/masterUpdate")
	@ResponseBody
	public String update(UserMasterVO user) {
		System.out.println(user.toString());
		return service.updateMaster(user);
	}

}
