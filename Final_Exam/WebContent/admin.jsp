<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.util.ArrayList"%>
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
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				<li><a href="main.jsp">메인</a></li>
				<li><a href="stock.jsp">주식매매일지</a></li>
				<li><a href="debate.jsp">게시판</a></li>
				<li class="active"><a href="admin.jsp">관리자페이지</a></li>
			</ul>
			<%
			if (userID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인이 필요합니다.')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
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
				if(!userID.equals("junho604")){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('관리자만 출입가능합니다.')");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
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

	<div class="container">
		<h3>🔐 관리자 페이지</h3>
		<p>회원들의 정보를 관리할 수 있습니다.</p>
		<%
		UserDAO userDAO = new UserDAO();
		ArrayList<User> list = userDAO.getList(pageNumber);
		%>
		<p><strong>총 회원 수 : </strong><span style="font-size: 19px"><%=list.size() %></span></p>
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">아이디</th>
						<th style="background-color: #eeeeee; text-align: center;">비밀번호</th>
						<th style="background-color: #eeeeee; text-align: center;">이름</th>
						<th style="background-color: #eeeeee; text-align: center;">성별</th>
						<th style="background-color: #eeeeee; text-align: center;">이메일</th>
						<th style="background-color: #eeeeee; text-align: center; color:red;">관리</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getUserNum()%></td>
						<td><%=list.get(i).getUserID()%></a></td>
						<td><%=list.get(i).getUserPassword()%></td>
						<td><%=list.get(i).getUserName()%></td>
						<td><%=list.get(i).getUserGender()%></td>
						<td><%=list.get(i).getUserEmail()%></td>
						<td><a onclick="return confirm('회원정보를 삭제하시겠습니까?')"
								href="deleteUserAction.jsp?userNum=<%=list.get(i).getUserNum()%>">탈퇴</a></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			if(pageNumber != 1){
			%>
			<a href="debate.jsp?pageNumber=<%=pageNumber -1 %>"
				class="btn btn-success btn-arraw-left">이전</a>
			<%
			} if(userDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="debate.jsp?pageNumber=<%=pageNumber + 1 %>"
				class="btn btn-success btn-arraw-left">다음</a>
			<%
			}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>