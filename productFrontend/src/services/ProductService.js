import axios from 'axios';

const API_BASE_URL = process.env.REACT_APP_URL || 'http://localhost:8080/api/products';

// const API_BASE_URL = "http://product-backend-service:8080/api/products";

console.log("Prova", process.env.API_BASE_URL)

const ProductService = {
  getAllProducts: (limit) => axios.get(`${API_BASE_URL}?limit=${limit}`),
  getProductById: (productId) => axios.get(`${API_BASE_URL}/${productId}`),
  createProduct: (product) => axios.post(API_BASE_URL, product),
  updateProduct: (productId, updatedProduct) => axios.put(`${API_BASE_URL}/${productId}`, updatedProduct),
  deleteProduct: (productId) => axios.delete(`${API_BASE_URL}/${productId}`),
  searchProducts: (searchTerm) => axios.get(`${API_BASE_URL}/search?name=${searchTerm}`),
  filterProducts: (filterOption) => {
    let endpoint = `${API_BASE_URL}/filter?sort=${filterOption}`
    return axios.get(endpoint)
  },
};

export default ProductService;
