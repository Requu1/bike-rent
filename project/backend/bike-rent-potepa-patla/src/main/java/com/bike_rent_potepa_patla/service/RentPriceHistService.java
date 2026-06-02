package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.dto.rentPrice.RentPriceCreateDto;
import com.bike_rent_potepa_patla.dto.rentPrice.RentPriceResponseDto;
import com.bike_rent_potepa_patla.repository.RentPriceHistRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RentPriceHistService {
    private final RentPriceHistRepository rentPriceHistRepository;
}
