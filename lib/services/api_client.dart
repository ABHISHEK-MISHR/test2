import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:test2/authInterceptor/auth_interceptor.dart';
import 'package:test2/auth_provider/auth_provider.dart';
import '../configs/ct_app_config.dart';

class ApiHttpClient {
  ApiHttpClient(
      this.authProvider
      )
  {
    dio = Dio(
      BaseOptions(baseUrl: "http://ec2-18-61-77-110.ap-south-2.compute.amazonaws.com:8081"),
    );
    dio.interceptors.addAll(interceptor);
  }
  late Dio dio;
  late AuthProvider authProvider;

  List<Interceptor> get interceptor => [
        AuthInterceptor(dio: dio, authProvider: authProvider),
        PrettyDioLogger(requestBody: true),
      ];
}
