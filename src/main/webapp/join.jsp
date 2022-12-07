<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "subway.dao.*"
    import = "subway.dto.*"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="./css/join.css">
</head>
<body>
<%
	MemberDTO memberDTO = new MemberDTO();
	if(request.getAttribute("login_success") != null){
		boolean login_success = (boolean)request.getAttribute("login_success");
		System.out.println(login_success);
	}
%>
	<header>
        <div><a href="main.jsp"><img id="header_img" src="./img/logo1.png"></a></div>
    </header>
    <div id="wrap_join">
        <div id="welcome_text">
            <div id="join_text1"> 환승역 페이지에 오신 것을 환영합니다!</div>
            <div id="join_text2"> 회원가입을 하시면 즐겨찾기와 메모기능을 자유롭게 이용하실 수 있습니다.</div>
        </div>
        <form id="join_form" action="join_process.jsp" method="post" accept-charset="UTF-8">
            <div id="join_inputDiv">
                <div>
                    <input type="text" name="member_id" placeholder="사용할 아이디를 입력하세요">
                    <div id="idCheck_div"><input type="button" id="idCheck_btn" value="중복확인"></div>
                    <input type="hidden" name="id_check" value="false">
                </div>
                <div><input type="password" name="member_pw" placeholder="사용할 비밀번호를 입력하세요"></div>
                <div><input type="password" name="member_pw2" placeholder="비밀번호를 다시 입력하세요"></div>
                <br>
                 <div><input type="text" name="member_name" placeholder="이름을 입력하세요"></div>
                <div><input type="email" name="member_email" placeholder="이메일을 입력하세요"></div>
                <div><input type="text" name="member_nickname" placeholder="사용할 닉네임을 입력하세요"></div>
                <div id="submit_div">
                    <input id="submit" type="submit" value="회원가입">
                </div>
            </div>
        </form>
        <div id="reset_join"><a href="login.jsp">로그인페이지로 돌아가기</a></div>
    </div>
</body>

  <script>
  window.onload = function (e) {
	  
	  //var login_success = document.getAttribute("login_success");

      // let idCheck_btn = document.querySelector("input idCheck_btn");
      // idCheck_btn.addEventListener("click", function(){
          
      // })

      let input_submit = document.querySelector("#submit_div input[id='submit']");
      input_submit.addEventListener("click", function () {
          let form = document.querySelector("form#join_form");
          let id_check = document.querySelector("input[name='id_check']").value;

          let member_id = document.querySelector("input[name='member_id']").value;
          let member_pw = document.querySelector("input[name='member_pw']").value;
          let member_pw2 = document.querySelector("input[name='member_pw2']").value;
          let member_name = document.querySelector("input[name='member_name']").value;
          let member_email = document.querySelector("input[name='member_email']").value;
          let member_nickname = document.querySelector("input[name='member_nickname']").value;

          if (member_id == '' || member_pw == '' || member_pw2 == '' ||
              member_name == '' || member_email == '' || member_nickname == '') {
              alert("빈칸없이 입력해 주세요");
          } 
          // else if (id_check = false) {
          //     alert("아이디 중복체크 필요");
          // } 
          else if (member_pw != member_pw2) {
              alert("비밀번호와 확인이 일치하지 않습니다.");
          } else {
        	  let form = document.querySelector("#submit");
        	  form.action = './join_process.jsp';
              form.mothod = 'POST';
              form.submit();
          }
      })
  }
</script>
</html>