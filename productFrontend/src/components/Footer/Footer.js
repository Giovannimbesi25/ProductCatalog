import React from "react";
import { Link } from 'react-router-dom';
import './Footer.css'; 

function Footer(){
    return(
        <footer>
        <div>
          <nav>
          <div className="button-container">
            <Link to="/" className="link-button">Home</Link>
          </div>
          </nav>
        </div>
      </footer>
    )
}

export default Footer;