<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Buy Ticket</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/a6a9382d23.js" crossorigin="anonymous"></script>

  <!-- Custom CSS -->
  <link rel="stylesheet" href="./resources/css/registration.css">
  <link rel="stylesheet" href="./resources/css/header_footer.css">
  <link rel="stylesheet" href="./resources/css/common_styles.css">
</head>

<body onload="updateAmount()">

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
              <a class="nav-link" href="#"><button type="button"
                  class="btn btn-outline-info btn-md me-2">HOME</button></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="logout"><button type="button"
                  class="btn btn-outline-info btn-md me-2">LOGOUT</button></a>
            </li>
            <c:choose>
              <c:when test="${sessionScope.sessionId == sessionScope.admin}">
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
                      <li><a class="dropdown-item" href="getRegisterUser">CREATE NEW USER</a></li>
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
                  <a class="nav-link" href="userTickets"><button type="button"
                      class="btn btn-outline-info btn-md me-2">MY TICKETS</button></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="./user_tickets.jsp"><button type="button" 
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
      <div class="title">BUY TICKETS</div>
      <div class="content">
        <form action="buyTicket" method="post" onsubmit="return validateForm()">
          <div class="user-details">
            <div class="input-box">
              <span class="details">FROM :</span>
              <select class="form-select" name="source" id="source" aria-label="Default select example"
                onchange="updateAmount()">
                <option value="Kengeri" selected>Kengeri</option>
                <option value="Gnana Bharathi">Gnana Bharathi</option>
                <option value="RR Nagar">RR Nagar</option>
                <option value="Mysore Road">Mysore Road</option>
                <option value="Vijaynagar">Vijaynagar</option>
                <option value="Magadi Road">Magadi Road</option>
                <option value="Majestic">Majestic</option>
                <option value="Cubbon Park">Cubbon Park</option>
                <option value="MG Road">MG Road</option>
                <option value="Indiranagar">Indiranagar</option>
                <option value="Baiyappanahalli">Baiyappanahalli</option>
              </select>
              <span id="from-error" class="error"></span>
            </div>
            <div class="input-box">
              <span class="details">To :</span>
              <select class="form-select" name="destination" id="destination" aria-label="Default select example"
                onchange="updateAmount()">
                <option value="Gnana Bharathi" selected>Gnana Bharathi</option>
                <option value="RR Nagar">RR Nagar</option>
                <option value="Mysore Road">Mysore Road</option>
                <option value="Vijaynagar">Vijaynagar</option>
                <option value="Magadi Road">Magadi Road</option>
                <option value="Majestic">Majestic</option>
                <option value="Cubbon Park">Cubbon Park</option>
                <option value="MG Road">MG Road</option>
                <option value="Indiranagar">Indiranagar</option>
                <option value="Baiyappanahalli">Baiyappanahalli</option>
              </select>
              <span id="to-error" class="error"></span>
            </div>
            <div class="input-box">
              <span class="details">Number of Tickets</span>
              <input type="text" placeholder="1" id="noOfTickets" name="noOfTickets" min="1" value="1"
                onblur="validateNoOfTickets()" onchange="updateAmount()">
              <br><span id="noOfTickets-error" class="error"></span>
            </div>
            <div class="input-box">
              <span class="details">Payment Option :</span>
              <select class="form-select" name="paymentOption" id="paymentOption" aria-label="Default select example">
                <option value="Cash" selected>Cash</option>
                <option value="Debit/Credit Cards">Debit/Credit Cards</option>
                <option value="GPAY">GPAY</option>
                <option value="Phone Pe">Phone Pe</option>
                <option value="PayTm">PayTm</option>
                <option value="Net Banking">Net Banking</option>
              </select>
            </div>
            <div class="input-box">
              <span class="details">Amount</span>
              <input type="text" placeholder="Rs" id="amount" name="amount" readonly>
              <br><span id="amount-error" class="error"></span>
            </div>
            <div class="input-box" style="display: none;">
              <span class="details">User Id</span>
              <input type="number" placeholder="id" id="uid" name="uid" value="${sessionId}">
              <br><span id="uid-error" class="error"></span>
            </div>
          </div>
          <div class="button" style="margin-bottom: 25px;">
            <input type="submit" value="Buy">
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
  <script src="./resources/js/buy_ticket.js"></script>
</body>
</html>