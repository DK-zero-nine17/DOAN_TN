import React, { useEffect, useState } from "react";
import HeaderPage from "./components/HeaderPage";
import "./css/AddUserPage.css";
import { useNavigate, useParams } from "react-router-dom";
import Api from "./api/Api";
import CustomFormGroup from "./components/CustomFormGroup";
import { Form } from "react-bootstrap";
const AddUserPage = () => {
  const id = useParams().id;
  const navigate = useNavigate();
  const isLogin = localStorage.getItem("user");
  if (!isLogin) navigate("/");
  if (Number.isNaN()) navigate("/UserManagement");
  const typePage = id ? true : false;
  const [user, setUser] = useState({
    id: 0,
    mssvUser: "",
    nameUser: "",
    emailUser: "",
    lopUser: "",
    sdtUser: "",
    diachiUser: "",
    passwordUser: "",
    status: 1,
    rule: 3,
  });
  useEffect(() => {
    if (typePage && isLogin)
      Api.fetchOneUser(id).then((data) => {
        console.log(data[0]);
        const userCr = data[0];
        userCr.passwordUser = "";
        setUser(userCr);
      });
  }, [id]);
  const set = (prop, value) => {
    setUser({ ...user, [prop]: value });
  };
  const handleSubmit = (event) => {
    event.preventDefault();
    if (isLogin)
      if (
        user.nameUser !== "" &&
        user.mssvUser !== "" &&
        user.emailUser !== "" &&
        user.sdtUser !== "" &&
        user.passwordUser !== ""
      )
        (typePage ? Api.putUser(user) : Api.postUser(user)).then((data) => {
          console.log(data);
          alert("Cập nhập thông tin thành công.");
          navigate("/UserManagement");
        });
      else
        alert(
          "Thông tin không được bỏ trống, vui lòng điền vào những trường quan trọng."
        );
  };

  return (
    isLogin && (
      <>
        <HeaderPage />
        <div className="add-user-page">
          <form onSubmit={handleSubmit}>
            <h2>{id === null ? "Thêm" : "Chỉnh sửa"} Tài khoản</h2>
            <CustomFormGroup
              title={"Họ Tên"}
              value={user.nameUser}
              setValue={(nameUser) => set("nameUser", nameUser)}
              styleLabel={{ width: "220px" }}
            ></CustomFormGroup>
            <CustomFormGroup
              title={"Mã số sinh viên"}
              value={user.mssvUser}
              setValue={(mssvUser) => set("mssvUser", mssvUser)}
              styleLabel={{ width: "220px" }}
            ></CustomFormGroup>
            <CustomFormGroup
              title={"Email"}
              value={user.emailUser}
              setValue={(emailUser) => set("emailUser", emailUser)}
              styleLabel={{ width: "220px" }}
            ></CustomFormGroup>
            <CustomFormGroup
              title={"Số điện thoại"}
              value={user.sdtUser}
              setValue={(sdtUser) => set("sdtUser", sdtUser)}
              styleLabel={{ width: "220px" }}
            ></CustomFormGroup>
            <CustomFormGroup
              title={"Lớp"}
              value={user.lopUser}
              setValue={(lopUser) => set("lopUser", lopUser)}
              styleLabel={{ width: "220px" }}
            ></CustomFormGroup>
            <CustomFormGroup
              title={"Địa chỉ"}
              value={user.diachiUser}
              setValue={(diachiUser) => set("diachiUser", diachiUser)}
              styleLabel={{ width: "220px" }}
            ></CustomFormGroup>
            <CustomFormGroup
              title={"Mật khẩu"}
              value={user.passwordUser}
              setValue={(passwordUser) => set("passwordUser", passwordUser)}
              styleLabel={{ width: "220px" }}
            ></CustomFormGroup>
            <Form.Group
              style={{
                display: "flex",
                textAlign: "left",
                alignItems: "center",
                margin: "10px  0",
              }}
            >
              <Form.Label
                style={{
                  textAlign: "left",
                  display: "inline-block",
                  marginRight: "10px",
                  width: "200px",
                }}
              >
                Quyền:
              </Form.Label>
              <Form.Control
                as="select"
                value={user.rule}
                onChange={(event) => {
                  set("rule", event.target.value);
                }}
                style={{
                  height: "35px",
                  width: "100%",
                  display: "inline-block",
                  margin: 0,
                  borderRadius: "3px",
                  fontWeight: "bold",
                }}
              >
                {[3, 2, 1].map((value) => (
                  <option
                    key={value}
                    value={value}
                    style={{
                      color: "black",
                    }}
                    defaultValue={value === 3}
                  >
                    {value === 1
                      ? "Admin"
                      : value === 2
                      ? "Nhân Viên"
                      : "Người dùng"}
                  </option>
                ))}
              </Form.Control>
            </Form.Group>
            <button type="submit">
              {id == null ? "Thêm" : "Sửa"} tài khoản
            </button>
          </form>
        </div>
      </>
    )
  );
};

export default AddUserPage;
