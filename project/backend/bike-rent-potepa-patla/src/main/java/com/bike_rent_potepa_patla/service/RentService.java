package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.dto.rent.RentCreateDto;
import com.bike_rent_potepa_patla.dto.rent.RentResponseDto;
import com.bike_rent_potepa_patla.dto.rent.RentsForCustomerDto;
import com.bike_rent_potepa_patla.repository.RentRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RentService {
    private final RentRepository rentRepository;

    @Transactional
    public RentResponseDto addRent(RentCreateDto dto) {
        Integer newRentId=rentRepository.addNewRent(dto.bikeId(),dto.customerId());
        return RentResponseDto.builder()
                .rentId(newRentId)
                .bikeId(dto.bikeId())
                .customerId(dto.customerId())
                .rentDate(rentRepository.findRentById(newRentId).getRentDate())
                .returnDate(null)
                .build();
    }

    @Transactional
    public void endRent(Integer rentId){
        rentRepository.endRent(rentId);
    }

    @Transactional
    public List<RentsForCustomerDto> getRentListForCustomer(Integer customerId){
        return rentRepository.getCurrentRentsForCustomer(customerId);
    }

    @Transactional
    public Integer getIncome(LocalDate startDate, LocalDate endDate){
        return rentRepository.getIncome(startDate.atStartOfDay(),endDate.atTime(LocalTime.MAX));
    }
}
