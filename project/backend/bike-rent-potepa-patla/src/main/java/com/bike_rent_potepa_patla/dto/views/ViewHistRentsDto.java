package com.bike_rent_potepa_patla.dto.views;

import java.time.LocalDate;

public record ViewHistRentsDto(
    Integer rentId,
    Integer bikeId,
    String brandName,
    String firstName,
    String surrName,
    LocalDate rentDate,
    LocalDate returnDate
) { }
