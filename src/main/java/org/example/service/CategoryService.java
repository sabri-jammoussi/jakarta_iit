package org.example.service;

import org.example.model.Category;
import org.example.repository.CategroyRepository;

import java.util.List;

public class CategoryService {

    private final CategroyRepository categroyRepository;

    public CategoryService() {
        this.categroyRepository = new CategroyRepository();
    }

    public List<Category> getAllCategories() {
        return categroyRepository.getAllCategories();
    }
}
