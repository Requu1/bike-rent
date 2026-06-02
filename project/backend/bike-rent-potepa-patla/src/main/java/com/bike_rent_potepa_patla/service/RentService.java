package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.repository.RentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RentService {
    private final RentRepository rentRepository;


}
