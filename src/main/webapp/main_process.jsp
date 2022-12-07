<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import='subway.dao.*' import='subway.dto.*'
	import="java.util.ArrayList" import="java.util.List"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
request.setCharacterEncoding("utf-8");

if(session.getAttribute("member_id")!=null){
	
	String member_id = (String)session.getAttribute("member_id");
	
	BookmarkDAO bookDAO = new BookmarkDAO();
	List<BookmarkDTO> bookmarkList = new ArrayList();
	bookmarkList = bookDAO.selectBookmarkList(member_id);
	session.setAttribute("bookmarkList", bookmarkList);
	
	String memo_contents = (String)session.getAttribute("memo_contents");
	MemberDAO memberDAO = new MemberDAO();
	boolean success = memberDAO.insertMemo(member_id, memo_contents);
	session.setAttribute("memo_contents", memo_contents);
	
	
	response.sendRedirect("main.jsp");
	
}else{
	session.invalidate();
	response.sendRedirect("main.jsp");
}



%>

</body>
</html>