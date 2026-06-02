package com.bike_rent_potepa_patla.model;


import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder
@Table(name="RentPriceHist")
public class RentPriceHist {
    @Column(name="RentPriceHistID")
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="BikeID")
    private Bike bike;

    @Column(name="HourlyPrice",nullable = false)
    private int hourlyPrice;

    @Column(name="StartDate",nullable = false)
    private Date startDate;

    @Column(name="EndDate",nullable = true)
    private Date endDate;

}
