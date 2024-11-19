import 'package:flutter_riverpod/flutter_riverpod.dart';

// 사용자 ID를 관리하는 StateProvider
final userIdProvider = StateProvider<int?>((ref) => 0);

