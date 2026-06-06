package com.bike_rent_potepa_patla.controller;

import com.bike_rent_potepa_patla.dto.category.CategoryCreateDto;
import com.bike_rent_potepa_patla.dto.category.CategoryResponseDto;
import com.bike_rent_potepa_patla.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/categories")
@RequiredArgsConstructor
public class CategoryController {
    private final CategoryService categoryService;

    @PostMapping
    public ResponseEntity<CategoryResponseDto> addCategory(@RequestBody CategoryCreateDto dto) {
        return ResponseEntity.ok(categoryService.addCategory(dto));
    }
}
