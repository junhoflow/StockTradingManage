<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="stock.StockDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="stock" class="stock.StockDTO" scope="page"/>
<jsp:setProperty name="stock" property="stockName"/>
<jsp:setProperty name="stock" property="buysell"/>
<jsp:setProperty name="stock" property="stockQuantity"/>
<jsp:setProperty name="stock" property="stockPrice"/>
<jsp:setProperty name="stock" property="buyReason"/>
<jsp:setProperty name="stock" property="userID"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<title>주식 매매일지 웹사이트</title>
</head>
<body>

<%
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하세요')");
	script.println("location.href = 'login.jsp'");
	script.println("</script>");
} else{
	if (stock.getStockName() == null || stock.getBuysell()==null || stock.getStockQuantity() == null || stock.getStockPrice() == null || stock.getBuyReason() == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('모두 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		StockDAO stockDAO = new StockDAO();
		int result = stockDAO.write(stock.getStockName(), stock.getBuysell(), stock.getStockQuantity(), stock.getStockPrice(), stock.getBuyReason(), userID);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'stock.jsp'");
			script.println("</script>");
		}
	}
}
%>
</body>
</html>