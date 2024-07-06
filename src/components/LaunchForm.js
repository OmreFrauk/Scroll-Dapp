// src/components/LaunchForm.js
import React, { useState } from "react";
import "../App.css";

const LaunchForm = () => {
  const [form, setForm] = useState({
    tokenName: "",
    tokenSymbol: "",
    totalSupply: "",
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm({ ...form, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Handle form submission logic
    console.log("Form submitted:", form);
  };

  return (
    <form className="launch-form" onSubmit={handleSubmit}>
      <div className="form-group">
        <label>Token Name</label>
        <input
          type="text"
          name="tokenName"
          value={form.tokenName}
          onChange={handleChange}
        />
      </div>
      <div className="form-group">
        <label>Token Symbol</label>
        <input
          type="text"
          name="tokenSymbol"
          value={form.tokenSymbol}
          onChange={handleChange}
        />
      </div>
      <div className="form-group">
        <label>Total Supply</label>
        <input
          type="number"
          name="totalSupply"
          value={form.totalSupply}
          onChange={handleChange}
        />
      </div>
      <button type="submit">Launch Token</button>
    </form>
  );
};

export default LaunchForm;
