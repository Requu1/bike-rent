package com.bike_rent_potepa_patla.dto.bike;

public record BikeCreateDto(
        String brandName,
        String categoryName,
        Integer hourlyPrice
) { }
