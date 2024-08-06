import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../auth_provider/auth_provider.dart';
import '../constants/json_constants.dart';
import '../utils/hive_box_helper.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final Dio dio; //for logged
  final AuthProvider authProvider;
  AuthInterceptor({required this.dio, required this.authProvider});
  Completer? refreshingToken;
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final ignoreRefreshLogic =
        options.headers[JsonConstants.ignoreRefreshController] ?? false;
    if (!ignoreRefreshLogic &&
        refreshingToken != null &&
        (options.headers['Retry-Count'] ?? 0) < 1) {
      await refreshingToken!.future;
    }
    // final token = HiveBoxHelper.instance.getaccessToken();
    // if (options.headers[JsonConstants.noAuthHeader] != true && token.check) {
    //   // log('AUTH TOKEN : $token');
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    options.headers['SW-User-Agent'] =
    Platform.isIOS ? 'sw-ios/27' : 'sw-android/27';

    options.headers.remove(JsonConstants.noAuthHeader);
    return handler.next(options);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // FirebaseCrashlytics.instance.recordError(err, err.stackTrace,
    //     fatal: false, reason: 'Api Error Logs', printDetails: true);
    //This retries the request if the token was updated later on
    final RequestOptions options = err.requestOptions;
    if (err.response?.statusCode == 401) {
      if (refreshingToken != null && !refreshingToken!.isCompleted) {
        await refreshingToken!.future;
        options.headers['Retry-Count'] = (options.headers['Retry-Count'] ?? 0) +
            1; //setting retry count to 1 to prevent further concurrent calls
        // final newToken = HiveBoxHelper.instance.getaccessToken();
        // options.headers['Authorization'] = 'Bearer $newToken';
        return handler.resolve(await dio.fetch(options));
      }
      //check if retry count is 1 (retry count gives number of attempt for refresh token renewable
      if ((options.headers['Retry-Count'] ?? 0) >= 1) {
        await authProvider.logOut();
        return handler.next(err);
      }
      try {
        refreshingToken = Completer();
        // await authProvider.refreshToken();
        options.headers['Retry-Count'] = (options.headers['Retry-Count'] ?? 0) +
            1; //setting retry count to 1 to prevent further concurrent calls
        // final newToken = HiveBoxHelper.instance.getaccessToken();
        // options.headers['Authorization'] = 'Bearer $newToken';
        refreshingToken!.complete();
        return handler.resolve(await dio.fetch(options));
      } catch (e) {
        await authProvider.logOut();
        return handler.next(err);
      }
    } else {
      return handler.next(err);
    }
  }
}