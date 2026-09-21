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
@Table(name = "Customers")
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "Firstname", nullable = false)
    private String firstName;

    @Column(name = "Surrname", nullable = false)
    private String surname;

    @Column(name = "Phone", nullable = false)
    @Size(min = 15, max = 15)
    private String phone;
}
