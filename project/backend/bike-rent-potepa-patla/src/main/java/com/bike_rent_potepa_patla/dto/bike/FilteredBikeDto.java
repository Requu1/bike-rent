package com.bike_rent_potepa_patla.dto.bike;

import lombok.Builder;

@Builder
public record FilteredBikeDto(
        Integer bikeId,
        Integer quantity
) {
}
