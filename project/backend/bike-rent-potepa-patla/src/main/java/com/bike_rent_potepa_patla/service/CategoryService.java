package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.dto.category.CategoryCreateDto;
import com.bike_rent_potepa_patla.dto.category.CategoryResponseDto;
import com.bike_rent_potepa_patla.exception.CategoryNotFoundException;
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
        Integer newCategoryId=categoryRepository.addNewCategory(dto.name());
        return CategoryResponseDto.builder()
                .categoryId(newCategoryId)
                .name(dto.name())
                .build();
    }

    Category findByName(String categoryName) {
        Category category= categoryRepository.findByCategoryName(categoryName);
        if(category==null){
            throw new CategoryNotFoundException("Category not found");
        }
        return category;
    }
}
