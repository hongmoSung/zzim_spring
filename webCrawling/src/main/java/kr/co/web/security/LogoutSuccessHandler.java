package kr.co.web.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

public class LogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		if (authentication != null) {
			if (request.getParameter("mobile") != null) {
				setDefaultTargetUrl("/logoutResponse");
			} else {
				setDefaultTargetUrl("/user/loginForm?logout");
			}
		}

		super.onLogoutSuccess(request, response, authentication);
		
	}
}

/*public class LogoutSuccessHandler implements LogoutHandler {
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		try {
			if (request.getParameter("mobile") != null) {
				redirectStrategy.sendRedirect(request, response, "/logoutResponse");
			} else {
				redirectStrategy.sendRedirect(request, response, "/user/loginForm?logout");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
*/