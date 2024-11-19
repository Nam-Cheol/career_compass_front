// lib/views/splash_screen.dart

import 'package:career_compass_front/view/user_job_chat.dart';
import 'package:flutter/material.dart';

// import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_screen.dart';
import '../providers/provider/user_provider.dart';

class SplashScreen extends ConsumerWidget {
  // GoogleSignIn 인스턴스 생성
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 로그인 함수
  // Future<void> _handleSignIn(BuildContext context, WidgetRef ref) async {
  //   try {
  //     final account = await _googleSignIn.signIn();
  //     if (account != null) {
  //       // TODO: 실제 사용자 ID를 가져오는 로직을 추가하세요
  //       final userId = 1; // 임시로 1을 할당
  //
  //       // 사용자 ID 설정
  //       ref.read(userIdProvider.notifier).state = userId;
  //
  //       // 로그인 성공 시 홈 화면으로 이동
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomeScreen()),
  //       );
  //     } else {
  //       // 사용자가 로그인 취소 시 처리
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('로그인이 취소되었습니다.')),
  //       );
  //     }
  //   } catch (error) {
  //     print(error);
  //     // 에러 처리
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('로그인에 실패했습니다. 다시 시도해주세요.')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // 배경 이미지 설정
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home.png'), // 수정된 경로
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // 상단 텍스트
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '내 직업은 무엇일까?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black45,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 하단 구글 로그인 버튼
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Image.asset(
                      'assets/images/googleLogIn.png', // 수정된 경로
                      width: 200,
                      height: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
