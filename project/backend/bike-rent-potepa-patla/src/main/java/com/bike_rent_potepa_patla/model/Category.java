package com.bike_rent_potepa_patla.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder
public class Category {
    @Column(name="CategoryID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="CategoryName",nullable = false)
    private String categoryName;
}
