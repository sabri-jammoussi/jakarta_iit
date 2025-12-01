package org.example.repository;

import org.example.model.Category;
import org.example.model.Product;

import java.util.List;

public class CategroyRepository {

    private static List<Category> categories = List.of(
            new Category("Electronics", "Devices and gadgets", List.of(
                    new Product("Laptop", 912.99, "A high-performance laptop"),
                    new Product("Smartphone", 699.99, "A latest model smartphone"),
                    new Product("Headphones", 199.99, "Noise-cancelling headphones")
            )),
            new Category("Apparel", "Various clothes", List.of(
                    new Product("Shirts", 99.99, "A high-quality shirt"),
                    new Product("Pants", 29.99, "A latest model Pants"),
                    new Product("Dresses", 119.09, "very stylish dresses")
            )));

    public CategroyRepository() {

    }

    public List<Category> getAllCategories() {
        return categories;
    }

}
