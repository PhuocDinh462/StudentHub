import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio publicDio = Dio(
  BaseOptions(
    baseUrl: dotenv.env['API_SERVER']!,
  ),
);
