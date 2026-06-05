package com.bike_rent_potepa_patla.dto.rent;

import java.util.Date;

public record RentsForCustomerDto(
        Long rentId,
        Long bikeId,
        Date rentDate,
        Date returnDate
) { }
