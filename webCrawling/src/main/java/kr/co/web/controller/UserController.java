package kr.co.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.web.vo.LoginDTO;
import kr.co.web.service.UserService;
import kr.co.web.vo.UserMasterVO;
import kr.co.web.vo.UserVO;

@RequestMapping("/user")
@Controller
public class UserController {

	@Autowired
	private UserService service;
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

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
	
	// 메일 중복 확인
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

	// 계정 관리 리스트
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
	public void list(String[] valueArray) {
		service.deleteMaster(valueArray);
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
		System.out.println("asdasd");
		System.out.println(user.toString());
		return service.updateMaster(user);
	}

}
