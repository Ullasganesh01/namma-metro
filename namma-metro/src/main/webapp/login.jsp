<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login Form</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/a6a9382d23.js" crossorigin="anonymous"></script>

  <!-- CSS -->
  <link rel="stylesheet" href="./resources/css/header_footer.css">
  <link rel="stylesheet" href="./resources/css/fixed_footer.css">
  <link rel="stylesheet" href="./resources/css/messages.css">
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
            <li class="nav-item">
              <a class="nav-link" href="./login.jsp"><button type="button"
                  class="btn btn-outline-info btn-md me-2">HOME</button></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="./registration.jsp"><button type="button"
                  class="btn btn-outline-info btn-md me-2">Register</button></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="./login.jsp"><button type="button" class="btn btn-outline-info btn-md me-2">BUY
                  TICKETS</button></a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </div>

  <!--login form body-->
  <aside class="col-sm-4" style="margin: auto; width: 30vw; margin-top: 5vh;">
    <div class="card">
      <article class="card-body">
        <img class="mb-4" src="./resources/images/namma-metro-logo.png" alt="" height="50" style="margin-left: 160px;">
        <h4 class="card-title mb-4 mt-1" style="text-align: center;">Sign in</h4>
        <form action="userLogin" method="post" onsubmit="return validateForm()">
          <div class="mb-3">
            <label for="loginId" class="form-label">Login Id</label>
            <input type="text" class="form-control" id="loginId" placeholder="Username/Email" name="loginId"
              onblur="validateLoginId()">
            <span id="login-error" class="error"></span>
          </div>
          <div class="mb-3">
            <a href="./validate_user.jsp" class="float-end">Forgot?</a>
            <label for="password" class="form-label">Your password</label>
            <input type="password" class="form-control" id="password" placeholder="******" name="password"
              onblur="validatePassword()">
            <span id="password-error" class="error"></span>
          </div>
          <div class="mb-3" style="width: max-content; margin: auto;">
            <button type="submit" class="btn btn-primary btn-block">Login</button>
          </div>
        </form>
        <div class="text-center">
          <p>Not a member? <a href="./registration.jsp">Register</a></p>
        </div>
      </article>
    </div>
  </aside>

  <div class="backend-msg">
    <h4>${regSuccess}</h4>
    <h4>${loginErr}</h4>
    <h4>${changePasswordMsg}</h4>
  </div>

  <div>
    <footer class="footer text-center mt-auto py-3">
      <a href="#" class="btn btn-outline-light btn-social mx-1"><i class="fab fa-facebook-f"></i></a>
      <a href="#" class="btn btn-outline-light btn-social mx-1"><i class="fab fa-twitter"></i></a>
      <a href="#" class="btn btn-outline-light btn-social mx-1"><i class="fab fa-linkedin-in"></i></a>
      <a href="#" class="btn btn-outline-light btn-social mx-1"><i class="fab fa-instagram"></i></a>
    </footer>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="./resources/js/login.js"></script>

</body>
</html>