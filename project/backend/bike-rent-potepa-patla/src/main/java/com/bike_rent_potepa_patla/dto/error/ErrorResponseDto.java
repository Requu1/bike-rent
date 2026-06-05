package com.bike_rent_potepa_patla.dto.error;

import lombok.Builder;

@Builder
public record ErrorResponseDto(
        String errorName,
        String errorMsg
) {
}
