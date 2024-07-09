import 'package:dio/dio.dart';
import 'package:test2/constants/json_constants.dart';
import 'package:test2/provider/base_provider.dart';
import 'package:test2/services/api_client.dart';
import 'package:test2/services/snackbar_helper.dart';
import 'package:test2/utils/enum_utils.dart';

class ApiClient extends BaseChangeNotifierProvider {
  /// {@macro api_client}
  ApiClient();

  late ApiHttpClient _httpClient;

  void initHttpClient(ApiHttpClient httpclient) {
    _httpClient = httpclient;
  }

  Future<Response> request({
    required String path,
    RequestType type = RequestType.get,
    dynamic data,
    Options? options,
    bool handleError = false,
    bool authenticated = true,
    bool ignoreRefreshController = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (!authenticated) {
        final newHeader = options?.headers ?? {};
        newHeader.addAll({
          JsonConstants.noAuthHeader: true,
        });
        options = options?.copyWith(
          headers: newHeader,
        );
      }
      if (ignoreRefreshController) {
        final newHeader = options?.headers ?? {};
        newHeader.addAll({
          JsonConstants.ignoreRefreshController: true,
        });
        options = options?.copyWith(
          headers: newHeader,
        ) ??
            Options(headers: newHeader);
      }
      switch (type) {
        case RequestType.post:
          return _httpClient.dio.post(
            path,
            data: data,
            options: options,
            queryParameters: queryParameters,
          );

        case RequestType.get:
          return _httpClient.dio.get(
            path,
            options: options,
            queryParameters: queryParameters,
          );
        case RequestType.put:
          return _httpClient.dio.put(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
          );
        case RequestType.delete:
          return _httpClient.dio.delete(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
          );
        case RequestType.patch:
          return _httpClient.dio.patch(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
          );
      }
    } on DioException catch (e) {
      if (handleError) {
        SnackBarHelper.instance.showBaseSnackBar(
            title: e.response?.data['message'] ?? 'Something went wrong!');
      }
      rethrow;
    } catch (e) {
      if (handleError) {
        SnackBarHelper.instance
            .showBaseSnackBar(title: 'Something went wrong!');
      }
      rethrow;
    }
  }




}
