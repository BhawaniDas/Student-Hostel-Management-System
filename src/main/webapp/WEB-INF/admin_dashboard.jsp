<%@ page import="java.util.List" %>
<%@ page import="com.shms.model.User" %>
<%
    List<User> userList = (List<User>) request.getAttribute("userList");
%>
<h2>User Management (Edit/Delete)</h2>
<a href="add_user.jsp">Add New User</a>
&nbsp;&nbsp;&nbsp;
<a href="logout.jsp" style="color:red; font-weight:bold; float:right;">Logout</a>
<br><br>
<table border="1">
  <tr>
    <th>Username</th>
    <th>Password</th>
    <th>Email</th>
    <th>Name</th>
    <th>Contact</th>
    <th>Address</th>
    <th>Role</th>
    <th>Actions</th>
  </tr>
  <%
    for (User user : userList) {
  %>
    <tr>
      <td><%= user.getUsername() %></td>
      <td><%= user.getPassword() %></td>
      <td><%= user.getEmail() %></td>
      <td><%= user.getName() %></td>
      <td><%= user.getContact() %></td>
      <td><%= user.getAddress() %></td>
      <td><%= user.getRole() %></td>
      <td>
        <%-- Disable Edit/Delete for the default admin --%>
        <% if("admin".equals(user.getUsername()) && "adminpass".equals(user.getPassword())) { %>
          <!-- No action buttons for admin -->
        <% } else { %>
          <a href="EditUserServlet?username=<%= user.getUsername() %>">Edit</a> |
          <a href="DeleteUserServlet?username=<%= user.getUsername() %>"
             onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
        <% } %>
      </td>
    </tr>
  <%
    }
  %>
</table>
