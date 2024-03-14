package cloud.project.productBackend.service;

import cloud.project.productBackend.model.Product;
import cloud.project.productBackend.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public Optional<Product> getProductById(Long productId) {
        return productRepository.findById(productId);
    }

    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    public void deleteProduct(Long productId) {
        productRepository.deleteById(productId);
    }

    public List<Product> searchProducts(String searchTerm) {
        return productRepository.findByNameContainingIgnoreCase(searchTerm);
    }

    public List<Product> filterProducts(String sortString) {
        Sort sort = Sort.unsorted();
        if (sortString != null) {
            switch (sortString) {
                case "priceAsc":
                    sort = Sort.by(Sort.Order.asc("price"));
                    break;
                case "priceDesc":
                    sort = Sort.by(Sort.Order.desc("price"));
                    break;
                case "nameAsc":
                    sort = Sort.by(Sort.Order.asc("name"));
                    break;
                case "nameDesc":
                    sort = Sort.by(Sort.Order.desc("name"));
                    break;
            }
        }

        return productRepository.findAll(sort);
    }
}
