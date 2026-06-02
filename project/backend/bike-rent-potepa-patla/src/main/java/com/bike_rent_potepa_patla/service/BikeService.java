package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.dto.bike.BikeCreateDto;
import com.bike_rent_potepa_patla.dto.bike.BikeReponseDto;
import com.bike_rent_potepa_patla.model.Bike;
import com.bike_rent_potepa_patla.repository.BikeRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BikeService {
    private final BrandService brandService;
    private final CategoryService categoryService;
    private final BikeRepository bikeRepository;


    @Transactional
    BikeReponseDto addBike(BikeCreateDto bikeCreateDto) {
        
    }
}
