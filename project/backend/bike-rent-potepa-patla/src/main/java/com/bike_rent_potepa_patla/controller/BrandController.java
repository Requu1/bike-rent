package com.bike_rent_potepa_patla.controller;

import com.bike_rent_potepa_patla.dto.brand.BrandCreateDto;
import com.bike_rent_potepa_patla.dto.brand.BrandResponseDto;
import com.bike_rent_potepa_patla.service.BrandService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/brands")
@RequiredArgsConstructor
public class BrandController {
    private final BrandService brandService;

    @PostMapping
    public ResponseEntity<BrandResponseDto> addBrand(@RequestBody BrandCreateDto dto) {
        return ResponseEntity.ok(brandService.addBrand(dto));
    }
}
