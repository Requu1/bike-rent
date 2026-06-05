package com.bike_rent_potepa_patla.model;

import jakarta.persistence.*;
import lombok.*;


@Entity
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder
@Table(name="Bikes")
public class Bike {
    @Column(name="BikeID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="BrandID")
    private Brand brand;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="CategoryID")
    private Category category;

    @Column(name="Quantity",nullable = false)
    private Integer quantity;
}
