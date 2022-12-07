<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환승역 로그인</title>
<link rel="stylesheet" href="./css/login.css">
</head>
<body>
 <header>
        <div><a href="main.jsp"><img id="header_img" src="./img/logo1.png"></a></div>
    </header>
    <div id="wrap_login">
        <div id="welcome_text">
            <div id="welcome_text1"> 환승역 페이지에 오신 것을 환영합니다!</div>
            <div id="welcome_text2"> 로그인 하시면 즐겨찾기와 메모기능을 자유롭게 이용하실 수 있습니다.</div>
        </div>
        <form id="login_form" action="login_process.jsp" accept-charset="UTF-8">
            <div id="login_inputDiv">
                <div>
                    <input type="text" name="member_id" placeholder="아이디를 입력하세요">
                </div>
                <div><input type="password" name="member_pw" placeholder="비밀번호를 입력하세요"></div>
                <div id="submit_div">
                    <input type="button" id="login_input" value="로그인">
                </div>
                <div id="cancle_login">
                    <div><a href="join.jsp">&nbsp;회원가입</a></div>
                    <div>&nbsp;|&nbsp;</div>
                    <div><a href="main.jsp"> 메인페이지로 돌아가기&nbsp;</a></div>
                </div>
            </div>
        </form>
    </div>
</body>
<script>
    window.onload = function (e) {

        let input_submit = document.querySelector("#submit_div input[id='login_input']");
        input_submit.addEventListener("click", function () {
            let form = document.querySelector("form#login_form");
           
            let member_id = document.querySelector("input[name='member_id']").value;
            let member_pw = document.querySelector("input[name='member_pw']").value;
           
            if (member_id == '' || member_pw == '' ) {
                alert("빈칸없이 입력해 주세요");
            } else {
                form.action = './login_process.jsp';
                form.method = 'POST';
                form.submit();
            }
        })
    }
</script>
</html>