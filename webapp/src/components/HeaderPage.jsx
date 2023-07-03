import React from "react";
import { Link, useNavigate } from "react-router-dom";
import Logo from "../images/logoutc2.svg";
import "../css/HeaderPage.css";
function HeaderPage() {
  const navigate = useNavigate();
  const handleLogout = (event) => {
    localStorage.clear();
    navigate("/");
  };
  return (
    <>
      <div className="header-homepage">
        <Link to="#">
          <img src={Logo} style={{ height: "120px" }} alt="Logo" />
        </Link>
        <h1>Quản Lý Bài Viết Về Cơ Sở Vật Chất</h1>
      </div>
      <div className="header-homepage-container">
        <ul>
          <li
            style={
              window.location.pathname === "/PostManagement"
                ? { backgroundColor: "#9fddff7c" }
                : {}
            }
          >
            <Link to={"/PostManagement"}>Quản lý bài post</Link>
          </li>
          <li
            style={
              window.location.pathname === "/UserManagement"
                ? { backgroundColor: "#9fddff7c" }
                : {}
            }
          >
            <Link to={"/UserManagement"}>Quản lý tài khoản</Link>
          </li>

          <li className="homepage-logout">
            <div onClick={(event) => handleLogout(event)}>
              <Link to={false}>Đăng xuất</Link>
            </div>
          </li>
        </ul>
      </div>
    </>
  );
}
export default HeaderPage;
