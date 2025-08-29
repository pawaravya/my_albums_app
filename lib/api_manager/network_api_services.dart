import 'package:dio/dio.dart';
import 'base_api_services.dart';
import '../utils/app_view_utils.dart';

class NetworkApiServices extends BaseApiServices {
  NetworkApiServices._internal();
  static final NetworkApiServices _instance = NetworkApiServices._internal();
  static NetworkApiServices getInstance() => _instance;

  final Dio dio = Dio(
    BaseOptions(
      responseType: ResponseType.json,
      contentType: "application/json",
      sendTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
    ),
  );

  @override
  Future<dynamic> generateGetApiResponse(String url) async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        AppViewUtils.showSnackbar(
          title: "Error",
          message: "Failed request with status: ${response.statusCode}",
          isError: true,
        );
        return null;
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return null;
    } catch (e) {
      AppViewUtils.showSnackbar(
        title: "Error",
        message: "Unexpected error occurred",
        isError: true,
      );
      return null;
    }
  }

  void _handleDioError(DioException e) {
    String message = "";
    switch (e.type) {
      case DioExceptionType.cancel:
        message = "Request to API was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in API response";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in API request";
        break;
      case DioExceptionType.badResponse:
        message =
            "Received invalid status code: ${e.response?.statusCode ?? 'Unknown'}";
        break;
      case DioExceptionType.unknown:
        message = "Network error: ${e.message}";
        break;
      default:
        message = "Something went wrong";
    }
    AppViewUtils.showSnackbar(title: "Error", message: message, isError: true);
  }
}
