package com.bike_rent_potepa_patla.dto.views;

import java.time.LocalDate;

public record ViewActiveRentsDto(
        String customerName,
        Integer rentId,
        Integer bikeId,
        String brandName,
        LocalDate rentDate,
        Integer rentPrice
) { }
