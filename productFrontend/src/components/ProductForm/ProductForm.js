// ProductForm.js
import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import ProductService from '../../services/ProductService';
import './ProductForm.css';
import Footer from '../Footer/Footer';

const ProductForm = () => {
  const { productId } = useParams();
  const navigate = useNavigate();
  const [product, setProduct] = useState({ name: '', description: '', price: 0 });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchProduct = async () => {
      try {
        if (productId) {
          const response = await ProductService.getProductById(productId);
          setProduct(response.data);
        }
      } catch (error) {
        console.error('Error fetching product details:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchProduct();
  }, [productId]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setProduct(prevProduct => ({ ...prevProduct, [name]: value }));
  };

  const handleDelete = async () => {
    try {
      await ProductService.deleteProduct(productId);
      navigate('/');
    } catch (error) {
      console.error('Error deleting product:', error);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      if (productId) {
        await ProductService.updateProduct(productId, product);
      } else {
        await ProductService.createProduct(product);
      }
      navigate('/');
    } catch (error) {
      console.error('Error submitting product:', error);
    }
  };

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <div className="container">
      <h2>{productId ? 'Edit Product' : 'Add New Product'}</h2>
      <form className="form" onSubmit={handleSubmit}>
        <div className="input-group">
          <label className="label" htmlFor="name">Name</label>
          <input
            className="input"
            type="text"
            id="name"
            name="name"
            value={product.name}
            onChange={handleChange}
            required
          />
        </div>
        <div className="input-group">
          <label className="label" htmlFor="description">Description</label>
          <input
            className="input"
            type="text"
            id="description"
            name="description"
            value={product.description}
            onChange={handleChange}
          />
        </div>
        <div className="input-group">
          <label className="label" htmlFor="price">Price</label>
          <input
            className="input"
            type="number"
            id="price"
            name="price"
            value={product.price}
            onChange={handleChange}
            required
          />
        </div>
        <div className="button-container">
          <button type="submit" className="link-button">
            {productId ? 'Update Product' : 'Create Product'}
          </button>
          {productId && (
            <button type="button" onClick={handleDelete} className="delete-button">
              Delete Product
            </button>
          )}
        </div>
      </form>
      <Footer />
    </div>
  );
};

export default ProductForm;
