package com.bike_rent_potepa_patla.service;


import com.bike_rent_potepa_patla.dto.bike.BikeCreateDto;
import com.bike_rent_potepa_patla.dto.bike.BikeResponseDto;
import com.bike_rent_potepa_patla.dto.bike.FilteredBikeDto;
import com.bike_rent_potepa_patla.repository.BikeRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BikeService {
    private final BikeRepository bikeRepository;
    private final BrandService brandService;
    private final CategoryService categoryService;

    @Transactional
    public BikeResponseDto addBike(BikeCreateDto bikeCreateDto) {
        Long newBikeId=bikeRepository.addNewBikeWithNewPriceHist(
                brandService.findByName(bikeCreateDto.brandName()).getId(),
                categoryService.findByName(bikeCreateDto.categoryName()).getId(),
                bikeCreateDto.hourlyPrice()
        );

        return new BikeResponseDto
                (newBikeId, bikeCreateDto.brandName(), bikeCreateDto.categoryName(), bikeCreateDto.hourlyPrice());
    }

    @Transactional
    public void addBikeQuantity(Integer quantity,Long bikeId){
        bikeRepository.addBikeQuantity(quantity,bikeId);
    }

    @Transactional
    List<FilteredBikeDto> filterBikesByBrandAndCategory(String categoryName,String brandName){
        return bikeRepository.getBikesByCategoryAndBrand(categoryName,brandName);
    }
}
