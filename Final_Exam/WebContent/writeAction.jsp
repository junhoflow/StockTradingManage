<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="debate.DebateDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="debate" class="debate.Debate" scope="page"/>
<jsp:setProperty name="debate" property="debateTitle"/>
<jsp:setProperty name="debate" property="debateContent"/>
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
	if (debate.getDebateTitle() == null || debate.getDebateContent()==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('모두 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		DebateDAO debateDAO = new DebateDAO();
		int result = debateDAO.write(debate.getDebateTitle(), userID, debate.getDebateContent());
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
			script.println("location.href = 'debate.jsp'");
			script.println("</script>");
		}
	}
}
%>
</body>
</html>