<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<title>Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
	integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<script>
	$.fn.checkUserId = function() { //사용자 ID 중복 체크 플러그인 
		var self = this;
		var idInput = this.closest('.form-group').find('input'); // 사용자 ID 입력 input
		var msgSpan = this.next(); // 처리 결과 출력 메시지 span 
		var submitBtn = $('#submitBtn'); // 속성선택자 :

		self.click(function() {
			var userid = idInput.val();

			console.log(userid)
			if (userid == "")
				return alert('아이디를 입력하세요.');

			$.ajax({
				type : "GET",
				url : "${contextPath}/user/id-check/" + userid,
				contentType : "application/json",
				charset : "utf-8",
				dataType : "text",
				success : function(data) {
					data = JSON.parse(data);
					console.log(data.result);
					if (data.result == 'ok') {
						console.log(data.message);
						msgSpan.html(data.message).removeClass('.error');
						alert('사용가능한 ID 입니다.');
						submitBtn.prop('disabled', false);
					} else {
						console.log(data.message);
						msgSpan.html(data.message).addClass('.error');
						alert('아이디가 이미 존재합니다.');
						submitBtn.prop('disabled', true);
					}
				}
			});

			idInput.change(function() { // id 입력창 내용 변경시
				msgSpan.html('ID 중복 체크를 하세요.').removeClass('.error');
				submitBtn.prop('disabled', true);
				self.prop('disabled', false);
			});
		});
	}

	$.fn.checkPasswd = function() {
		this.submit(function(e) { // 폼이 전송될 때
			console.log('두 비밀번호가 일치하는지 검사합니다.')
			e.preventDefault(); // 전송되지 않도록 모든 이벤트 막음

			var passwd1 = $('#passwd').val();
			var passwd2 = $('#passwdCheck').val();

			if (passwd1 == passwd2) {
				console.log('비번 일치');
				var userid = $('#userid').val();

				this.submit();

				alert(userid + "님 환영합니다.");
			} else {
				alert('비밀번호가 일치하지 않습니다.');
			}
		});
	}

	$.fn.cancle = function() {
		var self = this;

		self.click(function() {
			var form = self.closest('form')
			//console.log(form.find('input'));
			form.find('input').val('');
		});
	}

	$(function() {
		$('#userIdCheck').checkUserId();

		$('#user').checkPasswd(); // 폼 검사

		$('#cancleBtn').cancle();

		$('#joinBtn').on("click", function() {
			location = '${contextPath}/user/join';
		});
		$("#loginBtn").on("click", function() {
			location = '${contextPath}/user/login';
		});
	});
</script>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand" href="/clean"><i class="fas fa-recycle"></i> 깨끗한도시</a>
		<button class="navbar-toggler" data-toggle="collapse"
			data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse flex-row-reverse"
			id="collapsibleNavbar">
			<ul class="nav navbar-nav float-lg-right">
				<li class="nav-item mr-sm-2"><button id="loginBtn"
						type="button" class="btn btn-light m-1">로그인</button></li>
				<li class="nav-item mr-sm-2"><button id="joinBtn" type="button"
						class="btn btn-light m-1">회원가입</button></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<h3 class="m-4">
				<i class="fas fa-user-cog"></i> 회원가입
			</h3>
			<form:form modelAttribute="user">
				<div class="form-group m-4">
					<label for="userid"><i class="fas fa-user"></i> 아이디</label>
					<button type="button" id="userIdCheck"
						class="btn btn-dark btn-sm id-check">
						<i class="fas fa-user-check"></i> 중복체크
					</button>
					<span id="message"></span>
					<form:input type="text" id="userid" path="userid"
						class="form-control" />
					<form:errors path="userid" element="div" cssClass="error" />
				</div>
				<div class="form-group m-4">
					<label for="passwd"><i class="fas fa-lock"></i> 비밀번호</label>
					<form:input type="password" path="passwd" class="form-control" />
					<form:errors path="passwd" element="div" cssClass="error" />
				</div>
				<div class="form-group m-4">
					<label for="passwdCheck"><i class="fas fa-lock"></i> 비밀번호 확인</label>
					<form:input type="password" path="passwdCheck" class="form-control" />
					<form:errors path="passwdCheck" element="div" cssClass="error" />
				</div>
				<div class="form-group m-4">
					<label for="email"><i class="fas fa-envelope"></i> 이메일</label>
					<form:input tpye="email" path="email" class="form-control" />
					<form:errors path="email" element="div" cssClass="error" />
				</div>
				<div class="form-group m-4">
					<label for="address"><i class="fas fa-map-marker-alt"></i>주소</label>
					<form:input type="text" path="address" class="form-control" />
					<form:errors path="address" element="div" cssClass="error" />
				</div>
				<div class="form-group m-4">
					<label for="phone"><i class="fas fa-phone"></i> 전화번호</label>
					<form:input type="phone" path="phone" class="form-control" />
					<form:errors path="phone" element="div" cssClass="error" />
				</div>
				<div class="container text-center mt-4">
					<button id="submitBtn" type="submit" class="btn btn-secondary" disabled>회원가입</button>
					<button id="cancleBtn" type="button" class="btn btn-danger">다시작성</button>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>