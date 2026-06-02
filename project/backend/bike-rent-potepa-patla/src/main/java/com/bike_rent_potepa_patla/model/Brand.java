package com.bike_rent_potepa_patla.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder
@Table(name="Brands")
public class Brand {
    @Column(name="BrandID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="BrandName",nullable = false)
    private String brandName;
}
