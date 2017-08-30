package kr.co.web.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.web.service.BoardService;
import kr.co.web.service.UserService;
import kr.co.web.vo.BoardVO;
import kr.co.web.vo.ReplyVO;
import kr.co.web.vo.SearchVO;
import kr.co.web.vo.UserVO;

@Controller
@RequestMapping("/board")
public class BoardController {

	static final Logger logger = Logger.getLogger(BoardController.class);

	@Autowired
	private BoardService bService;

	@Autowired
	private UserService uService;

	// 보드
	@RequestMapping("/list")
	public Map<String, Object> list(SearchVO search) {
		return bService.readBoardList(search);
	}

	@RequestMapping("/detail")
	public String detail(int bNo, Model model, HttpServletResponse res, HttpServletRequest req, HttpSession session) {
		// 현재 게시글 번호
		String cookNo = String.valueOf(bNo);

		// 현재 id
		String id = session.getId();
		
		// 저장된 쿠키
		Cookie[] cookies = req.getCookies();
		Map mapCookie = new HashMap();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				mapCookie.put(cookies[i].getName(), cookies[i].getValue());
			}
		}

		// 저장된 쿠키중 id로 저장된 쿠키 불러오기
		String idCookie = (String) mapCookie.get(id);

		// 새로 저장될 쿠키 값
		String newCookie = "|" + cookNo;
		idCookie += "";
		if (!idCookie.contains(newCookie)) {
			Cookie cookie = new Cookie(id, idCookie + newCookie);
			cookie.setMaxAge(60 * 60 * 24);
			res.addCookie(cookie);
			model.addAttribute("hitPlus", bService.updateBoardHit(bNo));
		}
		model.addAttribute("detail", bService.readBoardDetail(bNo));
		return "/board/detail";
	}

	@RequestMapping("/delete")
	@ResponseBody
	public String deleteBoard(int bNo) {
		return bService.deleteBoard(bNo);
	}

	@RequestMapping("/writeForm")
	public void writeForm() throws Exception {
	}

	@RequestMapping("/write")
	@ResponseBody
	public String write(BoardVO board) {

		return bService.write(board);
	}

	@RequestMapping("/updateForm")
	public void upForm(int bNo, Model model) {
		model.addAttribute("detail", bService.readBoardDetail(bNo));
	}

	@RequestMapping("/update")
	@ResponseBody
	public String update(BoardVO board) {
		return bService.update(board);
	}

	// 답글
	@RequestMapping("/commentRegist")
	@ResponseBody
	@Transactional
	public void commentRegist(ReplyVO reply, UserVO user) throws UnsupportedEncodingException {
		String email = uService.checkEmail(user.getEmail());
		bService.insertReply(reply);

		// 이메일
		String host = "smtp.naver.com";
		final String adminEmail = "comboy5419@naver.com";
		final String password = "fbehdrl0)";

		String to = email;

		// Get the session object
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.auth", "true");

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(adminEmail, password);
			}
		});

		// Compose the message
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(adminEmail, "Master"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

			// 메일 제목
			message.setSubject(user.getEmail() + "님의 문의사항에 대한 답변이 도착했습니다.");

			// 메일 내용
			message.setText("답변 : " + reply.getrContent());

			// send the message
			Transport.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/commentUpdate")
	@ResponseBody
	public void commentUpdate(ReplyVO reply) {
		bService.updateComment(reply);
	}

	@RequestMapping("/commentDelete")
	@ResponseBody
	public void commentDelete(ReplyVO reply) {
		bService.deleteReply(reply);
	}

}
