import 'dart:io';

import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/board/post/general_post/model/general_comment_list_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_wirte_model.dart';
import 'package:dio/dio.dart';

class GeneralPostProvider {
  final Dio _dio;

  static final GeneralPostProvider _singleton =
      GeneralPostProvider._internal(DioInterceptor().dio);

  GeneralPostProvider._internal(this._dio);

  factory GeneralPostProvider() => _singleton;

  Future<ApiResponseDTO> writeGeneralPost(
      String token, GeneralPostWriteModel generalPostWriteModel) async {
    String url = '/post/general-forum';

    final data = FormData.fromMap({
      'title': generalPostWriteModel.title,
      'body': generalPostWriteModel.body,
      'files': generalPostWriteModel.files
          .map((e) => MultipartFile.fromFileSync(e.url))
          .toList(),
    });
    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
          headers: headers,
        ),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> deleteGeneralPost(String token, int postId) async {
    String url = '/post/general-forum/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response =
          await _dio.delete(url, options: Options(headers: headers));

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> getGeneralPost(String token, int postId) async {
    String url = '/post/general-forum/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      return SuccessResponseDTO(data: GeneralPostModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> getGeneralComment(
      String token, int commentId, int page, int size) async {
    String url =
        '/post/general-forum/comment/$commentId?page=$page&size=$size&sort=createdAt,desc';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      return SuccessResponseDTO(
          data: GeneralCommentListModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> writeGeneralComment(
      String token, int commentId, String text) async {
    String url = '/post/general-forum/comment/$commentId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    final data = {
      'text': text,
    };

    try {
      final Response response = await _dio.post(url,
          options: Options(
            headers: headers,
          ),
          data: data);

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> deleteGeneralComment(
      String token, int commentId) async {
    String url = '/post/general-forum/comment/$commentId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
        ),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> likePost(String token, int postId) async {
    String url = '/post/general-forum/like/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.post(url,
          options: Options(
            headers: headers,
          ));

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> unlikePost(String token, int postId) async {
    String url = '/post/general-forum/like/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.delete(url,
          options: Options(
            headers: headers,
          ));

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }
}
