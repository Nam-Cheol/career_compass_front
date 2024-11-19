import 'package:career_compass_front/models/job/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/job_view_model.dart';
import 'job_repository_provider.dart';
import '../provider/job_repository_provider.dart';

final chatProvider = StateNotifierProvider<JobViewModel, ChatState>((ref) {
  final jobRepository = ref.watch(jobRepositoryProvider);
  return JobViewModel(jobRepository, ref);
});
