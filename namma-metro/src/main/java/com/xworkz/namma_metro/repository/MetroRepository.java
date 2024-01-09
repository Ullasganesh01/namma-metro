package com.xworkz.namma_metro.repository;

import com.xworkz.namma_metro.dto.TicketsDto;
import com.xworkz.namma_metro.dto.UserDto;

import java.util.List;

public interface MetroRepository {
    boolean registerUser(UserDto dto);
    boolean buyTicket(TicketsDto dto);
    List<UserDto> fetchAllUsers();
    List<TicketsDto> fetchAllTickets();
    UserDto fetchUserById(int id);
    UserDto fetchUserByLoginId(String loginId);
    TicketsDto fetchTicketByTicketId(int id);
    List<TicketsDto> fetchTicketByUserId(int uid);
    List<UserDto> filterUsers(String filter);
    List<TicketsDto> filterUsersTickets(String filter,int uid);
    List<TicketsDto> filterTickets(String filter);
    boolean updateUser(UserDto dto);
    boolean removeUser(int id);

}
