/* eslint-disable no-unused-vars */
import axios from "axios";
const urlAPI = "http://172.16.2.184:8080/";
///////////////////////////////User//////////////////////////////////
const urlGetAllUser = `${urlAPI}getAllUser`;
const urlGetOneUser = `${urlAPI}getOneUser/`;
const urlDeleteUser = `${urlAPI}deleteUser/`;
const urlPostNewUser = `${urlAPI}postNewUser`;
const urlPutUser = `${urlAPI}putUser`;
///////////////////////////////Comment//////////////////////////////////
const urlGetAllComment = `${urlAPI}getAllComment?postId=`;
const urlPostNewComment = `${urlAPI}postNewComment`;
const urlDeleteComment = `${urlAPI}deleteComment/`;
const urlPutComment = `${urlAPI}putComment`;

////////////////////////////////Post///////////////////////////////////
const urlGetAllPost = `${urlAPI}getAllPost`;
const urlGetAllPostLienQuan = `${urlAPI}getPostLienQuan?`;
const urlGetFavoriteAllPost = `${urlAPI}getRecordInHiddenPostWithStatus?`;
const urlGetAllPostWithTrangThai = `${urlAPI}getPostWithStatus?`;
const urlGetAllPostWithMDHuHong = `${urlAPI}getPostWithMDHuHong?`;
const urlGetAllPostWithMDCanThiet = `${urlAPI}getPostWithMDCanThiet?`;
const urlGetAllPostsSearchBar = `${urlAPI}getPostSearchBar?`;
const urlGetAllPostOfSelected = `${urlAPI}getAllPostOFSelected`;
const urlDeletePost = `${urlAPI}deletePost/`;
const urlPostNewHiddenPost = `${urlAPI}postNewHiddenPost`;
const urlPutPost = `${urlAPI}putPost`;
const urlPutPostStatus = `${urlAPI}putPostStatus`;
const urlPostNewPost = `${urlAPI}postNewPost`;
const urlDeleteHiddenPost = `${urlAPI}deleteHiddenPost`;
const urlGetAllPictureWithIdPost = `${urlAPI}getAllPicture`;
///////////////////////////AUTH/////////////////////////////
const urlLogin = `${urlAPI}login`;
const urlRegister = `${urlAPI}register`;
const Api = {
  ///////////// User/////////////////////////////

  fetchAllUsers: async () => {
    const response = await axios.get(urlGetAllUser);
    if (response.status === 200) {
      return response.data;
    } else {
      console.log("can not get Users");
    }
  },

  fetchOneUser: async (idUser) => {
    const response = await axios.get(urlGetOneUser + idUser);
    if (response.status === 200) {
      return response.data;
    } else {
      console.log("can not get Users");
    }
  },

  deleteUser: async (idUser) => {
    const response = await axios.delete(urlDeleteUser + idUser);
    if (response.status === 200) {
      console.log("Xóa dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Xóa dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },

  postUser: async (newUser) => {
    const response = await axios.post(urlPostNewUser, {
      id: 0,
      mssvUser: newUser.mssvUser,
      nameUser: newUser.nameUser,
      emailUser: newUser.emailUser,
      lopUser: newUser.lopUser,
      passwordUser: newUser.passwordUser,
      status: newUser.status,
      rule: newUser.status,
    });
    if (response.status === 200) {
      console.log("Them dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Them dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },

  putUser: async (editUser, file = null) => {
    const formData = new FormData();
    if (file !== null) formData.append("avatar", file);
    formData.append("user", JSON.stringify(editUser));
    const response = await axios.put(urlPutUser, formData, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    });
    if (response.status === 200) {
      console.log("Cập nhật dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Cập nhật dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
    // return json.decode(User.fromMap(response.body));
  },
  putUserByAdmin: async (editUser) => {
    const response = await axios.put(urlPutUser, editUser);
    if (response.status === 200) {
      console.log("Cập nhật dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Cập nhật dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
    // return json.decode(User.fromMap(response.body));
  },
  ////////////////////Comment////////////////////////

  fetchAllComment: async (idPost) => {
    const response = await axios.get(`urlGetAllComment${idPost}`);
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Comments");
    }
  },

  postNewComment: async (cmt) => {
    // List<Comment> listData = [];
    const response = await axios.post(urlPostNewComment, cmt);

    if (response.status === 200) {
      console.log("Them dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Them dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },

  deleteComment: async (idComment) => {
    const response = await axios.delete(urlDeleteComment + idComment);
    if (response.status === 200) {
      console.log("Xóa dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Xóa dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },

  putComment: async (idPostCmt, idUserCmt, dateCmt, contentCmt) => {
    // List<Comment> listData = [];
    const response = await axios.put(urlPostNewComment, {
      idCmt: 0,
      idPostCmt: idPostCmt,
      idUserCmt: idUserCmt,
      dateCmt: dateCmt,
      contentCmt: contentCmt,
    });
    if (response.status === 200) {
      console.log("Cập nhật dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Cập nhật dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },

  ///////////////////Post//////////////////////
  fetchAllPosts: async () => {
    const response = await axios.get(urlGetAllPost);
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Posts");
    }
  },

  fetchAllFavoritePost: async (idUser, status) => {
    const response = await axios.get(
      `${urlGetFavoriteAllPost}idUser= ${idUser}&status=${status}`
    );
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Posts");
    }
  },

  fetchPostLienQuan: async (idCurrent, thietbi, diachi) => {
    const response = await axios.get(
      `${urlGetAllPostLienQuan}idCurrent=${idCurrent}&thietBi=${thietbi}&diachi=${diachi}`
    );
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Posts");
    }
  },

  fetchAllPostWithTrangThai: async (trangthai) => {
    const response = await axios.get(
      `${urlGetAllPostWithTrangThai}status=${trangthai}`
    );
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Posts");
    }
  },

  fetchAllPostWithMdHuHong: async (mucdo) => {
    const response = await axios.get(
      `${urlGetAllPostWithMDHuHong}mucdo=${mucdo}`
    );
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Posts");
    }
  },

  fetchAllPostWithMDCanThiet: async (mucdo) => {
    const response = await axios.get(
      `${urlGetAllPostWithMDCanThiet}mucdo=${mucdo}`
    );
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Posts");
    }
  },

  fetchAllPostSearchBar: async (keyword) => {
    const response = await axios.get(
      `${urlGetAllPostsSearchBar}keyword=${keyword}`
    );
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Posts");
    }
  },

  fetchAllPostOfSelected: async (idUser) => {
    const response = await axios.get(
      `${urlGetAllPostOfSelected}?idUser=${idUser}`
    );
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Posts");
    }
  },

  deletePost: async (idPost) => {
    const response = await axios.delete(urlDeleteComment + idPost);
    if (response.status === 200) {
      console.log("Xóa dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Xóa dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },

  postNewHiddenPost: async (idUser, idPost, status) => {
    const response = await axios.post(urlPostNewHiddenPost, {
      idUser: idUser,
      idPost: idPost,
      status: status,
    });
    if (response.status === 200) {
      console.log("Cập nhật dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Cập nhật dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },

  deleteHiddenPost: async (idUser, idPost) => {
    const response = await axios.delete(
      `${urlDeleteHiddenPost}?idUser=${idUser}&idPost=${idPost}`
    );
    if (response.status === 200) {
      console.log("Cập nhật dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Cập nhật dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },

  postNewPost: async (newPost, files) => {
    const formData = new FormData();
    formData.append("pictures", files);
    formData.append("post", JSON.stringify(newPost));
    const headers = { "Content-Type": "multipart/form-data" };
    const response = await axios.post(urlPostNewPost, formData, {
      headers: headers,
    });

    if (response.status === 200) {
      console.log("Cập nhật dữ liệu thành công!");
      return response.data;
    } else {
      console.log(`Cập nhật dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },

  putPost: async (editPost, files) => {
    const formData = new FormData();
    formData.append("pictures", files);
    formData.append("post", JSON.stringify(editPost));
    const headers = { "Content-Type": "multipart/form-data" };
    const response = await axios.post(urlPutPost, formData, {
      headers: headers,
    });
    if (response.status === 200) {
      console.log("Cập nhật dữ liệu thành công!");
    } else {
      console.log(`Cập nhật dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },
  putPostStatus: async (idPost, trangThai, thoiHan, ghiChu) => {
    const response = await axios.put(urlPutPostStatus, {
      idPost: idPost,
      trangThai: trangThai,
      thoiHan: thoiHan,
      ghiChu: ghiChu,
    });
    if (response.status === 200) {
      console.log("Cập nhật dữ liệu thành công!");
    } else {
      console.log(`Cập nhật dữ liệu thất bại. Mã lỗi: ${response.status}`);
    }
  },
  fetchAllPictureWithIdPost: async (idPost) => {
    const response = await axios.get(
      `${urlGetAllPictureWithIdPost}?idPost=${idPost}`
    );
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Pictures");
    }
  },
  login: async (auth) => {
    const response = await axios.post(urlLogin, auth);
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Pictures");
    }
  },
  register: async (user) => {
    const response = await axios.post(urlRegister, user);
    if (response.status === 200) {
      return response.data;
    } else if (response.status === 404) {
      console.log("Not Found");
    } else {
      console.log("Can not get Pictures");
    }
  },
};
export default Api;
