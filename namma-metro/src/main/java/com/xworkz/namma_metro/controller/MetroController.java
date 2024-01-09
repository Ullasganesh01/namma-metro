package com.xworkz.namma_metro.controller;

import com.xworkz.namma_metro.dto.TicketsDto;
import com.xworkz.namma_metro.dto.UserDto;
import com.xworkz.namma_metro.service.MetroService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/")
public class MetroController {

    @Autowired
    public MetroService metroService;

    private void setAdminId(HttpSession httpSession){
        int adminId = metroService.validateAndFetchUserByLoginId("admin").getUid();
        httpSession.setAttribute("admin",adminId);
    }

    private int getAdminId(){
        return metroService.validateAndFetchUserByLoginId("admin").getUid();
    }

    @PostMapping("registerUser")
    public String registerUser(@ModelAttribute @Valid UserDto dto, BindingResult errors, Model model,HttpSession httpSession){
        if (errors.hasErrors()){
            List<ObjectError> listErrors = errors.getAllErrors();
            model.addAttribute("errors",listErrors);
            return "error";
        }
        if (dto!=null){
            if(metroService.validateAndRegisterUser(dto)){
                Integer id = (Integer) httpSession.getAttribute("sessionId");
                if (id!=null){
                    if (id==getAdminId()){
                        //getSessions(httpSession);
                        return fetchAllUsers(model,httpSession);
                    }
                }
                model.addAttribute("regSuccess","Registration Successful \n Please login to continue..");
                return "login";
            }
        }
        model.addAttribute("errorMsg","Registration Unsuccessful Because data is Null");
        return "error";
    }

    @PostMapping("userLogin")
    public String loginUser(@RequestParam String loginId, @RequestParam String password, Model model, HttpSession httpSession){
        if (loginId!=null&&password!=null){
            if(metroService.validateAndLogin(loginId,password)){
                UserDto dto = metroService.validateAndFetchUserByLoginId(loginId);
                httpSession.setAttribute("sessionId",dto.getUid());
                if (dto.getName().equals("admin")){
                    //getSessions(httpSession);
                    return "admin_home";
                }
                //getSessions(httpSession);
                return "buy_ticket";
            }
            model.addAttribute("loginErr","Invalid Credentials");
            return "login";
        }
        return "error";
    }

    @GetMapping("logout")
    public String logout(HttpSession httpSession){
        metroService.getSessions(httpSession);
        /*httpSession.removeAttribute("admin");
        httpSession.removeAttribute("ticketList");
        httpSession.removeAttribute("userList");
        httpSession.removeAttribute("sessionId");*/
        httpSession.invalidate();
        try {
            metroService.getSessions(httpSession);
        }catch (Exception e){
            System.out.println("Session is Cleared");
        }

        return "login";
    }

    @PostMapping("buyTicket")
    public String buyTickets(@Valid TicketsDto dto,BindingResult errors,Model model,HttpSession httpSession){
        if (errors.hasErrors()){
            List<ObjectError> listErrors = errors.getAllErrors();
            model.addAttribute("errors",listErrors);
            return "error";
        }
        if (dto!=null){
            if(metroService.validateAndBuyTicket(dto)){
                Integer id = (Integer) httpSession.getAttribute("sessionId");
                if (id!=null && id==getAdminId()){
                    return fetchAllTickets(model,httpSession);
                }
                return getUserTickets(model,httpSession);
            }
        }
        model.addAttribute("errorMsg","Buying Ticket Failed Because data is Null");
        return "error";
    }

    @GetMapping("userTickets")
    public String getUserTickets(Model model,HttpSession httpSession){
        Integer id = (Integer) httpSession.getAttribute("sessionId");
        if (id!=null){
            List userTicketsList = metroService.validateAndFetchTicketByUserId(id);
            if (userTicketsList!=null && !userTicketsList.isEmpty()){
                model.addAttribute("tickets",userTicketsList);
                httpSession.setAttribute("ticketList",userTicketsList);
                return "user_tickets";
            }
            model.addAttribute("noTickets","No Tickets Found");
            return "user_tickets";
        }
        model.addAttribute("errorMsg","Session Id is Null");
        return "error";
    }

    @GetMapping("fetchAllTickets")
    public String fetchAllTickets(Model model,HttpSession httpSession){
        Integer id = (Integer) httpSession.getAttribute("sessionId");
        if (id!=null && id==getAdminId()){
            List ticketsList = metroService.validateAndFetchAllTickets();
            if (ticketsList!=null && !ticketsList.isEmpty()){

                model.addAttribute("tickets",ticketsList);
                httpSession.setAttribute("ticketList",ticketsList);
                setAdminId(httpSession);

                return "ticket_list";
            }
            model.addAttribute("noTickets","List is empty/No Tickets Found");
            return "ticket_list";
        }
        model.addAttribute("errorMsg","Un-Authorized Access/Session Id is Null");
        return "error";
    }

    @GetMapping("getUserTicketsById")
    public String getUserTicketsById(@RequestParam int userId,Model model,HttpSession httpSession){
//        Integer id = (Integer) httpSession.getAttribute("sessionId");
        if (userId>0){
            List userTicketsList = metroService.validateAndFetchTicketByUserId(userId);
            if (userTicketsList!=null && !userTicketsList.isEmpty()){
                model.addAttribute("tickets",userTicketsList);
                httpSession.setAttribute("ticketList",userTicketsList);
                return "admin_user_tickets";
            }
            model.addAttribute("noTickets","No Tickets Found");
            return "admin_user_tickets";
        }
        model.addAttribute("errorMsg","Session Id is Null");
        return "error";
    }

    @GetMapping("fetchAllUsers")
    public String fetchAllUsers(Model model,HttpSession httpSession){
        Integer id = (Integer) httpSession.getAttribute("sessionId");
        if (id!=null && id==getAdminId()){
            List usersList = metroService.validateAndFetchAllUsers();
            if (usersList!=null && !usersList.isEmpty()){

                model.addAttribute("users",usersList);
                httpSession.setAttribute("userList",usersList);
                setAdminId(httpSession);
                //getSessions(httpSession);
                return "users_list";
            }
            model.addAttribute("noUsers","List is empty/No Users Found");
            return "users_list";
        }
        model.addAttribute("errorMsg","Un-Authorized Access/Session Id is Null");
        return "error";
    }

    @GetMapping("getUserById")
    public String getUserById(@RequestParam int userId,Model model,HttpSession httpSession){
        Integer id = (Integer) httpSession.getAttribute("sessionId");
        int adminId = getAdminId();
        if (userId==id||adminId==id){
            UserDto dto = metroService.validateAndFetchUserById(userId);
            if (dto!=null){
                model.addAttribute("user",dto);
                if (userId==adminId){
                    metroService.getSessions(httpSession);
                    return "redirect:/getUserPage";
                }else {
                    metroService.getSessions(httpSession);
                    return "get_user";
                }
            }
        }
        model.addAttribute("errorMsg","Could not fetch User By Id");
        return "error";
    }

    @PostMapping("updateUser")
    public String updateUser(@Valid UserDto dto,BindingResult errors,Model model,HttpSession httpSession){
        if (errors.hasErrors()){
            List<ObjectError> listErrors = errors.getAllErrors();
            model.addAttribute("errors",listErrors);
            return "error";
        }
        if (dto!=null){
            Integer id = (Integer) httpSession.getAttribute("sessionId");
            int adminId = getAdminId();
            int userId = dto.getUid();
            if (id!=null){
                if (id== adminId|| id==userId){
                    if (metroService.validateAndUpdateUser(dto)){
                        if (adminId==id){
                            model.addAttribute("updateMsg","Update Successful");
                            //getSessions(httpSession);
                            return fetchAllUsers(model,httpSession);
                        }else {
                            return getUserTickets(model,httpSession);
                        }
                    }
                }
            }
        }
        model.addAttribute("errorMsg","Update Unsuccessful Because data is Null/Un-Authorized Access");
        return "error";
    }

    @GetMapping("removeUser")
    public String removeUser(@RequestParam int userId,Model model,HttpSession httpSession){
        if (userId>0){
            Integer id = (Integer) httpSession.getAttribute("sessionId");
            int adminId = getAdminId();
            if (id!=null){
                if (id==adminId|| id==userId){
                    if (metroService.validateAndRemoveUser(userId)){
                        if (adminId==id){
                            model.addAttribute("deleteMsg","Delete Successful");
                            //getSessions(httpSession);
                            return fetchAllUsers(model,httpSession);
                        }else {
                            return logout(httpSession);
                        }
                    }
                }
            }
        }
        model.addAttribute("errorMsg","Delete Unsuccessful Because data is Null/Un-Authorized Access");
        return "error";
    }

    @PostMapping("filterUserTickets")
    public String filterUserTickets(@RequestParam String filter,Model model,HttpSession httpSession){
        Integer id = (Integer) httpSession.getAttribute("sessionId");
        if (id!=null){
            List filteredList = metroService.validateAndFilterUsersTickets(filter,id);
            if (filteredList!=null && !filteredList.isEmpty()){
                model.addAttribute("tickets",filteredList);
                return "user_tickets";
            }
            model.addAttribute("noTickets","No Tickets Found");
            return "user_tickets";
        }
        model.addAttribute("errorMsg","Session Id is Null");
        return "error";
    }

    @GetMapping("filterTickets")
    public String filterTickets(@RequestParam String filter,Model model,HttpSession httpSession){
        Integer id = (Integer) httpSession.getAttribute("sessionId");
        if (id!=null && id==getAdminId()){
            List filteredList = metroService.validateAndFilterTickets(filter);
            if (filteredList!=null && !filteredList.isEmpty()){
                model.addAttribute("tickets",filteredList);
                return "ticket_list";
            }
            model.addAttribute("noTickets","List is empty/No Tickets Found");
            return "ticket_list";
        }
        model.addAttribute("errorMsg","Un-Authorized Access/Session Id is null");
        return "error";
    }

    @GetMapping("filterUsers")
    public String filterUsers(@RequestParam String filter,Model model,HttpSession httpSession){
        Integer id = (Integer) httpSession.getAttribute("sessionId");
        if (id!=null && id==getAdminId())
        {
            List filteredList = metroService.validateAndFilterUsers(filter);
            if (filteredList!=null && !filteredList.isEmpty()){
                model.addAttribute("users",filteredList);
                return "users_list";
            }
            model.addAttribute("noUsers","List is empty/No Users Found");
            return "users_list";
        }
        model.addAttribute("errorMsg","Un-Authorized Access/Session Id is null");
        return "error";
    }

    @GetMapping("getBuyTicket")
    public String renderBuyTicket(HttpSession httpSession){
        setAdminId(httpSession);
        return "buy_ticket";
    }

    @GetMapping("getRegisterUser")
    public String renderRegisterUser(HttpSession httpSession){
        setAdminId(httpSession);
        return "registration";
    }

    @GetMapping("getUserPage")
    public String renderGetUserPage(HttpSession httpSession){
        setAdminId(httpSession);
        return "get_user";
    }

    @GetMapping("sortTickets")
    public String sortTickets(@RequestParam String sortBy,Model model,HttpSession httpSession){
        if (sortBy!=null && !sortBy.isEmpty()){
            List<TicketsDto> unsortedList = (List<TicketsDto>) httpSession.getAttribute("ticketList");
            List sortedList = metroService.validateAndSortTickets(sortBy,unsortedList);
            Integer id = (Integer) httpSession.getAttribute("sessionId");
            int adminId = getAdminId();
            if (sortedList!=null && !sortedList.isEmpty()){
                System.out.println("sorted list by : " + sortBy + " : " + sortedList);
                model.addAttribute("tickets",sortedList);

                if (id==adminId){
                    return "ticket_list";
                }else {
                    return "user_tickets";
                }
            }
            if (id==adminId){
                model.addAttribute("noTickets","List is empty/No Tickets Found");
                return "ticket_list";
            }
            model.addAttribute("noTickets","List is empty/No Tickets Found");
            return "user_tickets";
        }
        model.addAttribute("errorMsg","Sort Value is null");
        return "error";
    }

    @GetMapping("sortUsers")
    public String sortUsers(@RequestParam String sortBy,Model model,HttpSession httpSession){
        if (sortBy!=null && !sortBy.isEmpty()){
            List<UserDto> unsortedList = (List<UserDto>) httpSession.getAttribute("userList");
            List sortedList = metroService.validateAndSortUsers(sortBy,unsortedList);
            if (sortedList!=null && !sortedList.isEmpty()){
                System.out.println("sorted list by : " + sortBy + " : " + sortedList);
                model.addAttribute("users",sortedList);
                return "users_list";
            }
            model.addAttribute("noUsers","List is empty/No Users Found");
            return "users_list";
        }
        model.addAttribute("errorMsg","Sort Value is null");
        return "error";
    }

    @PostMapping("validateLoginId")
    public String validateLoginId(@RequestParam String loginId,Model model,HttpSession session){
        if (loginId!=null){
            UserDto dto = metroService.validateAndFetchUserByLoginId(loginId);
            if (dto!=null){
                if (dto.getEmail().equals(loginId)||dto.getName().equals(loginId)){
                    session.setAttribute("currentUser",dto);
                    return displayOTP(model,session);
                }
            }
        }
        model.addAttribute("loginIdError","Invalid Login ID");
        return "validate_user";
    }


    public String displayOTP(Model model,HttpSession session){
        String otp = metroService.generateOTP();
        UserDto dto = (UserDto) session.getAttribute("currentUser");
        int currentId = dto.getUid();
        if (metroService.addOtpTOMap(otp,currentId)){
            session.setAttribute("OTP",otp);
            return "display_otp";
        }
        model.addAttribute("errorMsg","Something Went wrong");
        logout(session);
        return "validate_user";
    }

    @PostMapping("verifyOTP")
    public String verifyOTP(@RequestParam String otp,Model model,HttpSession session){
        UserDto dto = (UserDto) session.getAttribute("currentUser");
        int currentId = dto.getUid();
        if (metroService.verifyOTP(otp,currentId)){
            model.addAttribute("OtpSuccess","OTP IS VERIFIED");
            return "change_password";
        }
        model.addAttribute("otpErr","Invalid OTP / OTP mismatch");
        logout(session);
        return "validate_user";
    }

    @PostMapping("changePassword")
    public String changePassword(@RequestParam int uid,@RequestParam String password,Model model,HttpSession session){
        UserDto dto  = (UserDto) session.getAttribute("currentUser");
        if (dto.getUid() == uid){
            dto.setPassword(password);
            if(metroService.validateAndUpdateUser(dto)){
                model.addAttribute("changePasswordMsg","Password has been changed.\nLogin to continue");
                logout(session);
                return "login";
            }
        }
        model.addAttribute("errorMsg","Could Not change Password");
        logout(session);
        return "error";
    }

}
