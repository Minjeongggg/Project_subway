<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import='subway.dao.*' import='subway.dto.*'
	import="java.util.ArrayList" import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${ pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환승역</title>
<link rel="stylesheet" href="./css/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<%
String member_id = (String) session.getAttribute("member_id");
System.out.println(member_id);

List<BookmarkDTO> bookmarkList = (ArrayList) session.getAttribute("bookmarkList");
%>
<body>
	<header>
		<div>
			<a href="main_process.jsp"><img id="header_img"
				src="./img/logo1.png"></a>
		</div>
	</header>
	<div id="wrap_main">
		<TABLE border="1" width="100%" height="100%">
			<TR>
				<TD style="width:75%;">
					<TABLE border="1" style="width: 100%;">
						<TR>
							<TD>
								<p
									style="background-image: url('subway_map.png'); background-repeat: no-repeat;">
									<SVG height="600" width="900">
                                        <G stroke="blue"
											stroke-linejoin="round" stroke-linecap="round">
                                            <PATH class="path 1 2"
											d="M100 500 H150" stroke-width="10"></PATH>
                                            <PATH class="path 2 3"
											d="M150 500 H200" stroke-width="10"></PATH>
                                            <PATH class="path 3 4"
											d="M200 500 H250" stroke-width="10"></PATH>
                                            <PATH class="path 4 5"
											d="M250 500 H300" stroke-width="10"></PATH>
                                            <PATH class="path 5 6"
											d="M300 500 H350" stroke-width="10"></PATH>
                                            <PATH class="path 6 7"
											d="M350 500 H400" stroke-width="10"></PATH>
                                            <PATH class="path 7 8"
											d="M400 500 H450" stroke-width="10"></PATH>
                                            <PATH class="path 8 9"
											d="M450 500 H500" stroke-width="10"></PATH>
                                            <PATH class="path 9 10"
											d="M500 500 H550" stroke-width="10"></PATH>
                                            <PATH class="path 10 11"
											d="M550 500 H600" stroke-width="10"></PATH>
                                            <PATH class="path 11 12"
											d="M600 500 H650" stroke-width="10"></PATH>
                                            <PATH class="path 12 13"
											d="M650 500 H700" stroke-width="10"></PATH>
                                            <PATH class="path 13 14"
											d="M700 500 H750" stroke-width="10"></PATH>
                                            <PATH class="path 14 15"
											d="M750 500 H800" stroke-width="10"></PATH>
                                        </G>
                                        <CIRCLE class="sta 1" cx="100"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 2" cx="150"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 3" cx="200"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 4" cx="250"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 5" cx="300"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 6" cx="350"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 7" cx="400"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 8" cx="450"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 9" cx="500"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 10" cx="550"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 11" cx="600"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 12" cx="650"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 13" cx="700"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 14" cx="750"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                        <CIRCLE class="sta 15" cx="800"
											cy="500" r="10" stroke="blue" stroke-width="5" fill="white"></CIRCLE>
                                    </SVG>
								</p>
							</TD>
						</TR>
					</TABLE>
				</TD>
				<TD valign="top" style="width:25%;">
					<TABLE border="1" style="width: 100%;">
						<TR>
							<TD bgcolor="#AFEEEE">
								<DIV align="center" style="display: block; padding: 10px;">
									<%
									if ((String) session.getAttribute("member_id") == null) {
									%>
									<A href="login_process.jsp"><FONT size="6em">로그인</FONT></A>
									<%
									} else {
									%>
									<FONT size="6em">환영합니다 <%=session.getAttribute("member_nickname")%>
										님!
									</FONT> <br>
									<form action="login_process.jsp" id="form_logout"
										accept-charset="UTF-8">
										<input type="hidden" name="input_logout" value="true">
										<input type="button" id="btn_logout" value="로그아웃">
									</form>
									<%
									}
									%>
								</DIV>
							</TD>
						</TR>
						<%
						if ((String) session.getAttribute("member_id") != null) {
						%>
						<TR>
							<TD bgcolor="#4682B4" style="padding: 5px;"><FONT size="5em">즐겨찾기</FONT>
								<input type="button" id="btn_addBookmark" value="+"></TD>
						</TR>


						<tr>
							<td>
								<div id="pop">
									<form action="tour_info_1.html" id="form_bookmark"
										accept-charset="UTF-8">
										<div id="subway_div">

											<c:forEach var="item" items="${bookmarkList}" varStatus="i">
												<input type="checkbox" style="display: none;"
													name="subway_nm" id="subway_${i.index}" class="subway_nm"
													value="${item.station_cd}">
												<c:if test="${! empty item.member_id}">
													<label for="subway_${i.index}">
														<div class="${item.station_nm}">⭐${item.station_nm}역</div>
													</label>
												</c:if>
												<c:if test="${empty item.member_id}">
													<label for="subway_${i.index}">
														<div class="${item.station_nm}">${item.station_nm}역</div>
													</label>
												</c:if>
											</c:forEach>


										</div>
									</form>
								</div>
							</td>
						</tr>
						<TR>
							<TD>
								<TABLE border="1" width="100%" height="40%">
									<TR>
										<TD bgcolor="LightSteelBlue">
											<div id="bookmarked_div">

												<c:forEach var="item" items="${bookmarkList}" varStatus="i">
													<c:if test="${! empty item.member_id}">
														<div class="${item.station_nm}">⭐${item.station_nm}역</div>
													</c:if>
												</c:forEach>


											</div>
										</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
						<TR>
							<TD bgcolor="#4682B4" style="padding: 5px;"><FONT size="5em">메모</FONT>
							</TD>
						</TR>
						<TR>
							<TD bgcolor="LightSteelBlue">
								<form id="form_memo" accept-charset="UTF-8">
									<textarea id="memo_contents" name="memo_contents" type="text"
										style="width: 100%; height: 250px;" value="" wrap="hard">${memo_contents}</textarea>
									<input id="memo_submit" type="button" value="저장"
										style="width: 100%; height: 40px;">
								</form>
							</TD>
						</TR>
						<%
						}
						%>
					</TABLE>
				</TD>
			</TR>
		</TABLE>

	</div>
</body>

<script>
	window.onload = function() {

		
		// 1. 북마크 등록 스크립트
		function bookmark_do(e) {
			let list_check = $("#subway_div label");

			for (let i = 0; i < list_check.length; i++) {
				list_check[i]
						.addEventListener(
								"click",
								function(e) {
									let target = event.target;
									//alert(target);

									var bookmark_nm = $(target).text();
									bookmark_nm = bookmark_nm.replaceAll('⭐',
											'');
									bookmark_nm = bookmark_nm.replaceAll(' ',
											'');
									bookmark_nm = bookmark_nm.replace('역', '');

									//alert("별 빼기 시도: "+bookmark_nm);

									let label_for = target.parentNode
											.getAttribute("for");
									//alert(label_for);
									let bookmark_value = $(
											"input[id=" + label_for + "]")
											.val();
									//alert(bookmark_value);

									$.ajax({
												url : "${contextPath}/bookmark_process.jsp",
												type : "post",
												dataType : "json",
												data : {
													station_cd : bookmark_value
												}
											});

									//star_update
									function star_update() {
										let text = $(target).text();
										console.log("원래 텍스트 : " + text);
										if (text.includes('⭐')) {
											text = text.replaceAll('⭐', '')
											text = text.replaceAll(' ', '');
											console.log("지운 후 텍스트 : " + text);
											$(target).text(text);
										} else {
											$(target).text("⭐" + text);
										}
									}
									star_update();

									// bookmark_update
									function bookmark_update() {
										let list_bookmarked = new Array();
										list_bookmarked = $("#bookmarked_div")
												.children();
										let alredy_in;
										let same_class;

										for (let i = 0; i < list_bookmarked.length; i++) {
											console.log("중요");
											console.log(bookmark_nm);
											console
													.log(list_bookmarked[i].className);

											if (bookmark_nm == list_bookmarked[i].className) {
												same_class = list_bookmarked[i].className;
												alredy_in = true;
											}

										}

										console.log("같은 이름 :" + same_class);

										if (alredy_in) {
											let list_children = $(
													"#bookmarked_div")
													.children();

											for (let i = 0; i < list_children.length; i++) {
												if (list_children[i].className == same_class) {
													list_children[i].remove();
												}
											}
										} else {
											$("#bookmarked_div").append(
													"<div class="+bookmark_nm+">"
															+ "⭐" + bookmark_nm
															+ "역 </div>");
										}

									}

									bookmark_update();

								})
			}
		}

		bookmark_do();
		
		
		// 2. 북마크 +/- show 스크립트
		$('#btn_addBookmark').off('click').on('click', function() {
			//alert("test");

			if ($('#pop').css('display') == 'none') {
				$('#btn_addBookmark').attr("value", "-")
				console.log($('#btn_addBookmark').val());
				$('#pop').show();
			} else {
				$('#btn_addBookmark').attr("value", "+")
				$('#pop').hide();
			}

		});
		

        // 3. 메모 submit ajax
		$('#memo_submit').off("click").on("click", function() {

			// alert("memo_submit");
			let memo_contents = $("#memo_contents").val();
			console.log("memo: " + memo_contents);
			$.ajax({
				url : "${contextPath}/memo_process.jsp",
				type : "POST",
				dataType : "json",
				data : {
					memo_contents : memo_contents,
					process_name : "insert_memo"
				}
			});
		})
		
		// 4. 로그아웃 ajax
		let btn_logout = document.querySelector("#btn_logout");

		btn_logout.addEventListener("click", function() {
			let logout = confirm("로그아웃 하시겠습니까?");
			if (logout) {
				let form = document.querySelector("#form_logout");
				form.action = "login_process.jsp";
				form.method = "post";
				form.submit();
			} else {
				return;
			}
		})

		//=========window.onload끝
	}
</script>


</html>