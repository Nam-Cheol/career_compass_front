// lib/views/mypage_screen.dart

import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // 여기에 마이페이지 내용을 구현하세요.
    return Scaffold(
      appBar: AppBar(
        title: Text('마이 페이지'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '마이 페이지 내용',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

const MyPageScreen();
}
