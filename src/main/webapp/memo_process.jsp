<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="subway.dao.*" import="subway.dto.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	//String process_name = request.getParameter("process_name");
	//System.out.println(process_name);
	System.out.println("===========================메모 프로세스 진입성공===================================");
	request.setCharacterEncoding("utf-8");
	if (session.getAttribute("member_id") != null) {
		if (request.getParameter("memo_contents") != null) {

			String memo_contents = request.getParameter("memo_contents");
			String member_id = (String) session.getAttribute("member_id");
			System.out.println(memo_contents);

			MemberDAO memberDAO = new MemberDAO();
			boolean success = memberDAO.insertMemo(member_id, memo_contents);

			if (success) {
				System.out.println("메모 인서트 성공");

				//memo_contents = memo_contents.replaceAll("<br>", "\r\n");
				System.out.println(memo_contents);
				session.setAttribute("memo_contents", memo_contents);
			} else {

			}
		} else {
			response.sendRedirect("main.jsp");
		}
	} else {
		System.out.println("============비정상 진입 처리============");
		session.invalidate();
		response.sendRedirect("login.jsp");
	}
	%>

</body>
</html>