package com.bike_rent_potepa_patla.controller;

import com.bike_rent_potepa_patla.dto.views.*;
import com.bike_rent_potepa_patla.service.ViewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/views")
@RequiredArgsConstructor
public class ViewController {
    private final ViewService viewService;

    @GetMapping("/active-rents")
    public ResponseEntity<List<ViewActiveRentsDto>> viewActiveRents(){
        return ResponseEntity.ok(viewService.viewActiveRents());
    }

    @GetMapping("/best-sellers")
    public ResponseEntity<List<ViewBestSellersDto>> viewBestSellers() {
        return ResponseEntity.ok(viewService.viewBestSellers());
    }

    @GetMapping("/best-selling-brands")
    public ResponseEntity<List<ViewBestSellingBrandsDto>> viewBestSellingBrands() {
        return ResponseEntity.ok(viewService.viewBestSellingBrands());
    }

    @GetMapping("/bike-stock")
    public ResponseEntity<List<ViewBikeStockDto>> viewBikeStock() {
        return ResponseEntity.ok(viewService.viewBikeStock());
    }

    @GetMapping("/customers")
    public ResponseEntity<List<ViewCustomersDto>> viewCustomers() {
        return ResponseEntity.ok(viewService.viewCustomers());
    }

    @GetMapping("/most-rented-category")
    public ResponseEntity<List<ViewMostRentedCategoryDto>> viewMostRentedCategory() {
        return ResponseEntity.ok(viewService.viewMostRentedCategory());
    }

    @GetMapping("/hist-rents")
    public ResponseEntity<List<ViewHistRentsDto>> viewHistRents() {
        return ResponseEntity.ok(viewService.viewHistRents());
    }

    @GetMapping("/hist-price")
    public ResponseEntity<List<ViewHistPriceDto>> viewHistPrice() {
        return ResponseEntity.ok(viewService.viewHistPrice());
    }
}
