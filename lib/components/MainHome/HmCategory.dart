import 'package:flutter/material.dart';
import 'package:flutter_base/viewmodels/home.dart';

class Hmcategory extends SliverPersistentHeaderDelegate {
  final List<CategoryItem> categoryList;

  Hmcategory({required this.categoryList});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categoryList[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 5),
            width: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(category.picture, width: 40, height: 40),
                Text(category.name),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  // 最大折叠区域高度
  double get maxExtent => 100;

  @override
  // 最小折叠区域高度
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // 是否需要重新构建
    return false;
  }
}
