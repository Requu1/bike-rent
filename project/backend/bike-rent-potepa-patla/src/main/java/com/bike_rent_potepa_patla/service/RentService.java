package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.dto.rent.RentCreateDto;
import com.bike_rent_potepa_patla.dto.rent.RentResponseDto;
import com.bike_rent_potepa_patla.repository.RentRepository;
import jakarta.transaction.Transactional;

public class RentService {
    private RentRepository rentRepository;

    @Transactional
    RentResponseDto addRent(RentCreateDto rentCreateDto){
        rentRepository.addNewRent(rentCreateDto.bikeId(), rentCreateDto.customerId());
        return new RentResponseDto(rentCreateDto.bikeId());
    }
}
