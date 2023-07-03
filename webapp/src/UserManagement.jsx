import React, { useEffect, useState } from "react";
import HeaderPage from "./components/HeaderPage";
import { Link, useNavigate } from "react-router-dom";
import "./css/UserManagement.css";
import Api from "./api/Api";
import { FiUserX, FiUserCheck } from "react-icons/fi";
import moment from "moment";
import CustomFormGroup from "./components/CustomFormGroup";
const UserManagement = () => {
  const navigate = useNavigate();
  const isLogin = localStorage.getItem("user");

  const [users, setUsers] = useState([]);
  const [current, setCurrent] = useState([]);
  const [keyword, setKeyword] = useState("");
  const [typeSearch, setTypeSearch] = useState("nameUser");
  useEffect(() => {
    if (!isLogin) navigate("/");
    if (isLogin)
      Api.fetchAllUsers().then((data) => {
        setUsers(data);
        setCurrent(data);
        console.log(data);
      });
  }, [window.location.href]);
  const changeStatus = (idUser) => {
    if (isLogin)
      Api.deleteUser(idUser).then((data) => {
        console.log(data);
        setUsers(
          users.map((u) =>
            u.id === idUser ? { ...u, status: u.status === 1 ? 0 : 1 } : u
          )
        );
      });
  };
  const handleSearch = () => {
    setUsers(
      current.filter((u) =>
        // (!Number.isNaN(u[typeSearch])
        //   ? u[typeSearch]
        //   : 
        // )
        u[typeSearch].toLowerCase() .includes( keyword.toLowerCase())
      )
    );
  };
  const handleCancel = () => {
    setKeyword("");
    setTypeSearch("nameUser");
    setUsers(current);
  };

  return (
    isLogin && (
      <>
        <HeaderPage />
        <div className="user-no" style={{ textAlign: "center" }}>
          <h2>Quản lý tài khoản người dùng</h2>
          <div>
            <div style={{ width: 400, display: "inline-block" }}>
              <CustomFormGroup
                title={"Từ khóa"}
                value={keyword}
                setValue={setKeyword}
                styleForm={{ margin: "10px 0" }}
                styleLabel={{ marginRight: "10px", width: 150 }}
              ></CustomFormGroup>
            </div>
            <div style={{ width: 300, display: "inline-block" }}>
              <label for="search">Tìm kiếm theo:</label>
              <select
                value={typeSearch}
                onChange={(event) => setTypeSearch(event.target.value)}
              >
                <option value="nameUser">Tên người dùng</option>
                <option value="emailUser">Email</option>
                <option value="mssvUser">Mã số sinh viên</option>
                {/* <option value="sdtUser">Số điện thoại</option> */}
                <option value="lopUser">Lớp sinh viên</option>
                {/* <option value="company_name">Vai trò</option> */}
              </select>
            </div>

            <button
              style={{ marginRight: "30px" }}
              onClick={(event) => handleSearch()}
            >
              Tìm kiếm
            </button>
            <button
              style={{ marginRight: "30px" }}
              onClick={(event) => handleCancel()}
            >
              Hủy tìm kiếm
            </button>
            {/* <button>Danh sách nhân viên được cấp quyền</button> */}
            <button
              onClick={(event) => navigate("/AddUserPage")}
              className="add-user"
            >
              Thêm tài khoản
            </button>
          </div>
          <div style={{ display: "flex", justifyContent: "center" }}>
            <table
              className="usermanagement"
              style={{ display: "block", textAlign: "center" }}
            >
              <thead>
                <tr>
                  <th>Id</th>
                  <th>Họ Tên</th>
                  <th>Mã số sinh viên</th>
                  <th>Lớp</th>
                  <th>Email</th>
                  <th>SĐT</th>
                  <th>Địa chỉ</th>
                  <th>Ngày cập nhập</th>
                  <th>Trạng thái</th>
                  <th>Vai trò</th>
                  <th>Thao tác</th>
                </tr>
              </thead>
              <tbody>
                {users.map((user) => (
                  <tr key={user.id}>
                    <td>{user.id}</td>
                    <td>{user.nameUser}</td>
                    <td>{user.mssvUser}</td>
                    <td>{user.lopUser}</td>
                    <td>{user.emailUser}</td>
                    <td>{user.sdtUser}</td>
                    <td>{user.diachiUser}</td>
                    <td>
                      {moment(user.dateUser).format("DD MMM YYYY HH:MM:SS")}
                    </td>
                    <td style={{ textAlign: "center" }}>
                      {" "}
                      {user.status === 1 ? (
                        <FiUserCheck
                          size={30}
                          onMouseOver={(event) => {
                            event.currentTarget.style.color =
                              "rgba(50,150,100,0.7)";
                            event.currentTarget.style.cursor = "pointer";
                          }}
                          onMouseLeave={(event) => {
                            event.currentTarget.style.color = "black";
                          }}
                          onClick={(event) => changeStatus(user.id)}
                        >
                          Khóa tài khoản
                        </FiUserCheck>
                      ) : (
                        <FiUserX
                          size={30}
                          onMouseOver={(event) => {
                            event.currentTarget.style.color =
                              "rgba(50,150,100,0.7)";
                            event.currentTarget.style.cursor = "pointer";
                          }}
                          onMouseLeave={(event) => {
                            event.currentTarget.style.color = "black";
                          }}
                          onClick={(event) => changeStatus(user.id)}
                        >
                          Mở tài khoản
                        </FiUserX>
                      )}
                    </td>
                    <td>
                      {["Admin", "Nhân viên", "Người dùng"][user.rule - 1]}
                    </td>
                    <td>
                      <Link to={"/UpdateUserPage/" + user.id}>
                        <button>Chỉnh sửa</button>
                      </Link>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </>
    )
  );
};

export default UserManagement;
