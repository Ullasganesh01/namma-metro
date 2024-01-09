package com.xworkz.namma_metro.service;

import com.xworkz.namma_metro.dto.TicketsDto;
import com.xworkz.namma_metro.dto.UserDto;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MetroService {
    Map<Integer,String> otpMap = new HashMap<>();
    boolean validateAndRegisterUser(UserDto dto);
    boolean validateAndBuyTicket(TicketsDto dto);
    List<UserDto> validateAndFetchAllUsers();
    List<TicketsDto> validateAndFetchAllTickets();
    UserDto validateAndFetchUserById(int id);
    UserDto validateAndFetchUserByLoginId(String loginId);
    TicketsDto validateAndFetchTicketByTicketId(int id);
    List<TicketsDto> validateAndFetchTicketByUserId(int uid);
    List<UserDto> validateAndFilterUsers(String filter);
    boolean validateAndLogin(String loginId,String password);
    List<TicketsDto> validateAndFilterUsersTickets(String filter,int uid);
    List<TicketsDto> validateAndFilterTickets(String filter);
    List<TicketsDto> validateAndSortTickets(String sortBy,List<TicketsDto> ticketList);
    List<UserDto> validateAndSortUsers(String sortBy,List<UserDto> usersList);
    boolean validateAndUpdateUser(UserDto dto);
    boolean validateAndRemoveUser(int id);
    String generateOTP();
    boolean verifyOTP(String otp,int id);
    boolean addOtpTOMap(String otp,int id);
    void getSessions(HttpSession httpSession);
}
