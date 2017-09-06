package kr.co.web.controller;


import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home( Model model) {
		return "home";
	}

	
	   
	@RequestMapping("/firebase-messaging-sw.js")
	@ResponseBody
	public String serviceWoker(HttpServletRequest request) throws Exception {
//		System.out.println("서비스워커 찾기 들어옴?");
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

}
