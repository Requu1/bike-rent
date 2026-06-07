package com.bike_rent_potepa_patla.dto.views;

import java.time.LocalDateTime;

public record ViewHistPriceDto(
    Integer rentPriceHistId,
    Integer bikeId,
    String brandName,
    Integer hourlyPrice,
    LocalDateTime startDate,
    LocalDateTime endDate
) { }
