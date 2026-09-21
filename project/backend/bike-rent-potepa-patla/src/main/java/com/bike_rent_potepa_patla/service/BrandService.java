package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.dto.brand.BrandCreateDto;
import com.bike_rent_potepa_patla.dto.brand.BrandResponseDto;
import com.bike_rent_potepa_patla.exception.BrandNotFoundException;
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
    public BrandResponseDto addBrand(BrandCreateDto dto) {
        Integer newBrandId = brandRepository.addNewBrand(dto.brandName());
        return BrandResponseDto.builder()
                .id(newBrandId)
                .brandName(dto.brandName())
                .build();
    }

    Brand findByName(String brandName) {
        Brand brand = brandRepository.findByBrandName(brandName);
        if (brand == null) {
            throw new BrandNotFoundException("Brand not found");
        }
        return brand;
    }


}
