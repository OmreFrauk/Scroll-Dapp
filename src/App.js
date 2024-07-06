// src/App.js
import React from "react";
import NavBar from "./components/NavBar";
import Header from "./components/Header";
import LaunchForm from "./components/LaunchForm";
import "./App.css";

const App = () => {
  return (
    <div className="App">
      <NavBar />
      <Header />
      <LaunchForm />
    </div>
  );
};

export default App;
