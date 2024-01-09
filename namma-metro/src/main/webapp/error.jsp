<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <link rel="stylesheet" href="./resources/css/messages.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a6a9382d23.js" crossorigin="anonymous"></script>
    
        <!-- Custom CSS -->
        <link rel="stylesheet" href="./resources/css/button_styles.css">
    </head>
<body>
    <div class="backend-msg">
        <h1>Error Page</h1>
        <c:forEach items="${ errors }" var="error">
            <li>${error.getDefaultMessage()}</li>
        </c:forEach>
        
        <div>
            <h4>${errorMsg}</h4>
        </div>
    </div>
    <li class="nav-item">
        <a class="nav-link" href="./login.jsp"><button type="button" 
          class="btn btn-outline-info btn-md me-2">BACK</button></a>
      </li>
</body>
</html>