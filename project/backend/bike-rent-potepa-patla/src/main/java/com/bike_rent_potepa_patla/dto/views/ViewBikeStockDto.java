package com.bike_rent_potepa_patla.dto.views;

public record ViewBikeStockDto (
    Integer bikeId,
    String brandName,
    String categoryName,
    Integer quantity,
    Integer hourlyPrice
){ }
