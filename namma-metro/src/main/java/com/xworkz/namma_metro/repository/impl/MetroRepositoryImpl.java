package com.xworkz.namma_metro.repository.impl;

import com.xworkz.namma_metro.dto.TicketsDto;
import com.xworkz.namma_metro.dto.UserDto;
import com.xworkz.namma_metro.repository.MetroRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;

@Repository
public class MetroRepositoryImpl implements MetroRepository {

    @Autowired
    public EntityManagerFactory entityManagerFactory;

    @Override
    public boolean registerUser(UserDto dto) {
        EntityManager em = entityManagerFactory.createEntityManager();
        em.getTransaction().begin();
        em.persist(dto);
        em.getTransaction().commit();
        return true;
    }

    @Override
    public boolean buyTicket(TicketsDto dto) {
        EntityManager em = entityManagerFactory.createEntityManager();
        em.getTransaction().begin();
        em.persist(dto);
        em.getTransaction().commit();
        return true;
    }

    @Override
    public List<UserDto> fetchAllUsers() {
        EntityManager em = entityManagerFactory.createEntityManager();
        return em.createNamedQuery("getAllUses").getResultList();
    }

    @Override
    public List<TicketsDto> fetchAllTickets() {
        EntityManager em = entityManagerFactory.createEntityManager();
        return em.createNamedQuery("getAllTickets").getResultList();
    }

    @Override
    public UserDto fetchUserById(int id) {
        EntityManager em = entityManagerFactory.createEntityManager();
        return em.find(UserDto.class,id);
    }

    @Override
    public UserDto fetchUserByLoginId(String loginId) {
        EntityManager em = entityManagerFactory.createEntityManager();
        return (UserDto) em.createNamedQuery("getUserByLoginId").setParameter("name",loginId)
                .setParameter("email",loginId).getSingleResult();
    }

    @Override
    public TicketsDto fetchTicketByTicketId(int id) {
        EntityManager em = entityManagerFactory.createEntityManager();
        return em.find(TicketsDto.class,id);
    }

    @Override
    public List fetchTicketByUserId(int uid) {
        EntityManager em = entityManagerFactory.createEntityManager();
        return em.createNamedQuery("getTicketByUserId").setParameter("uid",uid).getResultList();
    }

    @Override
    public List<UserDto> filterUsers(String filter) {
        EntityManager em = entityManagerFactory.createEntityManager();
        return em.createNamedQuery("filterUsers").setParameter("name",filter).setParameter("email",filter)
                .setParameter("contactNo",filter).setParameter("gender",filter).getResultList();
    }

    @Override
    public List<TicketsDto> filterUsersTickets(String filter, int uid) {
        EntityManager em = entityManagerFactory.createEntityManager();
        return em.createNamedQuery("filterUsersTickets").setParameter("uid",uid).setParameter("source",filter)
                .setParameter("destination",filter).setParameter("paymentOption",filter)
                .setParameter("noOfTickets",filter).setParameter("amount",filter).getResultList();
    }

    @Override
    public List<TicketsDto> filterTickets(String filter) {
        EntityManager em = entityManagerFactory.createEntityManager();
        return em.createNamedQuery("filterTickets").setParameter("source",filter)
                .setParameter("destination",filter).setParameter("paymentOption",filter)
                .setParameter("noOfTickets",filter).setParameter("amount",filter).getResultList();
    }

    @Override
    public boolean updateUser(UserDto dto) {
        EntityManager em = entityManagerFactory.createEntityManager();
        em.getTransaction().begin();
        em.merge(dto);
        em.getTransaction().commit();
        return true;
    }

    @Override
    public boolean removeUser(int id) {
        EntityManager em = entityManagerFactory.createEntityManager();
        UserDto dto = em.find(UserDto.class,id);
        em.getTransaction().begin();
        /*List<TicketsDto> ticketList = fetchTicketByUserId(id);
        for (TicketsDto ticket : ticketList){
            TicketsDto removeTicket = em.find(TicketsDto.class,ticket.getTicketId());
            em.remove(removeTicket);
        }*/
        em.remove(dto);
        em.getTransaction().commit();
        return true;
    }
}
