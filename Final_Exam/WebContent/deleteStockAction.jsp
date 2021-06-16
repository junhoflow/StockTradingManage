<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="stock.StockDAO"%>
<%@ page import="stock.StockDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<title>주식 매매일지 웹사이트</title>
</head>
<body>

	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	int stockID = 0;
	if (request.getParameter("stockID") != null) {
		stockID = Integer.parseInt(request.getParameter("stockID"));
	}
	if (stockID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'stock.jsp'");
		script.println("</script>");
	}
	StockDTO stockDTO = new StockDAO().getStock(stockID);
	StockDAO stockDAO = new StockDAO();
	int result = stockDAO.delete(stockID);
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 삭제에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'stock.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>