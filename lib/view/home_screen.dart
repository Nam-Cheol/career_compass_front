// lib/views/home_screen.dart

import 'package:career_compass_front/view/user_job_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'list_screen.dart';
import 'mypage_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {



  @override
  _HomeScreenState createState() => _HomeScreenState();

  const HomeScreen();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ListScreen(),
    MyPageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _startChat() {
    // 채팅 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserJobChat(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startChat,
        child: Icon(Icons.chat),
        tooltip: 'AI와 대화하기',
      ),
    );
  }
}
