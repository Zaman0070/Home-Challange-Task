import 'package:dio/dio.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_provider/api_exception.dart';
import 'end_points.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

class DioClient {
  static BaseOptions options = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      receiveTimeout: Endpoints.receiveTimeOut,
      connectTimeout: Endpoints.connectionTimeOut,
      contentType: "application/json");

  final Dio _dio = Dio(options);

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryparams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryparams,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );

      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        switch (response.statusCode) {
          case 400:
            throw BadRequestException();
          case 404:
            throw NotFoundException();
          case 500:
            throw InternalServerErrorException();
          default:
            throw UnknownException();
        }
      }

      return response.data;
    } on DioError catch (e) {
      final responseData = e.response?.data;
      if (responseData != null) {
        throw Exception();
      } else {
        throw UnknownException();
      }
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryparams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onRecieneProgress,
  }) async {
    try {
      final Response response = await _dio.post(uri,
          data: data,
          queryParameters: queryparams,
          options: options,
          onReceiveProgress: onRecieneProgress,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken);

      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        switch (response.statusCode) {
          case 400:
            throw BadRequestException();
          case 404:
            throw NotFoundException();
          case 500:
            throw InternalServerErrorException();
          case 401:
            throw NotFoundException();
          default:
            throw UnknownException();
        }
      }
      return response;

      // return response.data;
    } on DioError catch (e) {
      final responseData = e.response?.data;
      if (responseData != null) {
        throw Exception();
      } else {
        throw UnknownException();
      }
    }
  }

  // delete request
  Future<dynamic> delete(
    String uri, {
    Map<String, dynamic>? queryparams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        queryParameters: queryparams,
        options: options,
        cancelToken: cancelToken,
      );

      // Check for response status code indicating an error
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        switch (response.statusCode) {
          case 400:
            throw BadRequestException();
          case 404:
            throw NotFoundException();
          case 500:
            throw InternalServerErrorException();
          case 401:
            throw NotFoundException(); // Assuming the 401 should be UnauthorizedException
          default:
            throw UnknownException();
        }
      }
      return response.data;
    } on DioError catch (e) {
      final responseData = e.response?.data;
      if (responseData != null) {
        throw Exception();
      } else {
        throw UnknownException();
      }
    }
  }

  // put request
Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryparams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onRecieneProgress,
  }) async {
    try {
      final Response response = await _dio.put(uri,
          data: data,
          queryParameters: queryparams,
          options: options,
          onReceiveProgress: onRecieneProgress,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken);

      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        switch (response.statusCode) {
          case 400:
            throw BadRequestException();
          case 404:
            throw NotFoundException();
          case 500:
            throw InternalServerErrorException();
          case 401:
            throw NotFoundException();
          default:
            throw UnknownException();
        }
      }
      return response;

      // return response.data;
    } on DioError catch (e) {
      final responseData = e.response?.data;
      if (responseData != null) {
        throw Exception();
      } else {
        throw UnknownException();
      }
    }
  }

}
