import 'package:career_compass_front/providers/provider/dio_provider.dart';
import 'package:career_compass_front/repository/job/job_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../repository/job/job_repository.dart';

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  final _dio = ref.read(dioProvider);
  return JobRepositoryImpl(_dio);
});
