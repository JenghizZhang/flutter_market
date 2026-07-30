import 'package:flutter/material.dart';
import 'package:flutter_base/api/my.dart';
import 'package:flutter_base/components/MainHome/HmMoreList.dart';
import 'package:flutter_base/components/MainMy/HmGuess.dart';
import 'package:flutter_base/stores/UserController.dart';
import 'package:flutter_base/viewmodels/home.dart';
import 'package:get/get.dart';

class MineView extends StatefulWidget {
  MineView({Key? key}) : super(key: key);

  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  List<GoodDetailItem> _list = [];
  Map<String, dynamic> _params = {"page": 1, "pageSize": 10};
  final ScrollController _controller = ScrollController();
  bool _isLoading = false;
  bool _hasMore = true;
  final UserController _userController = Get.find();

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFFFF2E8), const Color(0xFFFDF6F1)],
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 40, top: 80, bottom: 20),
      child: Row(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 26,
              backgroundImage: _userController.user.value.id.isNotEmpty
                  ? NetworkImage(_userController.user.value.avatar)
                  : AssetImage('lib/assets/goods_avatar.png'),
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      if (!_userController.user.value.id.isNotEmpty) {
                        Navigator.pushNamed(context, "/login");
                      }
                    },
                    child: Text(
                      _userController.user.value.id.isNotEmpty
                          ? _userController.user.value.account
                          : '立即登录',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 197, 153),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset("lib/assets/ic_user_vip.png", width: 30, height: 30),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '升级美荟商城会员，尊享无限免邮',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(128, 44, 26, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(126, 43, 26, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('立即开通', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    Widget item(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item("lib/assets/ic_user_collect.png", '我的收藏'),
            item("lib/assets/ic_user_history.png", '我的足迹'),
            item("lib/assets/ic_user_unevaluated.png", '我的客服'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderModule() {
    Widget orderItem(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '我的订单',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  orderItem("lib/assets/ic_user_order.png", '全部订单'),
                  orderItem("lib/assets/ic_user_obligation.png", '待付款'),
                  orderItem("lib/assets/ic_user_unreceived.png", '待发货'),
                  orderItem("lib/assets/ic_user_unshipped.png", '待收货'),
                  orderItem("lib/assets/ic_user_unevaluated.png", '待评价'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getGuessList() async {
    if (_isLoading || !_hasMore) {
      // 有人正在加载或者没有下一页
      return;
    }

    _isLoading = true;
    final res = await getGuessListAPI(_params);
    setState(() {
      _list.addAll(res.items);
      _isLoading = false;

      if (res.pages > _params["page"]) {
        _params["page"] += 1;
      } else {
        _hasMore = false;
      }
    });
  }

  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels <
          _controller.position.maxScrollExtent - 50) {
        _getGuessList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getGuessList();
    _registerEvent();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildVipCard()),
        SliverToBoxAdapter(child: _buildQuickActions()),
        SliverToBoxAdapter(child: _buildOrderModule()),
        // 猜你喜欢
        SliverPersistentHeader(delegate: HmGuess(), pinned: true),

        HmMoreList(recommendList: _list),
      ],
    );
  }
}
