package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.dto.bike.BikeCreateDto;
import com.bike_rent_potepa_patla.dto.bike.BikeResponseDto;
import com.bike_rent_potepa_patla.repository.BikeRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BikeService {
    private final BikeRepository bikeRepository;
    private final BrandService brandService;
    private final CategoryService categoryService;

    @Transactional
    BikeResponseDto addBike(BikeCreateDto bikeCreateDto) {
        bikeRepository.addNewBikeWithNewPriceHist(
                brandService.findByName(bikeCreateDto.brandName()).getId(),
                categoryService.findByName(bikeCreateDto.categoryName()).getId(),
                bikeCreateDto.hourlyPrice()
        );

        return new BikeResponseDto
                (null, bikeCreateDto.brandName(), bikeCreateDto.categoryName(), bikeCreateDto.hourlyPrice());
    }
}
