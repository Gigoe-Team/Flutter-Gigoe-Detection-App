import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/error/exceptions.dart';
import '../models/caries_model.dart';

abstract class PredictRemoteDataSource {
  Future<CariesModel> frontImageClassification(String imageFront);
  Future<CariesModel> rightImageClassification(String imageRight);
  Future<CariesModel> leftImageClassification(String imageLeft);
  Future<CariesModel> upperImageClassification(String imageUpper);
  Future<CariesModel> lowerImageClassification(String imageLower);
  Future<Uint8List> imageFrontResponse(String imgFrontRes);
  Future<Uint8List> imageRightResponse(String imgRightRes);
  Future<Uint8List> imageLeftResponse(String imgLeftRes);
  Future<Uint8List> imageUpperResponse(String imgUpperRes);
  Future<Uint8List> imageLowerResponse(String imgLowerRes);
}

const baseApi = 'https://detect.roboflow.com/caries-k4k7c/4';
const apiKeys = 'o9jAVJnztawPlAP7eD7x';
const jsonFormat = 'json';
const imageFormat = 'image&labels=on&stroke=10';
const apiURL = '$baseApi?api_key=$apiKeys&confidence=40&overlap=30&format=';

class PredictRemoteDataSourceImpl implements PredictRemoteDataSource {
  final Dio dio;

  PredictRemoteDataSourceImpl(this.dio);

  @override
  Future<CariesModel> frontImageClassification(String imageFront) {
    return _imageClassification(imageFront);
  }

  @override
  Future<CariesModel> leftImageClassification(String imageLeft) {
    return _imageClassification(imageLeft);
  }

  @override
  Future<CariesModel> rightImageClassification(String imageRight) {
    return _imageClassification(imageRight);
  }

  @override
  Future<CariesModel> upperImageClassification(String imageUpper) {
    return _imageClassification(imageUpper);
  }

  @override
  Future<CariesModel> lowerImageClassification(String imageLower) {
    return _imageClassification(imageLower);
  }

  Future<CariesModel> _imageClassification(String imagePath) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imagePath),
    });

    final Response response = await dio.post(
      "$apiURL$jsonFormat",
      data: formData,
      options: Options(contentType: "multipart/form-data"),
    );

    if (response.statusCode == 200) {
      return CariesModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Uint8List> imageFrontResponse(String imgFrontRes) {
    return _imageResponse(imgFrontRes);
  }

  @override
  Future<Uint8List> imageLeftResponse(String imgLeftRes) {
    return _imageResponse(imgLeftRes);
  }

  @override
  Future<Uint8List> imageLowerResponse(String imgLowerRes) {
    return _imageResponse(imgLowerRes);
  }

  @override
  Future<Uint8List> imageRightResponse(String imgRightRes) {
    return _imageResponse(imgRightRes);
  }

  @override
  Future<Uint8List> imageUpperResponse(String imgUpperRes) {
    return _imageResponse(imgUpperRes);
  }

  Future<Uint8List> _imageResponse(String imgPath) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imgPath),
    });

    final Response response = await dio.post(
      "$apiURL$imageFormat",
      data: formData,
      options: Options(
        contentType: "multipart/form-data",
        responseType: ResponseType.bytes,
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ServerException();
    }
  }
}
