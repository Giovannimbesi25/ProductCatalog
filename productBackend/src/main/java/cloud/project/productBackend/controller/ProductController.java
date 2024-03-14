package cloud.project.productBackend.controller;

import cloud.project.productBackend.model.Product;
import cloud.project.productBackend.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@CrossOrigin
@RestController
@RequestMapping("/api/products")
public class ProductController {
    @Autowired
    private ProductService productService;

    @GetMapping
    public List<Product> getAllProducts(@RequestParam(required = false) Integer limit) {
        List<Product> products = productService.getAllProducts();
        
        if (limit != null) {
            return products.stream().limit(limit).toList();
        } else {
            return products;
        }
    }
    

    @GetMapping("/{productId}")
    public ResponseEntity<Product> getProductById(@PathVariable Long productId) {
        Optional<Product> productOptional = productService.getProductById(productId);

        return productOptional.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Product> createProduct(@RequestBody Product product) {
        Product savedProduct = productService.saveProduct(product);
        return ResponseEntity.status(201).body(savedProduct);
    }

    @PutMapping("/{productId}")
    public ResponseEntity<Product> updateProduct(@PathVariable Long productId, @RequestBody Product updatedProduct) {
        Optional<Product> existingProduct = productService.getProductById(productId);

        if (existingProduct.isPresent()) {
            updatedProduct.setId(productId);
            Product savedProduct = productService.saveProduct(updatedProduct);
            return ResponseEntity.ok(savedProduct);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{productId}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long productId) {
        productService.deleteProduct(productId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/search")
    public List<Product> searchProducts(@RequestParam String name) {
        return productService.searchProducts(name);
    }

    @GetMapping("/filter")
    public List<Product> filterProducts(@RequestParam(required = false) String sort) {
        return productService.filterProducts(sort);
    }
}
