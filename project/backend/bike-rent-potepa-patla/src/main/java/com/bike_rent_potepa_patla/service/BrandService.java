package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.dto.brand.BrandCreateDto;
import com.bike_rent_potepa_patla.dto.brand.BrandResponseDto;
import com.bike_rent_potepa_patla.model.Brand;
import com.bike_rent_potepa_patla.repository.BrandRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BrandService {
    private final BrandRepository brandRepository;

    @Transactional
    BrandResponseDto addBrand(BrandCreateDto dto){
        Long newBrandId=brandRepository.addNewBrand(dto.brandName());
        return new BrandResponseDto(newBrandId,dto.brandName());

    }

    Brand findByName(String brandName){
        return brandRepository.findByBrandName(brandName);
    }

}
