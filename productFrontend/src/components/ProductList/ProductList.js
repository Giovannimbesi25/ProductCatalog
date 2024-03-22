import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import ProductService from '../../services/ProductService';
import './ProductList.css';

const ProductList = () => {

  const navigate = useNavigate();
  const [products, setProducts] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterOption, setFilterOption] = useState('');


  useEffect(() => {

    const fetchProducts = async () => {
      try {
        let response;
  
        if (searchTerm.length > 0) {
          response = await ProductService.searchProducts(searchTerm);
        } else if (filterOption !== 'none') {
          response = await ProductService.filterProducts(filterOption);
        } else {
          response = await ProductService.getAllProducts(20);
        }
  
        setProducts(response.data);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchProducts();
  }, [searchTerm, filterOption]);



  return (
    <div className="container">
      <h1>Product List</h1>
      <div className="filter-container">
        <Link to="/products/new" className="newProduct-button">
          Add New Product
        </Link>

        <input
          type="text"
          placeholder="Search by name"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />

        <select
          value={filterOption}
          onChange={(e) => setFilterOption(e.target.value)}
        >
          <option value="none">None</option>
          <option value="priceAsc">Price: Low to High</option>
          <option value="priceDesc">Price: High to Low</option>
          <option value="nameAsc">Name: A to Z</option>
          <option value="nameDesc">Name: Z to A</option>
        </select>


      </div>

      <div className="list">
        {products.map((product) => (
          <div key={product.id} className="product">
            <p className="product-name">{product.name}</p>
            <p>{product.description}</p>
            <p className="product-price">${product.price}</p>
            <button
              onClick={() => navigate(`/products/${product.id}`)}
              className="link-button"
            >
              Edit
            </button>
          </div>
        ))}
      </div>
      <div className="link-button-container"></div>
    </div>
  );
};

export default ProductList;
