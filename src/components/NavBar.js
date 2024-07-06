// src/components/NavBar.js
import React from "react";
import "../App.css";

const NavBar = () => {
  return (
    <nav className="navbar">
      <div className="navbar-logo">Token Launchpad</div>
      <ul className="navbar-links">
        <li>
          <a href="#home">Home</a>
        </li>
        <li>
          <a href="#about">About</a>
        </li>
        <li>
          <a href="#launch">Launch</a>
        </li>
      </ul>
    </nav>
  );
};

export default NavBar;
