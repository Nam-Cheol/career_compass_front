import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio> ( (ref) {
  return _dioProvider;
});

final _dioProvider = Dio(

  BaseOptions(
    baseUrl: 'http://192.168.0.82:8080/api',
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 15),
    validateStatus: (status) => true,
    headers: {
      'Content-Type' : 'application/json'
    }
  )
);