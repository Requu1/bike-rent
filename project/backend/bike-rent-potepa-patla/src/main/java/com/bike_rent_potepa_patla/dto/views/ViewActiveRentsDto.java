package com.bike_rent_potepa_patla.dto.views;


import java.time.LocalDateTime;

public record ViewActiveRentsDto(
        String customerName,
        Integer rentId,
        Integer bikeId,
        String brandName,
        LocalDateTime rentDate,
        Integer rentPrice
) {
}
