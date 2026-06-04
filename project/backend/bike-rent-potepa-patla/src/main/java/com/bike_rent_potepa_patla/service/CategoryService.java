package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.dto.category.CategoryCreateDto;
import com.bike_rent_potepa_patla.dto.category.CategoryResponseDto;
import com.bike_rent_potepa_patla.model.Category;
import com.bike_rent_potepa_patla.repository.CategoryRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryService {
    private final CategoryRepository categoryRepository;

    @Transactional
    public CategoryResponseDto addCategory(CategoryCreateDto dto){
        Long newCategoryId=categoryRepository.addNewCategory(dto.name());
        return new  CategoryResponseDto(newCategoryId,dto.name());
    }

    Category findByName(String categoryName) {
        return categoryRepository.findByCategoryName(categoryName);
    }
}
