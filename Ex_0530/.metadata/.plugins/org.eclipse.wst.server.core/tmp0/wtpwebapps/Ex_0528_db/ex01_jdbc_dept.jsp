<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="VO.DeptVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    //톰캣이 JNDI를 검색하기 위해 필요한 클래스
    InitialContext ic = new InitialContext();
    Context ctx = (Context)ic.lookup("java:comp/env");
    //lookup() : jsp에서 db에 대한 정보가 저장되어 있는 위치를 조회
    
    DataSource ds = (DataSource)ctx.lookup("jdbc/oracle_test");
    //검색된 리소스를 통해 필요한 자원을 검색
    //context.xml의 name 속성값
    
   Connection conn = ds.getConnection();
    // 위에서 준비해둔 경로로 로그인 접속을 시도
    
//     System.out.println("---get Connection---");
    
    String sql = "select * from dept";
    
    PreparedStatement pstmt = conn.prepareStatement(sql);
    
    ResultSet rs = pstmt.executeQuery();
    
    List<DeptVO> list = new ArrayList<>();
    while(rs.next()){
    	DeptVO vo = new DeptVO();
    	
    	vo.setDeptno(rs.getInt("deptno"));
    	vo.setDname(rs.getString("dname"));
    	vo.setLoc(rs.getString("LOC"));
    	
    	list.add(vo);
    }
    rs.close();
    pstmt.close();
    conn.close();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
		function send(data){
			let f = document.m_form;
			let deptno=f.deptno;
			deptno.value = data;
			
			f.action = "sawon_list.jsp";
			f.method = "get";
			f.submit();
		}
		</script>
</head>
<body>
	<form name="m_form">
	<table border="1">
	<tr>
	<th>부서번호</th>
	<th>부서명</th>
	<th>부서위치</th>
	</tr>
	<%for(int i = 0; i<list.size(); i++){ 
		DeptVO dv = list.get(i);
		%>
		<tr>
		<td><%=dv.getDeptno() %></td>
		<td><a href="javascript:send('<%=dv.getDeptno()%>');"><%=dv.getDname() %></a></td>
		<td><%=dv.getLoc() %></td>
		</tr>
		<%} %>
	</table>
	<input type="hidden" name="deptno">
	</form>
</body>
</html>