package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.model.Bike;
import org.springframework.data.jpa.repository.JpaRepository;

public class BikeRepository extends JpaRepository<UUID, Bike> {
}
