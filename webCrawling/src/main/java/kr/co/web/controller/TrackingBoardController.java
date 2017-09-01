package kr.co.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.web.service.TrackingBoardServiceImpl;
import kr.co.web.vo.TrackingBoardVO;

@Controller
@RequestMapping("/trackingBoard")
public class TrackingBoardController {

	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private TrackingBoardServiceImpl tService;
	
	
	@RequestMapping("/trackingList")
	public void trackingList(){
	}
	
	@RequestMapping("/sList")
	@ResponseBody
	public Map<String, Object> sList( TrackingBoardVO tboard) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", tService.readTrackingList(tboard.getEmail()));
		return map;
	}
	
	@RequestMapping("/scroll")
	@ResponseBody
	public Map<String, Object> scroll(TrackingBoardVO tboard) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", tService.infiniteScrollDown(tboard));
		return map;
	}
	
	@RequestMapping("/chart")
	@ResponseBody
	public List<Integer> chartt(TrackingBoardVO tboard) throws Exception {
		return tService.readChartList(tboard.getpNo());
	}
//	
	@RequestMapping("/priceUpdate")
	@ResponseBody
	public int priceUpdate(TrackingBoardVO tboard) throws Exception {
		return tService.priceUpdate(tboard);
	}

//	@RequestMapping("/delete1")
//	@ResponseBody
//	public int delete1(String[] arrr) throws Exception {
//		List<String> delList = new ArrayList<String>();
//		for(String pno : arrr) {
//			delList.add(pno);
//		}
//		return tService.deleteTracking(delList);
//	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public int delete(TrackingBoardVO tboard) throws Exception {
		System.out.println(tboard.getpNo());
		return tService.deleteTracking(tboard.getpNo());
	}
}
