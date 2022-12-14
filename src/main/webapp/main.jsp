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
<link rel="stylesheet" href="./css/main.css?after" type="text/css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script language="JavaScript">
	var stationNM;
	let siganButton = document.querySelector("#siganButton");
	let YeonButton = document.querySelector("#YeonButton");
	
	var broscr1 = window.matchMedia("screen and (max-width: 1500px)");
    var broscr2 = window.matchMedia("screen and (min-width: 1850px)");

        broscr1.addListener(function(e) {
            if(e.matches) {
                document.getElementById("screen_side").style.display = "none";
                document.getElementById("btn_ham").style.display = "block";
            } else {
                document.getElementById("screen_side").style.display = "inline";
                document.getElementById("btn_ham").style.display = "none";
            }
        });

        broscr2.addListener(function(e) {
            if(e.matches) {
                document.getElementById("screen_main").style.width = "75%";
                document.getElementById("screen_side").style.width = "25%";
                document.getElementById("screen_side").style.position = "static";
            } else {
                document.getElementById("screen_main").style.width = "100%";
                document.getElementById("screen_side").style.width = "350px";
                document.getElementById("screen_side").style.position = "fixed";
                document.getElementById("screen_side").style.top = "75px";
                document.getElementById("screen_side").style.right = "0";
            }
        });

        function OpenSidemenu() {
            if (document.getElementById("screen_side").style.display == "inline") {
                document.getElementById("screen_side").style.display = "none";
            } else {
                document.getElementById("screen_main").style.width = "100%";
                document.getElementById("screen_side").style.width = "350px";
                document.getElementById("screen_side").style.position = "fixed";
                document.getElementById("screen_side").style.top = "75px";
                document.getElementById("screen_side").style.right = "0";
                document.getElementById("screen_side").style.display = "inline";
            }
        }
	
	function myTimeFunction() {

		$.ajax({
			url : "${contextPath}/SubwayTime.jsp?station="+stationNM+"&type=time",
			type : "POST",
			dataType : "json",
			data : {
				station : stationNM,
				type : "time"
			} ,
			success : function(dt,status) {
				if (status == 'success') { 
				     $("#information-panel").empty();
				     var str_time="<table style='text-align:center'><th width=150>상행</th><th width=150>하행</th><tr>";
				     var indexType="";
				     var str_up_time ="";
				     var str_down_time =""; 
					 $.each(dt, function(index, item) { // 데이터 =item 
						 indexType = index; 
					     $.each(item, function(idx, iii) { 
					    	if (indexType == "UP_TIME") 
					    		str_up_time += "<li>" + iii +"</li>";
					    	else str_down_time += "<li>" + iii +"</li>"; 
					     }); 
				
			         });  
					 str_time += "<td>" + str_up_time + "</td>";
					 str_time += "<td>" + str_down_time + "</td>";
					 str_time += "</tr></table>";
					 $("#information-panel").empty();  
					 $("#information-panel").append(str_time); 
				}
			}
		});
	}
	
	function delayTrainFunction() {
		var delay = "blue";
		$.ajax({
			url : "${contextPath}/SubwayTime.jsp?station="+stationNM+"&type=delay",
			type : "POST",
			dataType : "json",
			data : {
				station : stationNM,
				type : "delay"
			} ,
			success : function(dt,status) {
				if (status == 'success') { 
					
					var str_time="<table style='text-align:center'><th width=200>상행</th><th width=200>하행</th><tr>";
					var indexType="";
				    var str_up=0;
				    var str_up_state ="";
				    var str_down =""; 
				    var str_down_state ="";
				    var str_img="";
					$.each(dt, function(index, item) { // 데이터 =item   
						if (index=="UP") 
				    		str_up = item;
				    	else if (index=="UP_STATE") 
					     	str_up_state = "(Delay:"+item +")";
				    	else if (index=="DOWN") 
				    		str_down += item;
				    	else if (index=="DOWN_STATE") 
				    		str_down_state += "(Delay:" + item +")";
						if(item == "00:00")
							delay = "blue";
						var slice_time = parseInt(item.slice(4,6));
						if(slice_time > 0){
							delay = "red";  //연착되었을 때 빨간 icon
						}
						
						
					});   
					str_time += "<td>" + str_up + str_up_state + "</td>";
					str_time += "<td>" + str_down + str_down_state + "</td>";
					str_time += "<tr height=15px><td> </td></tr>";
					if(delay == "blue"){
						str_img += "<td><img src='./img/blue_subway.png' width=100px height=150px></td>";
						str_img += "<td><img src='./img/blue_subway.png' width=100px height=150px></td>";
						//$("#delay_img").append("<img src='./img/blue_subway.png' width=100px height=100px>");
						//$("#delay_img").attr("style", "width:50px; height:50px;")
					}
					else if (delay ==  "red"){
						str_img += "<td><img src='./img/red_subway.png' width=100px height=150px></td>";
						str_img += "<td><img src='./img/red_subway.png' width=100px height=150px></td>";
						//$("#information-panel").append("<div><img src='./img/red_subway.png'></div>");
					}
					str_time += "<tr>" + str_img + "</tr>";
					
					str_time += "</tr></table>";
					$("#information-panel").empty();  
					$("#information-panel").append(str_time);  
				}
			}
		});
	}
	
	function select_station(stat, stName) {
	    console.log(stat, stName);
	    stationNM = stName;
	    
		var a = document.getElementById("select-panel").style.width;
	    document.getElementById("select-panel").style.left = String( Number(stat.getAttribute("cx")) - Number(a.slice(0, -2))/2) + "px";
	    document.getElementById("select-panel").style.top = stat.getAttribute("cy") + "px";
	    document.getElementById("stsName").innerHTML = "역이름 : " + stName;

	}
</script>
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
		<TABLE border="0" width="100%" height="100%" >
			<TR>
				<TD id="screen_main">
				
					<TABLE border="0" style="width: 100%;">
						<TR>
							<TD>									
		                       	<div class="bc" >
									<DIV id="select-panel"  style="width: 150px; left: -1000px; top: -1000px; display: block; position:absolute">
										
		                            	<p id="stsName" >역이름 : </p>
		                            	<button id="siganButton" class="asd" type="button" onclick="myTimeFunction()">시간표</button> 
		                                <button id="YeonButton" class="asd2" type="button" onclick="delayTrainFunction()" >연착정보</button>
		                            </DIV>
									
									<SVG height="715" width="100%">
                                        <G stroke="blue"
											stroke-linejoin="round" stroke-linecap="round">
                                            <PATH class="path 1 2" d="M330 510 H380" stroke-width="10"></PATH>
                                            <PATH class="path 2 3" d="M400 510 H450" stroke-width="10"></PATH>
                                            <PATH class="path 3 4" d="M470 510 H520" stroke-width="10"></PATH>
                                            <PATH class="path 4 5" d="M540 510 H590" stroke-width="10"></PATH>
                                            <PATH class="path 5 6" d="M615 510 H665" stroke-width="10"></PATH>
                                            <PATH class="path 6 7" d="M690 510 H740" stroke-width="10"></PATH>
                                            <PATH class="path 7 8" d="M755 510 H805" stroke-width="10"></PATH>
                                            <PATH class="path 8 9" d="M820 510 H870" stroke-width="10"></PATH>
                                            <PATH class="path 9 10" d="M885 510 H935" stroke-width="10"></PATH>
                                            <PATH class="path 10 11" d="M950 510 H1000" stroke-width="10"></PATH>
                                            <PATH class="path 11 12" d="M1015 510 H1065" stroke-width="10"></PATH>
                                            <PATH class="path 12 13" d="M1080 510 H1130" stroke-width="10"></PATH>
                                            <PATH class="path 13 14" d="M1145 510 H1195" stroke-width="10"></PATH>
                                            <PATH class="path 14 15" d="M1210 510 H1260" stroke-width="10"></PATH>
                                        </G>
                                        <CIRCLE class="sta 1" cx="335" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '수원')"></CIRCLE>
                                        <CIRCLE class="sta 2" cx="400" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '세류')"></CIRCLE>
                                        <CIRCLE class="sta 3" cx="470" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '병점')"></CIRCLE>
                                        <CIRCLE class="sta 4" cx="540" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '세마')"></CIRCLE>
                                        <CIRCLE class="sta 5" cx="615" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '오산대')"></CIRCLE>
                                        <CIRCLE class="sta 6" cx="690" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '오산')"></CIRCLE>
                                        <CIRCLE class="sta 7" cx="755" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '진위')"></CIRCLE>
                                        <CIRCLE class="sta 8" cx="820" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '송탄')"></CIRCLE>
                                        <CIRCLE class="sta 9" cx="885" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '서정리')"></CIRCLE>
                                        <CIRCLE class="sta 10" cx="950" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '평택지제')"></CIRCLE>
                                        <CIRCLE class="sta 11" cx="1015" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '평택')"></CIRCLE>
                                        <CIRCLE class="sta 12" cx="1080" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '성환')"></CIRCLE>
                                        <CIRCLE class="sta 13" cx="1145" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '직산')"></CIRCLE>
                                        <CIRCLE class="sta 14" cx="1210" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '두정')"></CIRCLE>
                                        <CIRCLE class="sta 15" cx="1275" cy="510" r="20" stroke="blue" stroke-width="5"
                                            fill="white" onclick="select_station(this, '천안')"></CIRCLE>
                                        
                                        <text id="tx" x="315" y="550">수원</text>
                                        <text id="tx" x="380" y="550">세류</text>
                                        <text id="tx" x="450" y="550">병점</text>
                                        <text id="tx" x="520" y="550">세마</text>
                                        <text id="tx" x="590" y="550">오산대</text>
                                        <text id="tx" x="675" y="550">오산</text>
                                        <text id="tx" x="735" y="550">진위</text>
                                        <text id="tx" x="805" y="550">송탄</text>
                                        <text id="tx" x="860" y="550">서정리</text>
                                        <text id="tx" x="915" y="550">평택지제</text>
                                        <text id="tx" x="995" y="550">평택</text>
                                        <text id="tx" x="1060" y="550">성환</text>
                                        <text id="tx" x="1125" y="550">직산</text>
                                        <text id="tx" x="1190" y="550">두정</text>
                                        <text id="tx" x="1255" y="550">천안</text>
                                        
                                    </SVG>
								</div>
							</TD>
						</TR>
					</TABLE>
				</TD>
				<TD id="screen_side" valign="top">
					<TABLE border="0" style="width: 100%; border-spacing: 0;">
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
						<TR>
							<TD bgcolor="#4682B4" style="padding: 5px;">  
							        <FONT size="5em">열차 시간정보</FONT>
								
									<DIV id="information-panel">
										
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
														<div class="${item.station_nm}"  onclick="select_station(this, '${item.station_nm}'); myTimeFunction(); ">⭐${item.station_nm}역</div>
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
	<span id="btn_ham" onclick="OpenSidemenu()">≡</span>
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
													"<div class="+bookmark_nm+" onclick='select_station(this, \""+ bookmark_nm + "\"  ); myTimeFunction(); '>"
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
