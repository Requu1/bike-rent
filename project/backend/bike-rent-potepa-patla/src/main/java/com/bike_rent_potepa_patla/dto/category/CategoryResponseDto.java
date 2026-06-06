package com.bike_rent_potepa_patla.dto.category;

import lombok.Builder;

@Builder
public record CategoryResponseDto (
    Integer categoryId,
    String name
){}