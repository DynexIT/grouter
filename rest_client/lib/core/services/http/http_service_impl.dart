import 'dart:io';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:rest_client/core/exceptions/network_exception.dart';
import 'package:rest_client/core/services/http/http_service.dart';
import 'package:rest_client/core/utils/file_helper.dart';
import 'package:rest_client/core/utils/logger.dart';
import 'package:rest_client/core/utils/network_utils.dart' as network_utils;
import 'package:rest_client/locator.dart';

/// Helper service that abstracts away common HTTP Requests
@LazySingleton(as: HttpService)
class HttpServiceImpl implements HttpService {
  final _fileHelper = locator<FileHelper>();

  Dio dio = Dio()
    ..options.connectTimeout = 20000
    ..options.sendTimeout = 20000
    ..options.receiveTimeout = 20000;

  @override
  Future<dynamic> getHttp(String url, {Map<String, String> headers}) async {
    Response response;

    Logger.d('Sending GET to $url');

    try {
      final fullRoute = '$url';
      response = await dio.get(
        fullRoute,
        options: Options(
          headers: headers,
          contentType: 'application/json',
        ),
      );
    } on Error catch (e) {
      Logger.e('HttpService: Failed to GET ${e}');
      String message = handleError(e);
      throw NetworkException(message);
    }
    network_utils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> getStageHttp(String url, {Map<String, String> headers}) async {
    Response response;

    Logger.d('Sending GET to $url');

    try {
      final fullRoute = '$url';
      response = await dio.get(
        fullRoute,
        options: Options(
          headers: headers,
          contentType: 'application/json',
        ),
      );
    } on Error catch (e) {
      Logger.e('HttpService: Failed to GET ${e}');
      String message = handleError(e);
      throw NetworkException(message);
    }
    network_utils.checkForNetworkExceptions(response);
    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> postHttp(String url, dynamic body, {Map<String, String> headers}) async {
    Response response;

    Logger.d('Sending $body to $url');

    try {
      final fullRoute = Uri.encodeFull('$url');
      response = await dio.post(
        fullRoute,
        data: json.encode(body),
        onSendProgress: network_utils.showLoadingProgress,
        onReceiveProgress: network_utils.showLoadingProgress,
        options: Options(
          headers: headers,
          contentType: 'application/json',
        ),
      );
    } on Error catch (e) {
      Logger.e('HttpService: Failed to POST ${e.toString()}');
      String message = handleError(e);
      throw NetworkException(message);
    }

    network_utils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> deleteHttp(String url, {Map<String, String> headers}) async {
    Response response;

    Logger.d('Sending DELETE to $url');

    try {
      final fullRoute = Uri.encodeFull('$url');
      response = await dio.delete(
        fullRoute,
//        data: json.encode(body),
        options: Options(
          headers: headers,
          contentType: 'application/json',
        ),
      );
    } on Error catch (e) {
      Logger.e('HttpService: Failed to POST ${e}');
      String message = handleError(e);
      throw NetworkException(message);
    }

    network_utils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> postHttpForm(
      String processEndpoint,
      Map<String, dynamic> body,
      List<File> files,
      ) async {
    int index = 0;

    final formData = FormData.fromMap(body);
    files?.forEach((file) async {
      final mFile = await _fileHelper.convertFileToMultipartFile(file);
      formData.files.add(MapEntry('file$index', mFile));
      index++;
    });

    final data = await postHttp(processEndpoint, formData);

    return data;
  }

  @override
  Future<File> downloadFile(String fileUrl) async {
    Response response;

    final file = await _fileHelper.getFileFromUrl(fileUrl);

    try {
      response = await dio.download(
        fileUrl,
        file.path,
        onReceiveProgress: network_utils.showLoadingProgress,
      );
    } on Error catch (e) {
      Logger.e('HttpService: Failed to download file ${e}');
      String message = handleError(e);
      throw NetworkException(message);
    }

    network_utils.checkForNetworkExceptions(response);

    return file;
  }

  @override
  String handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
          "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  @override
  void dispose() {
    dio.clear();
    dio.close(force: true);
  }
}