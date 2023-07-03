import React, { useEffect, useState } from "react";
import "./css/Login.css";
import { Link, useNavigate } from "react-router-dom";
import Logo from "./images/logoutc2.svg";
import Api from "./api/Api";
function Login() {
  const navigate = useNavigate();
  const isLogin = localStorage.getItem("user");
  const [auth, setAuth] = useState({ username: "", password: "" });
  useEffect(() => {
    if (isLogin) navigate("/PostManagement");
  }, []);
  const set = (prop, value) => {
    setAuth({ ...auth, [prop]: value });
  };
  const handleLogin = () => {
    if (!isLogin)
      Api.login(auth).then((data) => {
        if (data.id !== -1) {
          localStorage.setItem("user", JSON.stringify(data));
          console.log(data);
          navigate("/PostManagement");
        } else if (data.emailUser === "") alert("Tên đăng nhập không tồn tại.");
        else if (data.status === 0) alert("Tài khoản đã bị khóa.");
        else alert("Mật khẩu không chính xác.");
      });
  };
  return (
    !isLogin && (
      <>
        <div className="header-login">
          <Link to="/">
            {""}
            <img src={Logo} alt="Logo" />
          </Link>
          <h1>Quản Lý Bài Đăng Về Cơ Sở Vật Chất</h1>
        </div>

        <div className="login-container" style={{ marginTop: "10px" }}>
          <form>
            <div className="div-login">
              <h1>Đăng Nhập</h1>
            </div>
            <div className="form-group">
              <label htmlFor="email">Tên đăng nhập</label>
              <input
                type="email"
                id="email"
                placeholder="Nhập tên đăng nhập"
                value={auth.username}
                onChange={(event) => set("username", event.target.value)}
                required
              />
            </div>
            <div className="form-group">
              <label htmlFor="password">Mật khẩu</label>
              <input
                type="password"
                id="password"
                placeholder="Nhập mật khẩu"
                value={auth.password}
                onChange={(event) => set("password", event.target.value)}
                required
              />
            </div>
            <button
              onClick={(event) => {
                event.preventDefault();
                handleLogin();
              }}
            >
              Đăng nhập
            </button>
          </form>
        </div>
      </>
    )
  );
}
export default Login;
