<%@page import="dao.DeptDAO"%>
<%@page import="vo.DeptVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<DeptVO> list = DeptDAO.getInstance().selectList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>부서번호</th>
			<th>부서명</th>
			<th>부서위치</th>
		</tr>
		<%
			for(int i = 0; i < list.size(); i++) {
				DeptVO dv = list.get(i);
		%>
		<tr>
			<td><%= dv.getDeptno() %></td>
			<td><%= dv.getDname() %></td>
			<td><%= dv.getLoc() %></td>
		</tr>
		<% } %>
	</table>
</body>
</html>