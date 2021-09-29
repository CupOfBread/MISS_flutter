import 'package:miss/home/home_page.dart';
import 'package:miss/members/member_page.dart';
import 'package:miss/my/my_page.dart';
import 'package:flutter/material.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';


class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProsteIndexedStack(
        index: _index,
        children: [
          IndexedStackChild(child: Home()),
          IndexedStackChild(child: Member()),
          IndexedStackChild(child: My()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: _onBottomNavigationItemTapped,
        items: [
          _getBottomNavItem(
              "主页", "assets/images/nav/ttq.png", "assets/images/nav/ttq_a.png", 0),
          _getBottomNavItem(
              "联系人", "assets/images/nav/zs.png", "assets/images/nav/zs_a.png", 1),
          _getBottomNavItem(
              "我的", "assets/images/nav/nn.png", "assets/images/nav/nn_a.png", 2),

        ],
      ),
    );
  }

  void _onBottomNavigationItemTapped(index) {
    setState(() {
      _index = index;
    });
  }

  BottomNavigationBarItem _getBottomNavItem(
      String title, String normalIcon, String pressedIcon, int index) {
    return BottomNavigationBarItem(
      icon: _index == index
          ? Image.asset(
              pressedIcon,
              width: 32,
              height: 28,
            )
          : Image.asset(
              normalIcon,
              width: 32,
              height: 28,
            ),
      label: title,
      tooltip: '',
    );
  }
}
