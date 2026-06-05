package com.bike_rent_potepa_patla.dto.rent;

import java.time.LocalDate;

public record RentsForCustomerDto(
        Integer rentId,
        Integer bikeId,
        LocalDate rentDate,
        LocalDate returnDate
) { }
