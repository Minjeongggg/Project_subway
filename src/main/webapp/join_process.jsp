<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="subway.dao.*" import="subway.dto.*"
	import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
System.out.println("===========================join 프로세스 진입성공===================================");
request.setCharacterEncoding("utf-8");

if (request.getParameter("member_id") != null) {
	MemberDAO memberDAO = new MemberDAO();
	MemberDTO memberDTO = new MemberDTO();

	String member_id = request.getParameter("member_id");
	String member_pw = request.getParameter("member_pw");
	String member_name = request.getParameter("member_name");
	String member_email = request.getParameter("member_email");
	String member_nickname = request.getParameter("member_nickname");

	out.println(member_id);
	out.println(member_pw);
	System.out.println(member_name);
	out.println(member_email);
	out.println(member_nickname);

	if (member_id != "" && member_pw != "" && member_name != "" && member_email != "" && member_nickname != "") {
		System.out.println("=" + member_id + "=로 회원가입 시도");

		memberDTO.setMember_id(member_id);
		memberDTO.setMember_pw(member_pw);
		memberDTO.setMember_name(member_name);
		memberDTO.setMember_email(member_email);
		memberDTO.setMember_nickname(member_nickname);

		boolean success = memberDAO.insertMember(memberDTO);

		out.println(success);

		if (success) {

	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('회원가입 되었습니다 !')");
	script.println("location.href= 'login.jsp'");
	script.println("</script>");

	//request.setAttribute("login_success",true);
	//response.sendRedirect("login.jsp");
		} else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('회원가입에 실패하였습니다. 다시 시도해 주세요')");
	script.println("location.href= 'join.jsp'");
	script.println("</script>");

	//System.out.println("실패");
	//request.setAttribute("login_success",false);
	//response.sendRedirect("join.jsp");
		}

	} else {
		request.setAttribute("login_success", false);
		response.sendRedirect("join.jsp");
	}

} else {
	System.out.println("============비정상 진입 처리============");
	session.invalidate();
	response.sendRedirect("join.jsp");
}
%>
<body>


</body>
</html>