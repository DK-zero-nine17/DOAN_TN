import React, { useEffect, useState } from "react";
import HeaderPage from "./components/HeaderPage";
import "./css/PostManagement.css";
import Api from "./api/Api";
import { IoIosArrowForward } from "react-icons/io";
import { Form } from "react-bootstrap";
import CustomFormGroup from "./components/CustomFormGroup";
import moment from "moment/moment";
import { useNavigate } from "react-router-dom";

const PostManagement = () => {
  const [posts, setPosts] = useState([]);
  const [current, setCurrent] = useState([]);
  const [selectedPost, setSelectedPost] = useState({ id: 0 });
  const [deadline, setDeadline] = useState(
    moment().format("yyyy-MM-ddThh:mm:ss")
  );
  const [note, setNote] = useState("");
  const [keyword, setKeyword] = useState("");
  const [status, setStatus] = useState("Tất cả");
  const [mdHuHong, setMdHuHong] = useState("Tất cả");
  const [mdCanThiet, setMdCanThiet] = useState("Tất cả");
  const navigate = useNavigate();
  const isLogin = localStorage.getItem("user");
  useEffect(() => {
    if (!isLogin) navigate("/");
    if (isLogin)
      Api.fetchAllPosts().then((data) => {
        setPosts(data);
        setCurrent(data);
      });
  }, [window.location.href]);
  useEffect(() => {
    if (selectedPost.thoiHan !== null)
      setDeadline(
        moment(selectedPost.thoiHan, "YYYY-MM-DD HH:mm:ss").format(
          "YYYY-MM-DDTHH:mm"
        )
      );
    if (selectedPost.ghiChu !== null) setNote(selectedPost.ghiChu);
    console.log(selectedPost);
  }, [selectedPost, selectedPost.id]);
  // useEffect(() => {
  //   setStatus("Tất cả");
  //   setMdHuHong("Tất cả");
  //   setMdCanThiet("Tất cả");
  //   setPosts(
  //     current.filter((p) =>
  //       keyword === "" ? true : p.tieudePost.includes(keyword)
  //     )
  //   );
  // }, [keyword]);
  // useEffect(() => {
  //   setKeyword("");
  //   setMdHuHong("Tất cả");
  //   setMdCanThiet("Tất cả");
  //   setPosts(
  //     current.filter((p) =>
  //       status === "Tất cả" ? true : p.trangThai === status
  //     )
  //   );
  // }, [status]);
  // useEffect(() => {
  //   setKeyword("");
  //   setStatus("Tất cả");
  //   setMdCanThiet("Tất cả");
  //   setPosts(
  //     current.filter((p) =>
  //       mdHuHong === "Tất cả" ? true : p.mdHuHong === mdHuHong
  //     )
  //   );
  // }, [mdHuHong]);
  // useEffect(() => {
  //   setKeyword("");
  //   setStatus("Tất cả");
  //   setMdHuHong("Tất cả");
  //   setPosts(
  //     current.filter((p) =>
  //       mdCanThiet === "Tất cả" ? true : p.mdCanThiet === mdCanThiet
  //     )
  //   );
  // }, [mdCanThiet]);
  const handlePostStatus = async (status) => {
    selectedPost.trangThai = status;
    console.log(deadline);
    if (deadline.toString() === "Invalid date")
      alert("Vui lòng nhập thơi hạn để tiếp tục. Không được để trống.");
    else if (isLogin) {
      await Api.putPostStatus(
        selectedPost.id,
        status,
        moment(deadline).format("YYYY-MM-DD HH:mm:ss").toString(),
        note
      );
      setPosts(
        posts.map((p) =>
          p.id === selectedPost.id
            ? {
                ...selectedPost,
                thoiHan: moment(deadline)
                  .format("YYYY-MM-DD HH:mm:ss")
                  .toString(),
                ghiChu: note,
                trangThai: status,
              }
            : p
        )
      );
    }
  };
  const handlePostClick = (post) => {
    if (post.id !== selectedPost.id) {
      setDeadline("");
      setNote("");
      setSelectedPost(post);
    }
  };

  return (
    isLogin && (
      <>
        <HeaderPage />
        <div className="form-post" style={{ display: "flex" }}>
          <div
            className="post-management"
            style={{
              width: "40%",
              overflowY: "auto",
              maxHeight: "calc(100vh - 180px)",
            }}
          >
            <div
              style={{
                display: "flex",
                flexDirection: "column",
                alignItems: "center",
                width: "100%",
              }}
            >
              <form style={{ width: "95%", padding: "0 15px" }}>
                <Form.Group
                  controlId="timkiem"
                  style={{
                    display: "flex",
                    // justifyContent: "space-evenly",
                    textAlign: "left",
                    alignItems: "center",
                    margin: "10px 0px",
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
                    Tìm kiếm
                  </Form.Label>
                  <Form.Control
                    style={{
                      display: "inline-block",
                      height: "35px",
                      width: "100%",
                      borderRadius: "4px",
                      padding: "5px",
                      minWidth: "150px",
                      backgroundColor: "rgba(255,255,255,0.9)",
                    }}
                    type={"text"}
                    value={keyword}
                    onChange={(event) => {
                      setKeyword(event.target.value);
                      setStatus("Tất cả");
                      setMdHuHong("Tất cả");
                      setMdCanThiet("Tất cả");
                      setPosts(
                        current.filter((p) =>
                          event.target.value === ""
                            ? true
                            : p.tieudePost
                                .toLowerCase()
                                .includes(event.target.value.toLowerCase())
                        )
                      );
                    }}
                    placeholder={`Vui lòng nhập từ khóa`}
                  />
                </Form.Group>
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
                    Trạng thái:
                  </Form.Label>
                  <Form.Control
                    as="select"
                    value={status}
                    onChange={(event) => {
                      setStatus(event.target.value);
                      setKeyword("");
                      setMdHuHong("Tất cả");
                      setMdCanThiet("Tất cả");
                      setPosts(
                        current.filter((p) =>
                          event.target.value === "Tất cả"
                            ? true
                            : p.trangThai === event.target.value
                        )
                      );
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
                    {[
                      "Tất cả",
                      "Chưa duyệt",
                      "Đã duyệt",
                      "Từ chối",
                      "Hoàn thành",
                    ].map((value) => (
                      <option
                        key={value}
                        value={value}
                        style={{
                          color: "black",
                        }}
                      >
                        {value}
                      </option>
                    ))}
                  </Form.Control>
                </Form.Group>
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
                    Mức độ hư hỏng:
                  </Form.Label>
                  <Form.Control
                    as="select"
                    value={mdHuHong}
                    onChange={(event) => {
                      setMdHuHong(event.target.value);
                      setKeyword("");
                      setStatus("Tất cả");
                      setMdCanThiet("Tất cả");
                      setPosts(
                        current.filter((p) =>
                          event.target.value === "Tất cả"
                            ? true
                            : p.mdHuHong === event.target.value
                        )
                      );
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
                    {["Tất cả", "Nhẹ", "Trung bình", "Nặng"].map((value) => (
                      <option
                        key={value}
                        value={value}
                        style={{
                          color: "black",
                          // fontWeight: 'bold',
                        }}
                      >
                        {value}
                      </option>
                    ))}
                  </Form.Control>
                </Form.Group>
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
                    Mức độ cần thiết:
                  </Form.Label>
                  <Form.Control
                    as="select"
                    value={mdCanThiet}
                    onChange={(event) => {
                      setMdCanThiet(event.target.value);
                      setKeyword("");
                      setStatus("Tất cả");
                      setMdHuHong("Tất cả");
                      setPosts(
                        current.filter((p) =>
                          event.target.value === "Tất cả"
                            ? true
                            : p.mdCanThiet === event.target.value
                        )
                      );
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
                    {["Tất cả", "Thấp", "Bình thường", "Cao"].map((value) => (
                      <option
                        key={value}
                        value={value}
                        style={{
                          color: "black",
                          // fontWeight: 'bold',
                        }}
                      >
                        {value}
                      </option>
                    ))}
                  </Form.Control>
                </Form.Group>
              </form>
              {posts.map((post) => (
                <div
                  key={post.id}
                  className="post"
                  onClick={(event) => handlePostClick(post)}
                  onMouseOver={(event) => {
                    event.currentTarget.style.backgroundColor = "#87d3c54d";
                    event.currentTarget.style.cursor = "pointer";
                  }}
                  onMouseLeave={(event) =>
                    (event.currentTarget.style.backgroundColor =
                      selectedPost.id === post.id ? "#87d3c54d" : "white")
                  }
                  style={{
                    width: "90%",
                    // minWidth: "500px",
                    // maxWidth: "550px",
                    height: "120px",
                    margin: "10px",
                    border: "1px solid rgb(136, 136, 136,0.7)",
                    borderRadius: "7px",
                    padding: "15px",
                    boxShadow: "5px 10px rgb(136, 136, 136,0.3)",
                    display: "flex",
                    flexWrap: "nowrap",
                    justifyContent: "space-between",
                    backgroundColor:
                      selectedPost.id === post.id ? "#87d3c54d" : "white",
                  }}
                >
                  <div
                    style={{
                      display: "flex",
                      flexWrap: "nowrap",
                      justifyContent: "space-between",
                    }}
                  >
                    <img
                      src={
                        post.avatar == null
                          ? "https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687353508/DACN/Assets/avt-df_ztd19q.jpg"
                          : post.avatar
                      }
                      style={{
                        height: "60px",
                        width: "60px",
                      }}
                      alt="Avatar"
                      className="avatar"
                    />
                    <div className="post-content">
                      <h3
                        className="post-title"
                        onClick={() => handlePostClick(post.id)}
                      >
                        {post.title}
                      </h3>
                      <h2 style={{ fontSize: "20px" }} className="post-detail">
                        {post.nguoiguiPost}
                      </h2>
                      <p style={{ fontSize: "16px" }} className="post-detail">
                        {post.tieudePost}
                      </p>
                    </div>
                  </div>
                  <div>
                    <IoIosArrowForward
                      size={25}
                      color={"rgb(136, 136, 136,0.9)"}
                    ></IoIosArrowForward>
                  </div>
                </div>
              ))}
            </div>
          </div>
          <div
            className="detail-post"
            style={{
              width: "60%",
              padding: "20px",
              margin: "0 auto",
              overflowY: "auto",
              height: "100vh",
              maxHeight: "calc(100vh - 180px)",
            }}
          >
            {selectedPost.id !== 0 ? (
              <>
                <div
                  style={{
                    width: "90%",
                    padding: "10px",
                    border: "1px solid rgb(136, 136, 136,0.2)",
                    backgroundColor: "#6f8f894d",
                    borderRadius: "8px",
                    margin: "0 auto",
                  }}
                >
                  <h2 style={{ textAlign: "center" }}>Thông tin bài post</h2>
                  <div style={{ width: "70%", margin: "0 auto" }}>
                    <CustomFormGroup
                      value={selectedPost.tieudePost}
                      title="Tiêu đề"
                      disabled={true}
                    />
                    <CustomFormGroup
                      value={selectedPost.noidungPost}
                      title="Nội dung"
                      disabled={true}
                    />
                    {/* <Form.Group
                    style={{
                      display: "flex",
                      textAlign: "left",
                      alignItems: "center",
                    }}
                  >
                    <Form.Label
                      style={{
                        textAlign: "left",
                        display: "inline-block",
                        marginRight: "30px",
                        width: "200px",
                      }}
                    >
                      Trạng thái:
                    </Form.Label>
                    <Form.Control
                      as="select"
                      value={status}
                      onChange={(event) => setStatus(event.target.value)}
                      style={{
                        height: "35px",
                        width: "100%",
                        display: "inline-block",
                        margin: 0,
                        borderRadius: "3px",
                      }}
                    >
                      {["Chưa duyệt", "Đang duyệt", "Hoàn thành"].map(
                        (value) => (
                          <option
                            key={value}
                            value={value}
                            style={{
                              color: "black",
                              // fontWeight: 'bold',
                            }}
                          >
                            {value}
                          </option>
                        )
                      )}
                    </Form.Control>
                  </Form.Group> */}
                    <CustomFormGroup
                      value={selectedPost.trangThai}
                      title="Trang thái"
                      disabled={true}
                    />
                    <CustomFormGroup
                      value={selectedPost.mdHuHong}
                      title="Mức độ hư hỏng"
                      disabled={true}
                    />
                    <CustomFormGroup
                      value={selectedPost.mdCanThiet}
                      title="Mức độ cần thiết"
                      disabled={true}
                    />
                    <CustomFormGroup
                      value={selectedPost.thietBi}
                      title="Thiết bị"
                      disabled={true}
                    />
                    <CustomFormGroup
                      value={selectedPost.diachi}
                      title="Địa chỉ"
                      disabled={true}
                    />
                    <CustomFormGroup
                      value={selectedPost.nguoiguiPost}
                      title="Người đăng bài"
                      disabled={true}
                    />
                    <CustomFormGroup
                      value={moment(selectedPost.datePost).format(
                        "DD MMM YYYY HH:MM:SS"
                      )}
                      title="Thời gian đăng bài"
                      disabled={true}
                    />
                  </div>
                </div>
                <div
                  style={{
                    width: "90%",
                    padding: "10px",
                    border: "1px solid rgb(136, 136, 136,0.2)",
                    borderRadius: "8px",
                    margin: "20px auto",
                    backgroundColor: "#6f8f894d",
                  }}
                >
                  <h2 style={{ textAlign: "center" }}>Thông tin duyệt</h2>
                  <div style={{ width: "70%", margin: "0 auto" }}>
                    <Form.Group
                      style={{
                        display: "flex",
                        textAlign: "left",
                        alignItems: "center",
                        margin: "20px 0",
                      }}
                    >
                      <Form.Label
                        style={{
                          textAlign: "left",
                          display: "inline-block",
                          marginRight: "30px",
                          width: "200px",
                        }}
                      >
                        Thời hạn:
                      </Form.Label>
                      <input
                        value={deadline}
                        onChange={(event) => {
                          setDeadline(event.target.value);
                          console.log(
                            deadline
                            // .format("YYYY-MM-DD HH:mm:ss")
                          );
                        }}
                        style={{
                          height: "35px",
                          width: "100%",
                          display: "inline-block",
                          margin: 0,
                          borderRadius: "3px",
                          minWidth: "150px",
                        }}
                        type="datetime-local"
                      />
                    </Form.Group>
                    <Form.Group
                      style={{
                        display: "flex",
                        textAlign: "left",
                        alignItems: "center",
                        margin: "20px 0",
                      }}
                    >
                      <Form.Label
                        style={{
                          textAlign: "left",
                          display: "inline-block",
                          marginRight: "30px",
                          width: "200px",
                        }}
                      >
                        Ghi chú:
                      </Form.Label>
                      <textarea
                        style={{
                          height: "35px",
                          width: "100%",
                          minWidth: "100%",
                          maxWidth: "auto",
                          maxHeight: "150px",
                          minHeight: "60px",
                          display: "inline-block",
                          margin: 0,
                          borderRadius: "3px",
                          padding: "10px",
                        }}
                        value={note}
                        onChange={(event) => setNote(event.target.value)}
                      ></textarea>
                    </Form.Group>
                  </div>
                </div>
                <div style={{ display: "flex", justifyContent: "center" }}>
                  {selectedPost.trangThai === "Chưa duyệt" && (
                    <>
                      <button
                        onClick={(event) => {
                          handlePostStatus("Đã duyệt");
                        }}
                        onMouseOver={(event) => {
                          event.currentTarget.style.cursor = "pointer";
                          event.currentTarget.style.backgroundColor =
                            "rgba(11 ,126, 243, 0.5)";
                        }}
                        onMouseLeave={(event) => {
                          event.currentTarget.style.backgroundColor =
                            "rgba(11 ,126, 243, 0.9)";
                        }}
                        style={{
                          width: "100px",
                          height: "35px",
                          fontSize: "17px",
                          fontWeight: "bold",
                          borderRadius: "4px",
                          backgroundColor: "rgba(11 ,126, 243, 0.9)",
                          color: "white",
                          border: "1px solid rgba(255, 255, 255, 0.5)",
                          margin: "0 40px",
                        }}
                      >
                        Duyệt
                      </button>
                      <button
                        onClick={(event) => {
                          handlePostStatus("Từ chối");
                        }}
                        onMouseOver={(event) => {
                          event.currentTarget.style.cursor = "pointer";
                          event.currentTarget.style.backgroundColor =
                            "rgba(11 ,126, 243, 0.5)";
                        }}
                        onMouseLeave={(event) => {
                          event.currentTarget.style.backgroundColor =
                            "rgba(11 ,126, 243, 0.9)";
                        }}
                        style={{
                          width: "100px",
                          height: "35px",
                          fontSize: "17px",
                          fontWeight: "bold",
                          borderRadius: "4px",
                          backgroundColor: "rgba(11 ,126, 243, 0.9)",
                          color: "white",
                          border: "1px solid rgba(255, 255, 255, 0.5)",
                          margin: "0 40px",
                        }}
                      >
                        Từ chối
                      </button>
                    </>
                  )}
                  {selectedPost.trangThai === "Đã duyệt" && (
                    <button
                      onClick={(event) => {
                        handlePostStatus("Hoàn Thành");
                      }}
                      onMouseOver={(event) => {
                        event.currentTarget.style.cursor = "pointer";
                        event.currentTarget.style.backgroundColor =
                          "rgba(11 ,126, 243, 0.5)";
                      }}
                      onMouseLeave={(event) => {
                        event.currentTarget.style.backgroundColor =
                          "rgba(11 ,126, 243, 0.9)";
                      }}
                      style={{
                        width: "100px",
                        height: "35px",
                        fontSize: "17px",
                        fontWeight: "bold",
                        borderRadius: "4px",
                        backgroundColor: "rgba(11 ,126, 243, 0.9)",
                        color: "white",
                        border: "1px solid rgba(255, 255, 255, 0.5)",
                        margin: "0 40px",
                      }}
                    >
                      Hoàn thành
                    </button>
                  )}
                </div>
              </>
            ) : (
              <div>
                <h2 style={{ color: "grey", textAlign: "center" }}>
                  Hiện chưa có bài viết nào được chọn, hãy chọn bài viết để xem
                  thông tin chi tiết.
                </h2>
              </div>
            )}
          </div>
        </div>
      </>
    )
  );
};

export default PostManagement;
