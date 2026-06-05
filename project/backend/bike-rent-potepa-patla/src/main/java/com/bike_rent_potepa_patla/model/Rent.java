package com.bike_rent_potepa_patla.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder
@Table(name="Rents")
public class Rent {
    @Column(name="RentID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="BikeID")
    private Bike bike;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="CustomerID")
    private Customer customer;

    @Column(name="RentDate",nullable = false)
    private LocalDate rentDate;

    @Column(name="ReturnDate",nullable = true)
    private LocalDate returnDate;

}
