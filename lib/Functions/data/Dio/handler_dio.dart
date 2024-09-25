import 'package:dio/dio.dart';

// -------------
// ---------
// ------
// ---
// Can see how use a code by this class :
// [HowUseIt]
// ---
// ------
// ---------
// -------------


class HandlerApiDio {
  final Dio _dio;
  static const String baseURL ='';
  static const String tokenUser ='';
  // Singleton pattern to ensure one instance of HandlerApiDio
  static final HandlerApiDio _instance = HandlerApiDio._internal();

  factory HandlerApiDio() {
    return _instance;
  }

  HandlerApiDio._internal()
      : _dio = Dio(BaseOptions(
          baseUrl: baseURL, // Set your API base URL
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        )) {
    // Optional: Set up interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = tokenUser;
        // Do something before request is sent, e.g., add auth token
        // options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        response.data = response.data;
        // Do something with response data
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Do something with response error
          e.response?.data = e.response?.data;
          e.response?.statusCode = e.response?.statusCode;
          e.response?.statusMessage = e.response?.statusMessage;
          e.response?.headers = e.response!.headers;
          e.response?.requestOptions = e.response!.requestOptions;
        // Handle errors
        return handler.next(e);
      },
    ));
  }

  // Method to perform GET requests
  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw Exception('Error fetching data: ${e.message}');
    }
  }

  // Method to perform POST requests
  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Error posting data: ${e.message}');
    }
  }

  // Method to perform PUT requests (update)
  Future<Response> update(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Error updating data: ${e.message}');
    }
  }

  // Method to perform DELETE requests
  Future<Response> delete(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw Exception('Error deleting data: ${e.message}');
    }
  }
}
