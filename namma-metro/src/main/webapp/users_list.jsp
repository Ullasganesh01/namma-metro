<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Show Users</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/a6a9382d23.js" crossorigin="anonymous"></script>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="./resources/css/button_styles.css">
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
                                    <li><a class="dropdown-item" href="getRegisterUser">CREATE NEW USER</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./admin_home.jsp"><button type="button" 
                              class="btn btn-outline-info btn-md me-2">BACK</button></a>
                          </li>
                    </ul>
                    <form class="d-flex mysearchform" action="filterUsers">
                        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search"
                            name="filter">
                        <button class="btn btn-outline-info" type="submit">Search</button>
                    </form>
                </div>
            </div>
        </nav>
    </div>

    <div style="width: 90vw;margin: auto;margin-top: 20px">
        <h3 style="width: fit-content;margin: auto;">Namma Metro Users</h3>
        <table class="table table-striped">
            <thead class="table-success">
                <tr class="bg-danger">
                    <th scope="col">User ID
                        <span class="sort-icons"><a href="sortUsers?sortBy=userIdAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortUsers?sortBy=userIdDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">Name
                        <span class="sort-icons"><a href="sortUsers?sortBy=nameAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortUsers?sortBy=nameDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">Email
                        <span class="sort-icons"><a href="sortUsers?sortBy=emailAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortUsers?sortBy=emailDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">Contact No
                        <span class="sort-icons"><a href="sortUsers?sortBy=contactNoAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortUsers?sortBy=contactNoDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">Gender
                        <span class="sort-icons"><a href="sortUsers?sortBy=genderAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortUsers?sortBy=genderDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col">Address
                        <span class="sort-icons"><a href="sortUsers?sortBy=addressAsc"><i class="fa-solid fa-sort-up"></i></a>
                        <a href="sortUsers?sortBy=addressDesc"><i class="fa-solid fa-sort-down"></i></a></span>
                    </th>
                    <th scope="col" colspan="3" style="text-align: center;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${ users }">
                    <tr>
                        <th scope="row">${user.getUid()}</th>
                        <td>${user.getName()}</td>
                        <td>${user.getEmail()}</td>
                        <td>${user.getContactNo()}</td>
                        <td>${user.getGender()}</td>
                        <td>${user.getAddress()}</td>
                        <td><button id="viewTickets"><a href="getUserTicketsById?userId=${user.getUid()}">View Tickets</a></button></td>
                        <td><button id="updatebtn"><a href="getUserById?userId=${user.getUid()}">Update</a></button></td>
                        <td><button id="deletebtn"><a href="removeUser?userId=${user.getUid()}">Delete</a></button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="backend-msg">
        <h4>${noUsers}</h4>
        <h4>${updateMsg}</h4>
        <h4>${deleteMsg}</h4>
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
</body>
</html>