package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.dto.rentPrice.RentPriceCreateDto;
import com.bike_rent_potepa_patla.dto.rentPrice.RentPriceResponseDto;
import com.bike_rent_potepa_patla.model.RentPriceHist;
import com.bike_rent_potepa_patla.repository.RentPriceHistRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;

@Service
@RequiredArgsConstructor
public class RentPriceHistService {
    private final RentPriceHistRepository rentPriceHistRepository;

    @Transactional
    public RentPriceResponseDto changeRentPrice(RentPriceCreateDto dto) {
        Integer newRentPriceId=rentPriceHistRepository.changeRentPrice(dto.bikeId(),dto.hourlyPrice());
        return RentPriceResponseDto.builder()
                .rentPriceId(newRentPriceId)
                .bikeId(dto.bikeId())
                .hourlyPrice(dto.hourlyPrice())
                .startDate(findStartDateForNewRentPrice(newRentPriceId))
                .endDate(null)
                .build();
    }

    @Transactional
    public Integer getRentTotalPrice(Integer rentId){
        return rentPriceHistRepository.getRentalPrice(rentId);
    }

    @Transactional
    public Integer getAvgBikeRentPrice(Integer bikeId, LocalDate startDate, LocalDate endDate){
        return rentPriceHistRepository.avgBikeRentPrice(bikeId,startDate.atStartOfDay(),endDate.atTime(LocalTime.MAX));
    }

    private LocalDate findStartDateForNewRentPrice(Integer rentPriceId){
        RentPriceHist rentPrice=rentPriceHistRepository.findRentPriceHistById(rentPriceId);
        return rentPrice.getStartDate();
    }


}
