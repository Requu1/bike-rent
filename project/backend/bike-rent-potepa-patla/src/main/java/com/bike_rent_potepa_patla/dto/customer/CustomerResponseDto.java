package com.bike_rent_potepa_patla.dto.customer;

import lombok.Builder;

@Builder
public record CustomerResponseDto(
        Long customerId,
        String firstName,
        String surrName,
        String phone
) {
}
