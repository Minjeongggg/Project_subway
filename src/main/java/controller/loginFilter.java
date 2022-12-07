package controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class loginFilter
 */
@WebFilter("/subway/*")
public class loginFilter extends HttpFilter implements Filter {

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public loginFilter() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("doFilter 호출함");

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();

		String action = request.getParameter("action");
		String path1 = httpRequest.getRequestURI();
		System.out.println("action : " + action);
		System.out.println("path1 : " + path1);

		if (action == null || action.equals("login.jsp") || action.equals("login_process.jsp") || action.equals("join.jsp")
				|| action.equals("join_process.jsp") ||action.equals("main.jsp")) {
			chain.doFilter(request, response);
		} else {
			if (session.getAttribute("id") != null) {
				chain.doFilter(request, response);
			} else if (session.getAttribute("id") == null) {
				httpResponse.sendRedirect(path1 + "?action=" + "login.jsp");
			}
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
