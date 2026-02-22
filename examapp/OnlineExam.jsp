<%@ page import="java.sql.*" %>
<%!
int a1=0,a2=0,a3=0,a4=0,a5=0;
%>
<%
String SeatNum="", Name="", ans1="", ans2="", ans3="", ans4="", ans5="";
Connection connect=null; Statement stmt=null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/examdb", "root", "2006");
    stmt = connect.createStatement();
    
    if(request.getParameter("action") != null) {
        SeatNum = request.getParameter("Seat_no");
        Name = request.getParameter("Name");
        ans1 = request.getParameter("group1"); if("True".equals(ans1)) a1=5; else a1=0;
        ans2 = request.getParameter("group2"); if("True".equals(ans2)) a2=0; else a2=5;
        ans3 = request.getParameter("group3"); if("True".equals(ans3)) a3=0; else a3=5;
        ans4 = request.getParameter("group4"); if("True".equals(ans4)) a4=5; else a4=0;
        ans5 = request.getParameter("group5"); if("True".equals(ans5)) a5=0; else a5=5;
        int Total = a1+a2+a3+a4+a5;
        
        String query = "INSERT INTO exam_results (seat_no, name, marks) VALUES ('" + SeatNum + "', '" + Name + "', " + Total + ")";
        stmt.executeUpdate(query);
        
        // Display mark for this student
        query = "SELECT * FROM exam_results WHERE name='" + Name + "'";
        ResultSet rs = stmt.executeQuery(query);
        if(rs.next()) {
%>
<html><head><title>Result</title></head><body>
<center><h2>Your Marks: <%=rs.getInt("marks")%>/25</h2></center>
</body></html>
<%
        }
    }
} catch(Exception e) { out.print(e); }
finally { if(stmt!=null) stmt.close(); if(connect!=null) connect.close(); }
%>
