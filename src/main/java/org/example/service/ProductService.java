package org.example.service;

import org.example.model.Product;

import java.util.List;
import java.util.stream.Collectors;

public class ProductService {

    private final CategoryService categoryService;

    public ProductService() {
        this.categoryService = new CategoryService();
    }

    public List<Product> getAllProducts() {
        return categoryService.getAllCategories()
                .stream()
                .flatMap(category -> category.getProducts().stream())
                .collect(Collectors.toList());
    }

    public List<Product> getProductsByCategoryName(String categoryName) {
        return categoryService.getAllCategories()
                .stream()
                .filter(c -> c.getName().equalsIgnoreCase(categoryName))
                .findFirst()
                .map(c -> c.getProducts())
                .orElse(List.of());
    }
}