import 'package:flutter/material.dart';
import 'package:halmoney/screens/home/home.dart';
import 'package:halmoney/screens/myPage/myPage.dart';
import 'package:halmoney/Community_pages/Community_main_page.dart';
import 'package:halmoney/JobSearch_pages/JobSearch_main_page.dart';

class MyAppPage extends StatefulWidget{
  final String id;
  const MyAppPage({super.key, required this.id});

  @override
  State<MyAppPage> createState() => MyAppState();
}

class MyAppState extends State<MyAppPage>{
  int _selectedIndex = 0;

  late final List<Widget> _navIndex;

  @override
  void initState(){
    super.initState();
    _navIndex = [
      MyHomePage(id: widget.id),
      JobSearch(id: widget.id),
      Communitypage(id: widget.id),
      MyPageScreen(id: widget.id),
    ];
  }
  /*final List<Widget> _navIndex = [
    const MyHomePage(),
    const JobSearch(),
    const Communitypage(),
    const MyPageScreen(),
  ];*/

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label : '홈',),
          BottomNavigationBarItem(icon: Icon(Icons.person_search_outlined), label: '채용공고',),
          BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: '커뮤니티',),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이페이지',),
        ],
        onTap: _onNavTapped,
      ),
    );
  }
}