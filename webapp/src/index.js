import React from "react";
import ReactDOM from "react-dom/client";
import reportWebVitals from "./reportWebVitals";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Login from "./Login";
import PostManagement from "./PostManagement";
import UserManagement from "./UserManagement";
import AddUserPage from "./AddUserPage";
import "./css/index.css";
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Routes>
        <Route exact path="/" element={<Login />} />
        <Route exact path="/PostManagement" element={<PostManagement />} />
        <Route exact path="/UserManagement" element={<UserManagement />} />
        <Route exact path="/AddUserPage" element={<AddUserPage />} />
        <Route exact path="/UpdateUserPage/:id" element={<AddUserPage />} />
      </Routes>
    </BrowserRouter>
  </React.StrictMode>
);

reportWebVitals();
