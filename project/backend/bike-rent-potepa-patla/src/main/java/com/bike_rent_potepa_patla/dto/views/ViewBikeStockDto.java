package com.bike_rent_potepa_patla.dto.views;

public record ViewBikeStockDto (
    Integer bikeId,
    String brand,
    String category,
    Integer quantity,
    Integer hourlyPrice
){ }
