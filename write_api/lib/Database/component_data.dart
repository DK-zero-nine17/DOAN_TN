class WriteData {
  //Name DataBase
  static const String DB_NAME = 'TestDK_backend.db';
  static const int DB_VERSION = 1;

  //Table Comment
  static const String TBL_NAME_CMT = 'Comment';
  static const String COL_ID_CMT = 'id';
  static const String COL_ID_POST_CMT = 'idPost';
  static const String COL_ID_USER_CMT = 'idUser';
  static const String COL_DATE_CMT = 'dateComment';
  static const String COl_CONTENT_CMT = 'noidungComment';
  static const String COl_ISLIKE_CMT = 'isLike';
  static const String COL_SOLUONGLIKE_CMT = 'soluongLike';
  static const String COL_PICTURES_CMT = 'pictures';
  static const String COL_VIDEOS_CMT = 'videos';

  //Table Post
  static const String TBL_NAME_POST = 'Post';
  static const String COL_ID_POST = 'id';
  static const String COl_ID_USER_POST = 'idUser';
  static const String COL_TITLE_POST = 'tieudePost';
  static const String COl_NAME_SEND_POST = 'nguoiguiPost';
  static const String COL_DATE_POST = 'datePost';
  static const String COL_PICTURES_POST = 'picturesPost';
  static const String COL_VIDEOS_POST = 'videosPost';
  static const String COL_ISLIKE_POST = 'isLike';
  static const String COL_SOLUONGLIKE_POST = 'soluongLike';
  static const String COL_TRANGTHAI_POST = 'trangThai';
  static const String COL_MDHUHONG_POST = 'mdHuHong';
  static const String COL_MDCANTHIET_POST = 'mdCanThiet';
  static const String COL_THIETBI_POST = 'thietBi';
  static const String COL_DIACHI_POST = 'diachi';
  static const String COL_SOLUONGCOMMENTS_POST = 'soluongComments';
  static const String COL_CONTENT_POST = 'noidungPost';

  // Table User
  static const String TBL_NAME_USER = 'TheUser';
  static const String COL_ID_USER = 'id';
  static const String COL_ID_ACCOUNT_USER = 'idAccountUser';
  static const String COL_PASSWORD_USER = 'passwordUser';
  static const String COL_MSSV_USER = 'mssvUser';
  static const String COL_NAME_USER = 'nameUser';
  static const String COL_EMAIL_USER = 'emailUser';
  static const String COL_LOP_USER = 'lopUser';
  static const String COL_SDT_USER = 'sdtUser';
  static const String COL_DATE_USER = 'dateUser';
  static const String COL_DIACHI_USER = 'diachiUser';
  static const String COL_AVATAR_USER = 'avatarUser';
  static const String COL_ID_HIDE_POST_OF_USER = 'listHideOfUser';
}
