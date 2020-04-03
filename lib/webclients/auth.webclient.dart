import 'package:dio/dio.dart';
import 'package:servidordashboard/constraints.dart';

class WebClient{

  // Dio Options
  static BaseOptions authBaseOptions = BaseOptions(
    baseUrl: BASEURL,
    connectTimeout: 60000
  );

  // End point de login
  static String get loginEndPoint => "$BASEURL/login";

  // End point de login
  static String get termEndPoint => "$BASEURL/services/terms";

}