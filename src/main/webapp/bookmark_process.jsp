<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import='subway.dao.*' import='subway.dto.*'
	import="java.util.ArrayList" import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	System.out.println("===========================북마크 프로세스 진입성공===================================");
	request.setCharacterEncoding("utf-8");
		if (session.getAttribute("member_id") != null) {
			
			
			if (request.getParameter("station_cd") != null) {
				
				String member_id = (String) session.getAttribute("member_id");
				int station_cd = Integer.parseInt(request.getParameter("station_cd"));
				System.out.println(station_cd);

				BookmarkDAO bookDAO = new BookmarkDAO();
				boolean already_check = bookDAO.checkBookmark(member_id, station_cd);

				System.out.println(already_check);
				System.out.println(already_check);
				System.out.println(already_check);
		
				if (already_check == false) {
					System.out.println("============북마크 추가시도============");
					boolean result = bookDAO.insertBookmark(member_id, station_cd);
					if (result) {
						System.out.println("============새 북마크 추가 성공============");
						List<BookmarkDTO> bookmarkList = new ArrayList();
						bookmarkList = bookDAO.selectBookmarkList(member_id);
						session.setAttribute("bookmarkList", bookmarkList);
					}
			   	} else {
					System.out.println("============북마크 삭제시도============");
					boolean result = bookDAO.deleteBookmark(member_id, station_cd);
					if (result) {
						System.out.println("============기존 북마크 삭제 성공============");
						List<BookmarkDTO> bookmarkList = new ArrayList();
						bookmarkList = bookDAO.selectBookmarkList(member_id);
						session.setAttribute("bookmarkList", bookmarkList);
					}
				}
				
			} else {
					response.sendRedirect("main.jsp");
			}
			
			
		}else{
			System.out.println("============비정상 진입 처리============");
			session.invalidate();
			response.sendRedirect("login.jsp");
		}
	%>

</body>
</html>