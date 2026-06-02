package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category,Long> {
    @Procedure(name="AddCategory_p")
    void addNewCategory(@Param("categoryName_v")String categoryName);

    Category findByCategoryName(String categoryName);
}
