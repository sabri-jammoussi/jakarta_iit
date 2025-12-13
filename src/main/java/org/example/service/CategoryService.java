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
}
