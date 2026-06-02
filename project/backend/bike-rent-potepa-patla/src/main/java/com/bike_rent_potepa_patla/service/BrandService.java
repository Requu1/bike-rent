package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.model.Brand;
import com.bike_rent_potepa_patla.repository.BrandRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BrandService {
    private final BrandRepository brandRepository;

    Brand findByName(String brandName){
        return brandRepository.findByBrandName(brandName);
    }

}
