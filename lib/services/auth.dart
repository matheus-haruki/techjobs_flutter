import 'package:TechJobs/services/storage_manager.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends QueuedInterceptor {
  static final Dio dio = _createDio();

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl:
            "https://sftd3lh74q5m2m3mtrr2pqx7gy0elkda.lambda-url.us-east-1.on.aws",
      ),
    );

    dio.interceptors.add(AuthInterceptor());

    return dio;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? accessToken = await StorageManager.instance.getAccessToken();

    if (accessToken != null) {
      options.headers.addAll({'Authorization': 'Bearer ${accessToken}'});
    }

    handler.next(options);
  }
}
