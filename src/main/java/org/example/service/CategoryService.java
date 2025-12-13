package org.example.service;

import org.example.model.Category;
import org.example.repository.CategoryRepository;

import java.util.List;

public class CategoryService {

    private final CategoryRepository categroyRepository;

    public CategoryService() {
        this.categroyRepository = new CategoryRepository();
    }

    public List<Category> getAllCategories() {
        return categroyRepository.getAllCategories();
    }

    public Category getCategoryById(int id) {
        if (id <= 0) throw new IllegalArgumentException("Category ID must be positive");
        return categroyRepository.getCategoryById(id);
    }

    public boolean addCategory(Category category) {
        if (category == null) throw new IllegalArgumentException("Category cannot be null");
        return categroyRepository.addCategory(category);
    }

    public boolean updateCategory(int id, Category category) {
        if (id <= 0) throw new IllegalArgumentException("Category ID must be positive");
        if (category == null) throw new IllegalArgumentException("Category cannot be null");
        return categroyRepository.updateCategory(id, category);
    }

    public boolean deleteCategory(int id) {
        if (id <= 0) throw new IllegalArgumentException("Category ID must be positive");
        return categroyRepository.deleteCategory(id);
    }
}
