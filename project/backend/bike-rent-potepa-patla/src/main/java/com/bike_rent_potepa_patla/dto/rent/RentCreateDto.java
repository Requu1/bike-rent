package com.bike_rent_potepa_patla.dto.rent;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

public record RentCreateDto(Long bikeId, Long customerId) { }
