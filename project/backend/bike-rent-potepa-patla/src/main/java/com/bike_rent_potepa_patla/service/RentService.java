package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.dto.rent.RentCreateDto;
import com.bike_rent_potepa_patla.dto.rent.RentResponseDto;
import com.bike_rent_potepa_patla.dto.rent.RentsForCustomerDto;
import com.bike_rent_potepa_patla.model.Rent;
import com.bike_rent_potepa_patla.repository.RentRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RentService {
    private final RentRepository rentRepository;

    @Transactional
    public RentResponseDto addRent(RentCreateDto dto) {
        Long newRentId=rentRepository.addNewRent(dto.bikeId(),dto.customerId());
        return RentResponseDto.builder()
                .rentId(newRentId)
                .bikeId(dto.bikeId())
                .customerId(dto.customerId())
                .rentDate(findRentById(newRentId).getRentDate())
                .returnDate(null)
                .build();
    }

    @Transactional
    public void endRent(Long rentId){
        rentRepository.endRent(rentId);
    }

    @Transactional
    public List<RentsForCustomerDto> getRentListForCustomer(Long customerId){
        return rentRepository.getCurrentRentsForCustomer(customerId);
    }

    public int getIncome(Date startDate, Date endDate){
        return rentRepository.getIncome(startDate,endDate);
    }

    private Rent findRentById(Long rentId){
        return rentRepository.findRentById(rentId);
    }

}
