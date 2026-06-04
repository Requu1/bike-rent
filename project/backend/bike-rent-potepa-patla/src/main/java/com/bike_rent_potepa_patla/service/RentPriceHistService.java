package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.dto.rentPrice.RentPriceCreateDto;
import com.bike_rent_potepa_patla.dto.rentPrice.RentPriceResponseDto;
import com.bike_rent_potepa_patla.model.RentPriceHist;
import com.bike_rent_potepa_patla.repository.RentPriceHistRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
@RequiredArgsConstructor
public class RentPriceHistService {
    private final RentPriceHistRepository rentPriceHistRepository;

    @Transactional
    public RentPriceResponseDto changeRentPrice(RentPriceCreateDto dto) {
        Long newRentPriceId=rentPriceHistRepository.changeRentPrice(dto.bikeId(),dto.hourlyPrice());
        return new RentPriceResponseDto(newRentPriceId,
                dto.bikeId(),dto.hourlyPrice(),findStartDateForNewRentPrice(newRentPriceId),null );
    }


    private Date findStartDateForNewRentPrice(Long id){
        RentPriceHist rentPrice=rentPriceHistRepository.findRentPriceHistById(id);
        return rentPrice.getStartDate();
    }
}
