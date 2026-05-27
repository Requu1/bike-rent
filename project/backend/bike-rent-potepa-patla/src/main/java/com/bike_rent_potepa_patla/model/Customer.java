package com.bike_rent_potepa_patla.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="FirstName",nullable = false)
    private String firstName;

    @Column(name="LastName",nullable = false)
    private String lastName;

    @Column(name="Phone",nullable = false)
    @Size(min=15,max=15)
    private String phone;
}
