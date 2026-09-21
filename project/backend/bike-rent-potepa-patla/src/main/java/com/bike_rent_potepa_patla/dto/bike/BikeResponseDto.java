package com.bike_rent_potepa_patla.dto.bike;

import lombok.Builder;

@Builder
public record BikeResponseDto(
        Integer bikeId,
        String brandName,
        String categoryName,
        Integer hourlyPrice
) {
}
