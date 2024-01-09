package com.xworkz.namma_metro.dto;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@Entity
@Table(name = "tickets")
@NamedQueries({
        @NamedQuery(name = "getAllTickets", query = "from TicketsDto dto"),
        @NamedQuery(name = "getTicketByUserId", query = "from TicketsDto dto where dto.uid=:uid"),
        @NamedQuery(name = "filterUsersTickets",query = "from TicketsDto dto where dto.uid=:uid AND (dto.source LIKE CONCAT('%',:source,'%') OR dto.destination LIKE CONCAT('%',:destination,'%') OR dto.paymentOption LIKE CONCAT('%',:paymentOption,'%') OR dto.noOfTickets LIKE CONCAT('%',:noOfTickets,'%') OR dto.amount LIKE CONCAT('%',:amount,'%'))"),
        @NamedQuery(name = "filterTickets",query = "from TicketsDto dto where dto.source LIKE CONCAT('%',:source,'%') OR dto.destination LIKE CONCAT('%',:destination,'%') OR dto.paymentOption LIKE CONCAT('%',:paymentOption,'%') OR dto.noOfTickets LIKE CONCAT('%',:noOfTickets,'%') OR dto.amount LIKE CONCAT('%',:amount,'%')")
})
public class TicketsDto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ticketId;

    @NotNull
    @NotBlank(message = "from not selected")
    private String source;

    @NotNull
    @NotBlank(message = "to not selected")
    private String destination;

    @NotNull
    private int noOfTickets;

    @NotNull
    @NotBlank(message = "payment option not selected")
    private String paymentOption;

    @NotNull
    private double amount;

    @NotNull
    private int uid;
}
