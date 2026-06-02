package com.bike_rent_potepa_patla.dto.rent;


import lombok.Builder;

import java.time.LocalDate;

@Builder
public record RentResponseDto(
        Long rentId,
        Long bikeId,
        Long customerId,
        LocalDate rentDate,
        LocalDate returnDate
) {}
