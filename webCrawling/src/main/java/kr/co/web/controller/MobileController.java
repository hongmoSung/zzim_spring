package kr.co.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.web.service.MobileService;
import kr.co.web.vo.MobileVO;

@RestController
@RequestMapping("/mobile")
public class MobileController {
	
	@Autowired
	private MobileService service;
	
	@ResponseBody
	@RequestMapping("/saveToken")
	public void saveToken( MobileVO vo) {
		//System.out.println("컨트롤러 들어옴 ::: \n" + vo.getEmail() + "\n" + vo.getToken());
		service.saveToken(vo);
	}
	
	
	
}
