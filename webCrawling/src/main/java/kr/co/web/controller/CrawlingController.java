package kr.co.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.swing.text.Document;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.HttpResponseException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.web.vo.UserVO;

@Controller
@RequestMapping("/crawling")
public class CrawlingController {

	private CloseableHttpClient httpClient = HttpClients.createDefault();
	private HttpGet httpGet;
	
	@RequestMapping("/cart")
	public void cart(Model model, HttpSession session) {
		
//		UserVO user = (UserVO)session.getAttribute("user");
//		String email = user.getEmail();
//		String nodeServer = "192.168.0.36";
//		String nodePort = ":3003";
//		String url = "http://"+nodeServer+nodePort;
//		
//		System.out.println(email);
//		
//		
//		try {
//			httpGet = new HttpGet(url+"/cart?email="+email);
//			CloseableHttpResponse response = httpClient.execute(httpGet);
//
//			System.out.println(response.getStatusLine());
//			HttpEntity entity = response.getEntity();
//			EntityUtils.consume(entity);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
		
	}
	
	@ResponseBody
	@RequestMapping(value ="/cart", method=RequestMethod.POST)
	public void cartPost() {
		
	}
}













