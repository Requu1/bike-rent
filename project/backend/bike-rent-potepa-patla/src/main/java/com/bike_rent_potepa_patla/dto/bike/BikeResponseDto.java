package com.bike_rent_potepa_patla.dto.bike;

import lombok.Builder;

@Builder
public record BikeResponseDto(
        Long bikeId,
        String brandName,
        String categoryName,
        Integer hourlyPrice
) { }
