import 'package:flutter/material.dart';
import 'package:flutter_base/api/home.dart';
import 'package:flutter_base/components/MainHome/HmCategory.dart';
import 'package:flutter_base/components/MainHome/HmHot.dart';
import 'package:flutter_base/components/MainHome/HmMoreList.dart';
import 'package:flutter_base/components/MainHome/HmSlider.dart';
import 'package:flutter_base/components/MainHome/HmSuggestion.dart';
import 'package:flutter_base/utils/ToastUtils.dart';
import 'package:flutter_base/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;
  double _paddingTop = 0;

  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 热榜推荐
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _getBannerList() async {
    var bannerList = await getBannerListAPI();

    setState(() {
      _bannerList = bannerList;
    });
  }

  Future<void> _getCategoryList() async {
    var categoryList = await getCategoryListAPI();

    setState(() {
      _categoryList = categoryList;
    });
  }

  Future<void> _getRecommendResult() async {
    var specialRecommendResult = await getRecommendationListAPI();
    setState(() {
      _specialRecommendResult = specialRecommendResult;
    });
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_loading || !_hasMore) {
      return;
    }

    _loading = true;
    _recommendList = await getRecommendListAPI({"limit": _page * 10});
    _loading = false;
    setState(() {});
    if (_recommendList.length < _page * 10) {
      _hasMore = false;
      return;
    }

    _page += 1;
  }

  // 监听滚动到底部的事件
  void _registerEvent() {
    // 到底部50个单位的地方
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 10) {
      // 加载下一页数据
      _getRecommendList();
    }
  }

  @override
  void initState() {
    super.initState();

    // initState先于build => 下拉刷新组件
    // 用Future.microTask
    Future.microtask(() {
      setState(() {
        _paddingTop = 100;
      });
      _key.currentState?.show();
    });
    _scrollController.addListener(_registerEvent);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_registerEvent);
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverPersistentHeader(delegate: Hmcategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  Future<void> _onRefresh() async {
    // 2. 数据重置，重新获取

    
    _page = 1;
    _loading = false;
    _hasMore = true;

    await _getBannerList();
    await _getCategoryList();
    await _getRecommendResult();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();

    // 3. 获取完毕提示消息（封装）
    ToastUtils.showToast(context, null);

    setState(() {
      _paddingTop = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1.使用RefreshIndicator包裹子组件，向下拉触发onRefresh函数
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        duration: Durations.medium2,
        padding: EdgeInsets.only(top: _paddingTop),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
