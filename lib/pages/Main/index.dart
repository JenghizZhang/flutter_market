import 'package:flutter/material.dart';
import 'package:flutter_base/api/user.dart';
import 'package:flutter_base/pages/MainCart/index.dart';
import 'package:flutter_base/pages/MainCategory/index.dart';
import 'package:flutter_base/pages/MainHome/index.dart';
import 'package:flutter_base/pages/MainMy/index.dart';
import 'package:flutter_base/stores/TokenManager.dart';
import 'package:flutter_base/stores/UserController.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  final UserController _userController = Get.put(UserController());

  _initUser() async {
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      print(tokenManager.getToken());
      _userController.updateUserInfo(await getUserInfoAPI());
    }
  }

  // 定义数据 根据数据类型进行渲染4个导航
  final List<Map<String, String>> _tabList = [
    {
      "activeIcon": "lib/assets/ic_public_home_active.png",
      "icon": "lib/assets/ic_public_home_normal.png",
      "text": "Home",
    },
    {
      "activeIcon": "lib/assets/ic_public_pro_active.png",
      "icon": "lib/assets/ic_public_pro_normal.png",
      "text": "Category",
    },
    {
      "activeIcon": "lib/assets/ic_public_cart_active.png",
      "icon": "lib/assets/ic_public_cart_normal.png",
      "text": "Cart",
    },
    {
      "activeIcon": "lib/assets/ic_public_my_active.png",
      "icon": "lib/assets/ic_public_my_normal.png",
      "text": "My",
    },
  ];

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea()避开安全区组件
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
        // type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: _tabList
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Image.asset(tab["icon"]!, width: 30, height: 30),
                activeIcon: Image.asset(
                  tab["activeIcon"]!,
                  width: 30,
                  height: 30,
                ),
                label: tab["text"]!,
              ),
            )
            .toList(),
      ),
    );
  }
}
