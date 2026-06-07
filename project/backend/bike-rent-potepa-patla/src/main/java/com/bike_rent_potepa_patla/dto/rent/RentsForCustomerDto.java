package com.bike_rent_potepa_patla.dto.rent;

import java.time.LocalDateTime;

public record RentsForCustomerDto(
        Integer rentId,
        Integer bikeId,
        LocalDateTime rentDate,
        LocalDateTime returnDate
) { }
