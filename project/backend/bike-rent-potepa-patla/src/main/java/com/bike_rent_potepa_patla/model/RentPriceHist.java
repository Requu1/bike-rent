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
@Table(name = "RentPriceHist")
public class RentPriceHist {
    @Column(name = "RentPriceHistID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BikeID")
    private Bike bike;

    @Column(name = "HourlyPrice", nullable = false)
    private Integer hourlyPrice;

    @Column(name = "StartDate", nullable = false)
    private LocalDate startDate;

    @Column(name = "EndDate")
    private LocalDate endDate;

}
