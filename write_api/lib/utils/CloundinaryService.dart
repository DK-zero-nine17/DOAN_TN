import 'dart:typed_data';
import 'package:cloudinary/cloudinary.dart';
import 'package:write_api/Model/picture.dart';

final cloudinary = Cloudinary.signedConfig(
    apiKey: '766723684743618',
    apiSecret: 'DVYCwVJQ-n1LHXavp2g00s3pXPw',
    cloudName: 'dkjd3g6t3');

Future<Picture> uploadFileCloudinary(
    Uint8List fileBytes, String filename, int idPost) async {
  final response = await cloudinary.upload(
    fileBytes: fileBytes,
    file: filename,
    publicId: filename,
    folder: '/DACN/$idPost',
  );
  if (response.isSuccessful) {
    return Picture(
        id: filename,
        url: response.secureUrl ?? "",
        contentType: response.type ?? "image/png",
        idPost: idPost);
  } else {
    final error = response.error;
    throw Exception('Error! Failed: $error');
  }
}

Future<String?> uploadAvatarCloudinary(
    Uint8List fileBytes, String filename) async {
  final response = await cloudinary.upload(
    fileBytes: fileBytes,
    file: filename,
    publicId: filename,
    folder: '/DACN/USER',
  );
  if (response.isSuccessful) {
    return response.secureUrl;
  } else {
    final error = response.error;
    throw Exception('Error! Failed: $error');
  }
}

Future<Picture?> updateFileCloudinary(
    String publicId, Uint8List fileBytes, String filename, int idPost) async {
  await cloudinary.destroy(publicId);
  return await uploadFileCloudinary(fileBytes, filename, idPost);
}

Future<void> deleteFileCloudinary(String publicId) async {
  final response = await cloudinary.destroy(publicId);

  if (!response.isSuccessful) {
    final error = response.error;
    throw Exception('Delete failed: $error');
  }
}

Future<void> deleteFolderCloudinary(int publicId) async {
  final response = await cloudinary.destroy('$publicId');

  // if (!response.isSuccessful) {
  //   final error = response.error;
  //   throw Exception('Delete failed: $error');
  // }
}
