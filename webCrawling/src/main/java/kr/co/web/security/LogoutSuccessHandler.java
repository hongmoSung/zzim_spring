package kr.co.web.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.logout.LogoutHandler;

public class LogoutSuccessHandler implements LogoutHandler {

	private String defaultUrl;
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	public LogoutSuccessHandler() {
		defaultUrl = "/user/loginForm?logout";
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}

	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		try {
			if (request.getParameter("mobile") != null) {
				redirectStrategy.sendRedirect(request, response, "/logoutResponse");
			} else {
				redirectStrategy.sendRedirect(request, response, defaultUrl);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
