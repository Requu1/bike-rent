package com.bike_rent_potepa_patla.dto.brand;

import lombok.Builder;

@Builder
public record BrandResponseDto(
        Integer id,
        String brandName
) {
}
