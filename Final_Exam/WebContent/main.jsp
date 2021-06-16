<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="stock.StockDAO"%>
<%@ page import="stock.StockDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>주식 매매일지 웹사이트</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp" style="color: black;"><strong>주식 매매일지 웹 사이트</strong></a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="stock.jsp">주식매매일지</a></li>
				<li><a href="debate.jsp">게시판</a></li>
				<li><a href="admin.jsp">관리자페이지</a></li>
			</ul>
			<%
			if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" data-toggle="dropdown"
					role="button" aria-haspopup="true" aria-expanded="false">회원관리<span
						class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>

	<section class="container">
		<h1>📈 주식 매매일지 웹사이트</h1>

		<h3>주식에 도움되는 사이트 모음</h3>
		<ul>
			<li><a href="https://finance.naver.com/main/main.nhn">https://finance.naver.com/main/main.nhn</a> </li>
			<li><a href="http://finance.daum.net/">http://finance.daum.net/</a></li>
			<li><a href="https://kr.investing.com/">https://kr.investing.com/</a></li>
		</ul>
	</section>


	<!-- <div class="container">
	<form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
	파일: <input type="file" name="file"><br>
	<input type="submit" value="업로드"><br></form>
	</div> -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>