<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booked Tickets</title>

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
    <link rel="stylesheet" href="./resources/css/sort_button_styles.css">
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
                            <a class="nav-link" href="./buy_ticket.jsp"><button type="button"
                                    class="btn btn-outline-info btn-md me-2">HOME</button></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="logout"><button type="button"
                                    class="btn btn-outline-info btn-md me-2">LOGOUT</button></a>
                        </li>
                        <!-- <c:choose>
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
                                            <li><a class="dropdown-item" href="getRegisterUser">CREATE NEW USER</a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                            </c:when>
                            <c:otherwise> -->
                                <li class="nav-item">
                                    <a class="nav-link" href="./buy_ticket.jsp"><button type="button"
                                            class="btn btn-outline-info btn-md me-2">BUY TICKETS</button></a>
                                </li>
                            <!-- </c:otherwise>
                        </c:choose> -->
                        <li class="nav-item">
                            <a class="nav-link" href="./buy_ticket.jsp"><button type="button" 
                              class="btn btn-outline-info btn-md me-2">BACK</button></a>
                          </li>
                    </ul>
                    <form class="d-flex mysearchform" action="filterUserTickets" method="post">
                        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search"
                            name="filter">
                        <input class="form-control me-2" type="text" placeholder="Search" aria-label="Search"
                            name="sessionId" value="${sessionId}" style="display:none">
                        <button class="btn btn-outline-info" type="submit">Search</button>
                    </form>
                </div>
            </div>
        </nav>
    </div>

    <div style="width: 90vw;margin: auto;margin-top: 20px">
        <h3 style="width: fit-content;margin: auto;">Booked Tickets</h3>
        <table class="table table-striped">
            <thead class="table-success">
                <tr class="bg-danger">
                    <th scope="col">Ticket ID
                        <span class="sort-icons"><a href="sortTickets?sortBy=ticketIdAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortTickets?sortBy=ticketIdDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">From
                        <span class="sort-icons"><a href="sortTickets?sortBy=fromAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortTickets?sortBy=fromDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">To
                        <span class="sort-icons"><a href="sortTickets?sortBy=toAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortTickets?sortBy=toDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">No of Tickets
                        <span class="sort-icons"><a href="sortTickets?sortBy=noOfTicketsAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortTickets?sortBy=noOfTicketsDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">Payment Option
                        <span class="sort-icons"><a href="sortTickets?sortBy=paymentOptionAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortTickets?sortBy=paymentOptionDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">Amount
                        <span class="sort-icons"><a href="sortTickets?sortBy=amountAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortTickets?sortBy=amountDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ticket" items="${ tickets }">
                    <tr>
                        <th scope="row">${ticket.getTicketId()}</th>
                        <td>${ticket.getSource()}</td>
                        <td>${ticket.getDestination()}</td>
                        <td>${ticket.getNoOfTickets()}</td>
                        <td>${ticket.getPaymentOption()}</td>
                        <td>${ticket.getAmount()}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="backend-msg">
        <h4>${noTickets}</h4>
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