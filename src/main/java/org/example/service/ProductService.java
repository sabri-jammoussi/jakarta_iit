package org.example.service;

import org.example.model.Product;
import org.example.repository.ProductRepository;

import java.util.List;

public class ProductService {

    private final ProductRepository productRepository;

    public ProductService() {
        this.productRepository = new ProductRepository();
    }

    public List<Product> getAllProducts() {
        return productRepository.getAllProducts();
    }

    public Product getProductById(int id) {
        if (id <= 0) throw new IllegalArgumentException("Product id must be positive");
        return productRepository.getProductById(id);
    }

    public boolean addProduct(String name, double price, String description, int categoryId, String imageUrl) {
        Product p = new Product(name, price, description, categoryId, imageUrl);
        return productRepository.addProduct(p);
    }

    public boolean updateProduct(int id, String name, double price, String description, int categoryId, String imageUrl) {
        if (id <= 0) throw new IllegalArgumentException("Product id must be positive");
        Product p = new Product(id, name, price, description, categoryId, imageUrl);
        return productRepository.updateProduct(id, p);
    }

    public boolean deleteProduct(int id) {
        if (id <= 0) throw new IllegalArgumentException("Product id must be positive");
        return productRepository.deleteProduct(id);
    }
}