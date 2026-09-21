package com.bike_rent_potepa_patla.dto.rent;

import lombok.Builder;

import java.time.LocalDateTime;

@Builder
public record RentResponseDto(
        Integer rentId,
        Integer bikeId,
        Integer customerId,
        LocalDateTime rentDate,
        LocalDateTime returnDate
) {
}
