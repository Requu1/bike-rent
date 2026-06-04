package com.bike_rent_potepa_patla.dto.rentPrice;


import lombok.Builder;

import java.util.Date;

@Builder
public record RentPriceResponseDto(
        Long rentPriceId,
        Long bikeId,
        Integer hourlyPrice,
        Date startDate,
        Date endDate
) {
}
