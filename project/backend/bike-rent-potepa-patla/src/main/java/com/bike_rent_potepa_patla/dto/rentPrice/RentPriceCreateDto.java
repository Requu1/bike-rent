package com.bike_rent_potepa_patla.dto.rentPrice;

public record RentPriceCreateDto(
        Long bikeId,
        Integer hourlyPrice
) {
}
