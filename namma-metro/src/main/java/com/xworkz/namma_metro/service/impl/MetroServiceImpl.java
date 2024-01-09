package com.xworkz.namma_metro.service.impl;

import com.xworkz.namma_metro.constants.SortTickets;
import com.xworkz.namma_metro.constants.SortUsers;
import com.xworkz.namma_metro.dto.TicketsDto;
import com.xworkz.namma_metro.dto.UserDto;
import com.xworkz.namma_metro.repository.MetroRepository;
import com.xworkz.namma_metro.service.MetroService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class MetroServiceImpl implements MetroService {

    @Autowired
    public MetroRepository metroRepository;

    private boolean validateUser(UserDto dto){
        if (dto!=null){
            return !dto.getName().isEmpty() && !dto.getEmail().isEmpty() && dto.getContactNo() > 1000000000
                    && !dto.getAddress().isEmpty() && !dto.getGender().isEmpty() && !dto.getPassword().isEmpty();
        }
        return false;
    }

    private boolean validateTicket(TicketsDto dto){
        if (dto!=null){
            return !dto.getSource().isEmpty() && !dto.getDestination().isEmpty() && dto.getNoOfTickets()>0
                    && dto.getAmount()>0 && !dto.getPaymentOption().isEmpty() && dto.getUid()>0;
        }
        return false;
    }

    @Override
    public boolean validateAndRegisterUser(UserDto dto) {
        if (validateUser(dto)){
            return metroRepository.registerUser(dto);
        }
        return false;
    }

    @Override
    public boolean validateAndBuyTicket(TicketsDto dto) {
        if (validateTicket(dto)){
            return metroRepository.buyTicket(dto);
        }
        return false;
    }

    @Override
    public List<UserDto> validateAndFetchAllUsers() {
        return metroRepository.fetchAllUsers();
    }

    @Override
    public List<TicketsDto> validateAndFetchAllTickets() {
        return metroRepository.fetchAllTickets();
    }

    @Override
    public UserDto validateAndFetchUserById(int id) {
        if (id>0){
            return metroRepository.fetchUserById(id);
        }
        return null;
    }

    @Override
    public UserDto validateAndFetchUserByLoginId(String loginId) {
       if (!loginId.isEmpty()){

           return metroRepository.fetchUserByLoginId(loginId);
       }
       return null;
    }

    @Override
    public TicketsDto validateAndFetchTicketByTicketId(int id) {
        if (id>0){
            return metroRepository.fetchTicketByTicketId(id);
        }
        return null;
    }

    @Override
    public List validateAndFetchTicketByUserId(int uid) {
        if (uid>0){
            return metroRepository.fetchTicketByUserId(uid);
        }
        return null;
    }

    @Override
    public List<UserDto> validateAndFilterUsers(String filter) {
        if (!filter.isEmpty()){
            return metroRepository.filterUsers(filter);
        }
        return metroRepository.fetchAllUsers();
    }

    @Override
    public boolean validateAndLogin(String loginId, String password) {
        if (!loginId.isEmpty() && !password.isEmpty()){
            UserDto dto = metroRepository.fetchUserByLoginId(loginId);
            if(dto.getPassword().equals(password)){
                return true;
            }
            return false;
        }
        return false;
    }

    @Override
    public List<TicketsDto> validateAndFilterUsersTickets(String filter, int uid) {
        if (!filter.isEmpty()&&uid>0){
            return metroRepository.filterUsersTickets(filter,uid);
        }else if (filter.isEmpty()){
            return metroRepository.fetchTicketByUserId(uid);
        }
        return null;
    }

    @Override
    public List<TicketsDto> validateAndFilterTickets(String filter) {
        if (!filter.isEmpty()){
            return metroRepository.filterTickets(filter);
        }else {
            return metroRepository.fetchAllTickets();
        }
    }

    private boolean sortTicketsContainsSortBy(String sortBy){
        for (SortTickets order : SortTickets.values()){
            if (order.name().equals(sortBy)){
                return true;
            }
        }
        return false;
    }

    private boolean sortUsersContainsSortBy(String sortBy){
        for (SortUsers order : SortUsers.values()){
            if (order.name().equals(sortBy)){
                return true;
            }
        }
        return false;
    }

    @Override
    public List<TicketsDto> validateAndSortTickets(String sortBy,List<TicketsDto> ticketList) {
        if (sortBy!=null && !sortBy.isEmpty()){
            sortBy = sortBy.toUpperCase();
            if (sortTicketsContainsSortBy(sortBy)){
                SortTickets sortOrder = SortTickets.valueOf(sortBy);
                switch (sortOrder){
                    case FROMASC: return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getSource)).collect(Collectors.toList());
                    case FROMDESC: return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getSource).reversed()).collect(Collectors.toList());
                    case TICKETIDASC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getTicketId)).collect(Collectors.toList());
                    case TICKETIDDESC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getTicketId).reversed()).collect(Collectors.toList());
                    case TOASC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getDestination)).collect(Collectors.toList());
                    case TODESC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getDestination).reversed()).collect(Collectors.toList());
                    case NOOFTICKETSASC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getNoOfTickets)).collect(Collectors.toList());
                    case NOOFTICKETSDESC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getNoOfTickets).reversed()).collect(Collectors.toList());
                    case PAYMENTOPTIONASC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getPaymentOption)).collect(Collectors.toList());
                    case PAYMENTOPTIONDESC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getPaymentOption).reversed()).collect(Collectors.toList());
                    case AMOUNTASC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getAmount)).collect(Collectors.toList());
                    case AMOUNTDESC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getAmount).reversed()).collect(Collectors.toList());
                    case USERIDASC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getUid)).collect(Collectors.toList());
                    case USERIDDESC:return ticketList.stream().sorted(Comparator.comparing(TicketsDto::getUid).reversed()).collect(Collectors.toList());
                    default: return ticketList;
                }
            }
        }
        return null;
    }

    @Override
    public List<UserDto> validateAndSortUsers(String sortBy, List<UserDto> usersList) {
        if (sortBy!=null && !sortBy.isEmpty()){
            sortBy = sortBy.toUpperCase();
            if (sortUsersContainsSortBy(sortBy)){
                SortUsers sortOrder = SortUsers.valueOf(sortBy);
                switch (sortOrder){
                    case USERIDASC:return usersList.stream().sorted(Comparator.comparing(UserDto::getUid)).collect(Collectors.toList());
                    case USERIDDESC:return usersList.stream().sorted(Comparator.comparing(UserDto::getUid).reversed()).collect(Collectors.toList());
                    case NAMEASC: return usersList.stream().sorted(Comparator.comparing(UserDto::getName)).collect(Collectors.toList());
                    case NAMEDESC: return usersList.stream().sorted(Comparator.comparing(UserDto::getName).reversed()).collect(Collectors.toList());
                    case EMAILASC:return usersList.stream().sorted(Comparator.comparing(UserDto::getEmail)).collect(Collectors.toList());
                    case EMAILDESC:return usersList.stream().sorted(Comparator.comparing(UserDto::getEmail).reversed()).collect(Collectors.toList());
                    case CONTACTNOASC:return usersList.stream().sorted(Comparator.comparing(UserDto::getContactNo)).collect(Collectors.toList());
                    case CONTACTNODESC:return usersList.stream().sorted(Comparator.comparing(UserDto::getContactNo).reversed()).collect(Collectors.toList());
                    case GENDERASC:return usersList.stream().sorted(Comparator.comparing(UserDto::getGender)).collect(Collectors.toList());
                    case GENDERDESC:return usersList.stream().sorted(Comparator.comparing(UserDto::getGender).reversed()).collect(Collectors.toList());
                    case ADDRESSASC:return usersList.stream().sorted(Comparator.comparing(UserDto::getAddress)).collect(Collectors.toList());
                    case ADDRESSDESC:return usersList.stream().sorted(Comparator.comparing(UserDto::getAddress).reversed()).collect(Collectors.toList());
                    default: return usersList;
                }
            }
        }
        return null;
    }

    @Override
    public boolean validateAndUpdateUser(UserDto dto) {
        if (dto!=null){
            if (validateUser(dto)){
                return metroRepository.updateUser(dto);
            }
        }
        return false;
    }

    @Override
    public boolean validateAndRemoveUser(int id) {
        if (id>0){
            return metroRepository.removeUser(id);
        }
        return false;
    }

    @Override
    public String generateOTP() {
        int randomPin = (int)(Math.random()*9000)+1000;
        return String.valueOf(randomPin);
    }

    @Override
    public boolean verifyOTP(String otp,int id) {
        if (otp!=null && !otp.isEmpty() && id>0){
            if(otpMap.containsKey(id)){
                if(otpMap.get(id).equals(otp)){
                    otpMap.remove(id);
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public boolean addOtpTOMap(String otp,int id) {
        if (otp!=null && !otp.isEmpty() && id>0){
            otpMap.put(id,otp);
            if (otpMap.containsKey(id)){
                return true;
            }
        }
        return false;
    }

    @Override
    public void getSessions(HttpSession session) {
        Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            Object attributeValue = session.getAttribute(attributeName);
            System.out.println(attributeName+ " : " + attributeValue);
        }
    }
}
