<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="subway.dao.*" import="subway.dto.*"
 import ="java.io.PrintWriter"
 import ="java.util.ArrayList"
import ="java.util.List"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  
	<%
System.out.println("============로그인프로세스 진입============");
PrintWriter script = response.getWriter();
request.setCharacterEncoding("utf-8");
	if (request.getParameter("member_id") != null &&  request.getParameter("member_pw") != null) {
		System.out.println("============로그인작업 진입============");
		String member_id = (String) request.getParameter("member_id");
		String member_pw = (String) request.getParameter("member_pw");

		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMember_id(member_id);
		memberDTO.setMember_pw(member_pw);

		MemberDAO memberDAO = new MemberDAO();
		MemberDTO memberDTO2 = new MemberDTO();
		memberDTO2 = memberDAO.selectMember(memberDTO);

		String db_id = memberDTO2.getMember_id();
		String db_pw = memberDTO2.getMember_pw();
	
		System.out.println(db_id+" "+db_pw);
		System.out.println(member_id+" "+member_pw);
		
		if (member_id.equals(db_id) && member_pw.equals(db_pw)) {
			System.out.println("진입성공");
			
			session.setAttribute("member_id", db_id);
			session.setAttribute("member_nickname", memberDTO2.getMember_nickname());
			session.setAttribute("memo_contents", memberDTO2.getMemo_contents());
			
			
			BookmarkDAO bookmarkDAO = new BookmarkDAO();
			List<BookmarkDTO> bookmarkList = new ArrayList();
			bookmarkList = bookmarkDAO.selectBookmarkList(member_id);
			session.setAttribute("bookmarkList",bookmarkList);
			
			script.println("<script>");
			script.println("alert('환영합니다. " + memberDTO2.getMember_nickname() + "님!')");
			script.println("location.href= 'main.jsp' ");
			script.println("</script>");

		} else {

			script.println("<script>");
			script.println("alert('일치하는 회원정보가 없습니다.')");
			script.println("location.href= 'login.jsp'");
			script.println("</script>");
		}

	}else if(request.getParameter("input_logout") != null){
		System.out.println("============로그아웃 진입============");
		session.invalidate();
		response.sendRedirect("login.jsp");
		
	}else{
		System.out.println("============비정상 진입 처리============");
		session.invalidate();
		response.sendRedirect("login.jsp");
		
	}
	
	%>
	
	-->
</body>
</html>