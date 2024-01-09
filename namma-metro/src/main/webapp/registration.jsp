<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Namma Metro</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/a6a9382d23.js" crossorigin="anonymous"></script>

  <!-- Custom CSS -->
  <link rel="stylesheet" href="./resources/css/registration.css">
  <link rel="stylesheet" href="./resources/css/header_footer.css">
  <link rel="stylesheet" href="./resources/css/fixed_footer.css">
  <style>
    .form-body {
    margin-top: 10px;
    }
    .container {
      margin-top: 10px;
      margin-bottom: 10px;
    }

    .form-container {
      width: max-content;
      margin-top: 0px;
      margin: auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
  <!-- Header -->
  <div>
    <nav class="navbar navbar-expand-lg bg-info-subtle text-primary-emphasis p-3">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">
          <img src="./resources/images/namma-metro-logo.png" alt="Namma Metro" height="50">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
          aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-5">
            <c:choose>
              <c:when test="${not empty sessionScope.sessionId && not empty sessionScope.admin && sessionScope.sessionId == sessionScope.admin}">
                <li class="nav-item">
                  <a class="nav-link" href="./admin_home.jsp"><button type="button"
                      class="btn btn-outline-info btn-md me-2">HOME</button></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="logout"><button type="button"
                      class="btn btn-outline-info btn-md me-2">LOGOUT</button></a>
                </li>
                <li class="nav-item" style="margin-top: 8px;">
                  <div class="dropdown">
                    <button class="btn btn-outline-info btn-md me-2 dropdown-toggle" type="button"
                      data-bs-toggle="dropdown" aria-expanded="false">
                      ADMIN OPTIONS
                    </button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="getBuyTicket">BUY TICKETS</a></li>
                      <li><a class="dropdown-item" href="fetchAllTickets">SHOW BOUGHT TICKETS</a></li>
                      <li><a class="dropdown-item" href="fetchAllUsers">SHOW USERS</a></li>
                      <li><a class="dropdown-item" href="getRegisterUser">CREATE NEW USER</a>
                      </li>
                    </ul>
                  </div>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="./admin_home.jsp"><button type="button" 
                    class="btn btn-outline-info btn-md me-2">BACK</button></a>
                </li>
              </c:when>
              <c:otherwise>
                <li class="nav-item">
                  <a class="nav-link" href="#"><button type="button"
                      class="btn btn-outline-info btn-md me-2">HOME</button></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="./login.jsp"><button type="button"
                      class="btn btn-outline-info btn-md me-2">LOGIN</button></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="./login.jsp"><button type="button"
                      class="btn btn-outline-info btn-md me-2">BUY TICKETS</button></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="./login.jsp"><button type="button" 
                    class="btn btn-outline-info btn-md me-2">BACK</button></a>
                </li>
              </c:otherwise>
            </c:choose>
          </ul>
        </div>
      </div>
    </nav>
  </div>

  <!-- registration form body-->
  <div class="form-body">
    <div class="container form-container" style="margin-bottom: 0px;">
      <div class="title">Registration</div>
      <div class="content">
        <form action="registerUser" method="post" onsubmit="return validateForm()">
          <div class="user-details">
            <div class="input-box">
              <span class="details">Full Name</span>
              <input type="text" placeholder="Enter your name" id="name" name="name" onblur="validateName()">
              <br><span id="name-error" class="error"></span>
            </div>
            <div class="input-box">
              <span class="details">Email</span>
              <input type="text" placeholder="Enter your email" id="email" name="email" onblur="validateEmail()">
              <br><span id="email-error" class="error"></span>
            </div>
            <div class="input-box">
              <span class="details">Phone Number</span>
              <input type="text" placeholder="Enter your phone number" id="contactno" name="contactNo"
                onblur="validateContactNo()">
              <br><span id="contact-error" class="error"></span>
            </div>
            <div class="input-box">
              <span class="details">Address</span>
              <input type="text" placeholder="Enter your address" id="address" name="address"
                onblur="validateAddress()">
              <br><span id="address-error" class="error"></span>
            </div>
            <div class="input-box">
              <span class="details">Password</span>
              <input type="password" placeholder="Enter your password" id="password" name="password"
                onblur="validatePassword()">
              <br><span id="password-error" class="error"></span>
            </div>
            <div class="input-box">
              <span class="details">Confirm Password</span>
              <input type="password" placeholder="Confirm your password" id="confirmPwd" name="confirmPwd"
                onblur="validateConfirmPassword()">
              <br><span id="cpassword-error" class="error"></span>
            </div>
          </div>
          <div class="gender-details">
            <input type="radio" name="gender" id="dot-1" value="male" checked>
            <input type="radio" name="gender" id="dot-2" value="female">
            <span class="gender-title">Gender</span>
            <div class="category">
              <label for="dot-1">
                <span class="dot one"></span>
                <span class="gender">Male</span>
              </label>
              <label for="dot-2" style="margin-left: 10px;">
                <span class="dot two"></span>
                <span class="gender">Female</span>
              </label>
            </div>
          </div>
          <div class="button" style="margin-bottom: 25px;">
            <input type="submit" value="Register">
          </div>
        </form>
      </div>
    </div>
  </div>

  <!--footer-->
  <div>
    <footer class="footer text-center mt-auto py-3">
      <a href="#" class="btn btn-outline-light btn-social mx-1"><i class="fab fa-facebook-f"></i></a>
      <a href="#" class="btn btn-outline-light btn-social mx-1"><i class="fab fa-twitter"></i></a>
      <a href="#" class="btn btn-outline-light btn-social mx-1"><i class="fab fa-linkedin-in"></i></a>
      <a href="#" class="btn btn-outline-light btn-social mx-1"><i class="fab fa-instagram"></i></a>
    </footer>
  </div>
  <script src="./resources/js/registration.js"></script>
</body>
</html>