package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.model.Bike;
import com.bike_rent_potepa_patla.repository.BikeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BikeService {
    private final BikeRepository bikeRepository;
}
