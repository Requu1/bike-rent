package com.bike_rent_potepa_patla.dto.views;

public record ViewBestSellersDto(
    Integer bikeId,
    String brand,
    String category,
    Integer rents
) { }
