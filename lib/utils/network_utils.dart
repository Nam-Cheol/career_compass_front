import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

/// 네트워크 관련 유틸리티 클래스
class NetworkUtils {
  /// 웹 환경에서 실행 중인지 확인하는 함수
  /// `kIsWeb`은 플러터에서 제공하는 상수로, 실행 환경이 웹인지 여부를 나타냄
  static bool isWeb() {
    return kIsWeb;
  }

  /// 실행 환경에 따라 IPv4 주소를 반환하는 함수
  /// - 웹: 항상 `127.0.0.1` 반환
  /// - Android 에뮬레이터: `10.0.2.2` 반환
  /// - iOS 시뮬레이터: `127.0.0.1` 반환
  /// - 실제 디바이스: 로컬 네트워크의 IPv4 주소 반환
  /// - 디바이스에서 IPv4 주소를 가져오지 못한 경우 기본 IP 반환
  static Future<String> getIPv4Address() async {
    try {
      // 웹 환경인 경우 로컬호스트 IP 반환
      if (isWeb()) {
        return "127.0.0.1"; // 웹은 항상 로컬호스트로 설정
      } else if (Platform.isAndroid) {
        // Android 실행 환경에서 에뮬레이터인지 확인
        final isEmulator = await _isAndroidEmulator();
        return isEmulator
            ? "10.0.2.2" // Android 에뮬레이터의 기본 로컬호스트
            : await _getLocalIPv4() ?? _defaultIP(); // 실제 디바이스의 IPv4 또는 기본 IP 반환
      } else if (Platform.isIOS) {
        // iOS 실행 환경에서 시뮬레이터인지 확인
        final isSimulator = await _isIosSimulator();
        return isSimulator
            ? "127.0.0.1" // iOS 시뮬레이터의 기본 로컬호스트
            : await _getLocalIPv4() ?? _defaultIP(); // 실제 디바이스의 IPv4 또는 기본 IP 반환
      } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        // 데스크탑 환경에서는 로컬 네트워크의 IPv4 반환
        return await _getLocalIPv4() ?? _defaultIP();
      }
    } catch (e) {
      // 예외 발생 시 오류 로그 출력
      print("Failed to determine IP address: $e");
    }
    // 실패한 경우 기본 IP 반환
    return _defaultIP();
  }

  /// 기본 IP 주소를 반환하는 함수
  /// - IPv4 주소를 탐지하지 못했거나 예외가 발생한 경우 호출
  static String _defaultIP() {
    return "127.0.0.1"; // 안전한 기본값으로 로컬호스트 반환
  }

  /// Android 환경에서 에뮬레이터인지 확인하는 함수
  /// - `device_info_plus`를 사용해 Android 디바이스 정보를 가져옴
  /// - `isPhysicalDevice`가 false이면 에뮬레이터임
  static Future<bool> _isAndroidEmulator() async {
    final deviceInfo = DeviceInfoPlugin(); // 디바이스 정보 플러그인 초기화
    final androidInfo = await deviceInfo.androidInfo; // Android 디바이스 정보 가져오기
    return !androidInfo.isPhysicalDevice; // 에뮬레이터 여부 반환
  }

  /// iOS 환경에서 시뮬레이터인지 확인하는 함수
  /// - `device_info_plus`를 사용해 iOS 디바이스 정보를 가져옴
  /// - `isPhysicalDevice`가 false이면 시뮬레이터임
  static Future<bool> _isIosSimulator() async {
    final deviceInfo = DeviceInfoPlugin(); // 디바이스 정보 플러그인 초기화
    final iosInfo = await deviceInfo.iosInfo; // iOS 디바이스 정보 가져오기
    return !iosInfo.isPhysicalDevice; // 시뮬레이터 여부 반환
  }

  /// 로컬 네트워크의 IPv4 주소를 가져오는 함수
  /// - `dart:io`의 `NetworkInterface`를 사용해 네트워크 인터페이스 정보 조회
  /// - 인터페이스 목록에서 IPv4 주소를 검색해 반환
  static Future<String?> _getLocalIPv4() async {
    try {
      // 네트워크 인터페이스 목록 가져오기
      final interfaces = await NetworkInterface.list(
        includeLinkLocal: false, // link-local 주소 제외 (유효하지 않은 네트워크 주소)
      );
      // 각 인터페이스를 순회하며 IPv4 주소 검색
      for (var interface in interfaces) {
        for (var address in interface.addresses) {
          if (address.type == InternetAddressType.IPv4) {
            return address.address; // 첫 번째 IPv4 주소 반환
          }
        }
      }
    } catch (e) {
      // 예외 발생 시 오류 로그 출력
      print("Error retrieving local IPv4: $e");
    }
    return null; // IPv4 주소를 찾지 못한 경우 null 반환
  }
}
