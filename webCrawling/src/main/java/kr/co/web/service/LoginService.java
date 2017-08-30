package kr.co.web.service;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.co.web.mapper.UserMapper;
import kr.co.web.vo.UserVO;

public class LoginService implements UserDetailsService {
	
	@Autowired 
	UserMapper userMapper;
	
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)  {
		String pass = request.getParameter("password");
		System.out.println(pass);
	}
	
	@SuppressWarnings("unused")
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		System.out.println(email);
		UserVO userVO = userMapper.selectUser(email);
		System.out.println("로그인?? : " + userVO.toString());
			if (userVO == null) {
			    throw new UsernameNotFoundException("No user found with username" + userVO.getEmail());
			}
		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
	    roles.add(new SimpleGrantedAuthority("ROLE_USER"));	
	    
	   /* 
		System.out.println("원본 비밀번호" + userVO.getPassword());
		String password = userVO.getPassword();

		String passwordHash = "";

		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(password.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			passwordHash = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			passwordHash = null;
		}
		userVO.setPassword(passwordHash);
		System.out.println("해싱 비밀번호 : " + passwordHash);
	    */
	    System.out.println("비밀번호 : " + userVO.getPassword());
	    UserDetails user = new User(email, userVO.getPassword(), roles);
	           return user;
		}
	}



