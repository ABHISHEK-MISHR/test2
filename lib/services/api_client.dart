import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../configs/ct_app_config.dart';

class ApiHttpClient {
  ApiHttpClient(
      // this.authProvider
      )
  {
    dio = Dio(
      BaseOptions(baseUrl: CtAppConfig.instance.baseUrl),
    );
    dio.interceptors.addAll(interceptor);
  }
  late Dio dio;
  // late AuthProvider authProvider;

  List<Interceptor> get interceptor => [
        // AuthInterceptor(dio: dio, authProvider: authProvider),
        PrettyDioLogger(requestBody: true),
      ];
}
