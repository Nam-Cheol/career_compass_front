// lib/views/mypage_screen.dart

import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 마이 페이지 전체 레이아웃을 구성하는 Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이 페이지'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 사용자 프로필 섹션
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.blueAccent,
              child: Row(
                children: [
                  // 샘플 사용자 아바타 이미지
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // 샘플 이미지 URL
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 샘플 사용자 이름 및 이메일
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '홍길동', // 샘플 사용자 이름
                        style: TextStyle(
                          fontSize:  24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'honggildong@example.com', // 샘플 사용자 이메일
                        style: TextStyle(
                          fontSize:  16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 설정 목록 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // 샘플 설정 항목 1
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('프로필 수정'), // 샘플 설정 제목
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 프로필 수정 화면으로 이동하는 로직
                    },
                  ),
                  const Divider(),
                  // 샘플 설정 항목 2
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('앱 설정'), // 샘플 설정 제목
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 앱 설정 화면으로 이동하는 로직
                    },
                  ),
                  const Divider(),
                  // 샘플 설정 항목 3
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('도움말 및 지원'), // 샘플 설정 제목
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 도움말 및 지원 화면으로 이동하는 로직
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 로그아웃 버튼 섹션
            ElevatedButton(
              onPressed: () {
                // 로그아웃 로직 구현
              },
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                '로그아웃', // 로그아웃 버튼 텍스트
                style: TextStyle(fontSize:  16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
