// 封装api 目的是返回业务侧要的数据结构
import 'package:flutter_base/constants/index.dart';
import 'package:flutter_base/utils/DioRequest.dart';
import 'package:flutter_base/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  DioRequest dioRequest = DioRequest();
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List)
      .map((item) => BannerItem.fromJSON(item))
      .toList();
}

Future<List<CategoryItem>> getCategoryListAPI() async {
  DioRequest dioRequest = DioRequest();
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List)
      .map((item) => CategoryItem.fromJSON(item))
      .toList();
}

Future<SpecialRecommendResult> getRecommendationListAPI() async {
  DioRequest dioRequest = DioRequest();
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.RECOMMENDATION_LIST),
  );
}

// 热榜推荐
Future<SpecialRecommendResult> getInVogueListAPI() async {
  DioRequest dioRequest = DioRequest();
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<SpecialRecommendResult> getOneStopListAPI() async {
  DioRequest dioRequest = DioRequest();
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  DioRequest dioRequest = DioRequest();
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
