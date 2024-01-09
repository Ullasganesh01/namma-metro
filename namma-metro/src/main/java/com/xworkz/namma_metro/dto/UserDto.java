package com.xworkz.namma_metro.dto;

import lombok.Data;
import org.hibernate.validator.constraints.UniqueElements;

import javax.persistence.*;
import javax.validation.constraints.*;

@Data
@Entity
@Table(name = "users")
@NamedQueries({
        @NamedQuery(name = "getAllUses", query = "from UserDto dto"),
        @NamedQuery(name = "getUserByLoginId", query = "from UserDto dto where dto.name=:name OR dto.email=:email"),
        @NamedQuery(name = "filterUsers",query = "from UserDto dto where dto.name LIKE CONCAT('%',:name,'%') OR dto.email LIKE CONCAT('%',:email,'%') OR dto.contactNo LIKE CONCAT('%',:contactNo,'%') OR dto.gender LIKE CONCAT('%',:gender,'%')")
})
public class UserDto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int uid;

    @NotNull
    @NotBlank
    @Column(unique = true)
    @Size(min = 3,max = 15,message = "name length must be between 3 and 15")
    private String name;

    @NotNull
    @NotBlank
    @Column(unique = true)
    @Pattern(regexp = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$",message = "email must be in abc@gmail.com format")
    private String email;

    @NotNull
    @Min(value = 1000000000,message = "Number must contain 10 digits")
    private long contactNo;

    @NotNull
    @NotBlank
    private String gender;

    @NotNull
    @NotBlank
    @Size(min = 4,max = 40,message = "address must be between 4 and 40")
    private String address;

    @NotNull
    @NotBlank
    @Size(min = 7,max = 15,message = "password length must be between 7 and 15")
    private String password;
}
