import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio> ( (ref) {
  return _dioProvider;
});

final _dioProvider = Dio(

  BaseOptions(
    /// 서버 주소로 콜백 ipv4 주소 입력
    baseUrl: 'http://127.0.0.1:8080/api',
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 15),
    validateStatus: (status) => true,
    headers: {
      'Content-Type' : 'application/json'
    }
  )
);