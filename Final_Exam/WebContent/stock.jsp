<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="stock.StockDAO"%>
<%@ page import="stock.StockDTO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>주식 매매일지 웹사이트</title>
<style>
table tbody th {
	width: 90px;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	background: #ececec;
}

table td {
	width: 350px;
	padding: 10px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}
</style>
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
	int stockID = 0;
	if (request.getParameter("stockID") != null) {
		stockID = Integer.parseInt(request.getParameter("stockID"));
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
			<a class="navbar-brand" href="main.jsp" style="color: black;"><strong>주식
					매매일지 웹 사이트</strong></a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="stock.jsp">주식매매일지</a></li>
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
		<h3>📋 주식 매매일지</h3>
		하루도 빠짐없이 매매일지를 작성하여 매매실력을 키워보세요.
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#myModal" style="float: right;">매매일지 작성하기</button>
		<hr>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">오늘의 매매 기록하기</h4>
					</div>
					<div class="modal-body">
						<form method="post" action="stockAddAction.jsp">
							<div class="form-group col-sm-8">
								<label>주식 이름</label> <input type="text" name="stockName"
									class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-4">
								<label>매매종류</label><br> <input type="radio"
									style="width: 20px; height: 20px; border: 1px;" name="buysell"
									value="매수"><strong>매수</strong> <input type="radio"
									style="width: 20px; height: 20px; border: 1px;" name="buysell"
									value="매도">매도
							</div>
							<br>
							<div class="form-group col-sm-6">
								<label>체결 수량</label> <input type="text" name="stockQuantity"
									class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>체결 가격</label> <input type="text" name="stockPrice"
									class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-12">
								<label>매매 이유</label>
								<textarea name="buyReason" class="form-control" maxlength="2048"
									style="height: 180px"></textarea>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">닫기</button>
								<button type="submit" class="btn btn-primary">저장하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<%
			StockDAO stockDAO = new StockDAO();
			ArrayList<StockDTO> list = stockDAO.getList(pageNumber);
			for (int i = 0; i < list.size(); i++) {
				if (userID != null && userID.equals(list.get(i).getUserID())) {
					if (list.get(i).getBuysell().equals("매도")) {
			%>
			<div class="card">
				<div class="card-header bg-light" style="padding: 1px 150px">
					<div class="col-8 text-left"
						style="font-size: 20px; background-color: #FBDEA2;"><%=list.get(i).getTodayDate().substring(0, 11)%></div>
					<div class="col-4 text-right" style="font-size: 25px">
						<span style="background-color: #6799FF; color: white;"><%=list.get(i).getBuysell()%></span>
					</div>
				</div>
				<div class="card-body" style="padding: 1px 170px">
					<h3 class="card-title">
						<strong><%=list.get(i).getStockName()%></strong>
					</h3>
					<p class="card-text" style="font-size: 19px">
						매매이유 :
						<%=list.get(i).getBuyReason()%></p>
					<div class="row">
						<div class="col-9 text-left">
							<span style="font-size: 17px">체결수량 : </span>&nbsp;<strong><%=list.get(i).getStockQuantity()%></strong>개&nbsp;&nbsp;/&nbsp;
							<span style="font-size: 17px">체결가격 : </span>&nbsp;<strong><%=list.get(i).getStockPrice()%></strong>원
						</div>
						<div style="float: right;">
							<a onclick="return confirm('매매기록을 삭제하시겠습니까?')"
								href="deleteStockAction.jsp?stockID=<%=list.get(i).getStockID()%>">삭제</a>
						</div>
					</div>
				</div>
			</div>
			<hr>
			<%
			} else {
			%>
			<div class="card">
				<div class="card-header bg-light" style="padding: 1px 150px">
					<div class="col-8 text-left"
						style="font-size: 20px; background-color: #FBDEA2;"><%=list.get(i).getTodayDate().substring(0, 11)%></div>
					<div class="col-4 text-right" style="font-size: 25px">
						<span style="background-color: #F15F5F; color: white;"><%=list.get(i).getBuysell()%></span>
					</div>
				</div>
				<div class="card-body" style="padding: 1px 170px">
					<h3 class="card-title">
						<strong><%=list.get(i).getStockName()%></strong>
					</h3>
					<p class="card-text" style="font-size: 19px">
						매매이유 :
						<%=list.get(i).getBuyReason()%></p>
					<div class="row">
						<div class="col-9 text-left">
							<span style="font-size: 17px">체결수량 : </span>&nbsp;<strong><%=list.get(i).getStockQuantity()%></strong>개&nbsp;&nbsp;/&nbsp;
							<span style="font-size: 17px">체결가격 : </span>&nbsp;<strong><%=list.get(i).getStockPrice()%></strong>원
						</div>
						<div style="float: right;">
							<a onclick="return confirm('매매기록을 삭제하시겠습니까?')"
								href="deleteStockAction.jsp?stockID=<%=list.get(i).getStockID()%>">삭제</a>
						</div>
					</div>
				</div>
			</div>
			<hr>
			<%
			}
			} else if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			}
			}
			%>

		
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