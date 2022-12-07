package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import subway.dao.BookmarkDAO;
import subway.dao.MemberDAO;
import subway.dto.BookmarkDTO;
import subway.dto.MemberDTO;

/**
 * Servlet implementation class JavaController
 */
@WebServlet("/subway/*")
public class JavaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    BookmarkDAO bookDAO = new BookmarkDAO();
    MemberDAO memberDAO = new MemberDAO();
    
    BookmarkDTO bookDTO = new BookmarkDTO();
    MemberDTO memberDTO = new MemberDTO();
    
   
	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("goGet");
		doHandle(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("goGet");
		doHandle(request, response);
	}
	
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// session 객체 만들기
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		HttpSession session = request.getSession();
		String nextPage = "";
		String action = request.getPathInfo();
		
		try {
			System.out.println("컨트롤러 진입 : "+action+"");
			
			if (action.equals("memo.do")) {
				System.out.println("되나!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				
				nextPage = "/main.jsp";
			} else if (action.equals("/login_process.do")) {
				System.out.println("되나");
			
				nextPage = "/main.jsp";
			}else if (action.equals("login_process.do")) {
				System.out.println("되나");
			
				nextPage = "/main.jsp";
			}else if(action.equals("/main.jsp")) {
				System.out.println("되나");
				nextPage = "/main.jsp";
			}else {
				nextPage = "/main.jsp";
			}
			
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
