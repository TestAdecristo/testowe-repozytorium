<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<html>
<body>
<%
Exception ex = (Exception) request.getAttribute("exception");
%>

<h2>Failure: <%= ex.getMessage() %></h2>
<p/>

<%
ex.printStackTrace(new java.io.PrintWriter(out));
%>
</body>
</html>