<%@ page contentType="text/html" import="java.sql.*" %>
<html><head><title>Three Tier Marklist</title>
<style>body{color:blue;font-family:courier;text-align:center}</style>
</head>
<body>
<h2>EXAMINATION RESULT</h2><hr>
<%
String str = request.getParameter("regno");
Connection con=null; Statement stmt=null; ResultSet rs=null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examdb", "root", "password");
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM student_marks WHERE rno='" + str + "'");
    if(rs.next()) {
%>
Register No: <%=rs.getObject(1)%><br>
Name: <%=rs.getObject(2)%><br>
<table border="1">
<th>SUBJECT</th><th>Mark</th>
<tr><td>Network Programming</td><td><%=rs.getObject(3)%></td></tr>
<tr><td>OOAD</td><td><%=rs.getObject(4)%></td></tr>
<tr><td>Cryptography</td><td><%=rs.getObject(5)%></td></tr>
<tr><td>Embedded Systems</td><td><%=rs.getObject(6)%></td></tr>
<tr><td>Web Technology</td><td><%=rs.getObject(7)%></td></tr>
<tr><td>Software Engineering</td><td><%=rs.getObject(8)%></td></tr>
</table>
<%
    }
    else { out.print("No record found"); }
} catch(Exception e) { out.print(e); }
finally { if(rs!=null) rs.close(); if(stmt!=null) stmt.close(); if(con!=null) con.close(); }
%>
<br><a href="stud.html">Back</a>
</body></html>
