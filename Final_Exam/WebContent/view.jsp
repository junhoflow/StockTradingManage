<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="debate.Debate"%>
<%@ page import="debate.DebateDAO"%>
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
	int debateID = 0;
	if(request.getParameter("debateID") != null){
		debateID = Integer.parseInt(request.getParameter("debateID"));
	}
	if(debateID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'debate.jsp'");
		script.println("</script>");
	}
	Debate debate = new DebateDAO().getDebate(debateID);
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
				<li class="active"><a href="debate.jsp">게시판</a></li>
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
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
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
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판
							글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<td style="width: 20%;">글 제목</td>
					<td colspan="2"><%= debate.getDebateTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","br") %></td>
					</tr>
					<tr>
					<td>작성자</td>
					<td colspan="2"><%= debate.getUserID() %></td>
					</tr>
					<tr>
					<td>작성일자</td>
					<td colspan="2"><%= debate.getDebateDate().substring(0, 11) + debate.getDebateDate().substring(11, 13) + "시"
							+ debate.getDebateDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
					<td>내용</td>
					<td colspan="2" style="min-height: 200px; text-align: left;"><%= debate.getDebateContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","br") %></td>
					</tr>
				</tbody>
			</table>
			<a href="debate.jsp" class="btn btn-primary">목록</a>
			<%
			if(userID !=null && userID.equals(debate.getUserID())){
			%>
			<a href="update.jsp?debateID=<%= debateID %>" class="btn btn-primary">수정</a>
			<a onclick="return confirm('게시글을 삭제하시겠습니까?')" href="deleteAction.jsp?debateID=<%= debateID %>" class="btn btn-primary">삭제</a>
			<%
			}
			%>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>