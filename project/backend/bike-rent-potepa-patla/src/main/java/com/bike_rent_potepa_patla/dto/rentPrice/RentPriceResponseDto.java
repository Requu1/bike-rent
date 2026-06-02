package com.bike_rent_potepa_patla.dto.rentPrice;


import lombok.Builder;

import java.time.LocalDate;

@Builder
public record RentPriceResponseDto(
        Long bikeId,
        Integer hourlyPrice,
        LocalDate startDate,
        LocalDate endDate
) {
}
