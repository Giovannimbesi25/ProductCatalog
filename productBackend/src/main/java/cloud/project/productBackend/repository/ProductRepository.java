package cloud.project.productBackend.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import cloud.project.productBackend.model.Product;

public interface ProductRepository extends JpaRepository<Product,Long>{
    List<Product> findByNameContainingIgnoreCase(String name);
}
