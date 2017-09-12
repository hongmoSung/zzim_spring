package kr.co.web.controller;


import java.io.BufferedReader;
import java.io.FileReader;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.web.service.HomeService;
import kr.co.web.vo.TrackingBoardVO;

@Controller
public class HomeController {
	
	@Autowired
	private HomeService hService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home( Model model) {
		return "home";
	}
	
	@RequestMapping("/favicon.ico")
	public String favicon() {
		return "redirect:/";
	}
	

	@RequestMapping("/firebase-messaging-sw.js")
	@ResponseBody
	public String serviceWoker(HttpServletRequest request) throws Exception {
//		System.out.println("�꽌鍮꾩뒪�썙而� 李얘린 �뱾�뼱�샂?");
//		Set pathSet = request.getSession().getServletContext().getResourcePaths("/");
//		System.out.println(pathSet);	
		
		String path = request.getSession().getServletContext().getRealPath("/resources/firebase-messaging-sw.js");
//		String path = "/Users/jeongukjo/Dropbox/workspace/bit/FINAL/zzim_spring/webCrawling/src/main/webapp/resources/firebase-messaging-sw.js";
//		System.out.println(path);

		StringBuilder sb = new StringBuilder();
		String strLine;

		BufferedReader br = new BufferedReader(new FileReader(path));
		while((strLine = br.readLine())!= null) {
			sb.append(strLine);
		}

		br.close();
	    
		return sb.toString();
	}	
	
	@RequestMapping("/home/recent")
	@ResponseBody
	public List<TrackingBoardVO> recentProduct() throws Exception {
		return hService.recentProduct();
	}
	
	@RequestMapping("/home/rank")
	@ResponseBody
	public List<TrackingBoardVO> tRank() throws Exception {
		return hService.trackingRank();
	}
	
	@RequestMapping("/home/drop")
	@ResponseBody
	public List<TrackingBoardVO> drop() throws Exception{
		return hService.selectDown();
	} 

}
