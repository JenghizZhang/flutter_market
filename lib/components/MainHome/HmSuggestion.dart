import 'package:flutter/material.dart';
import 'package:flutter_base/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  final SpecialRecommendResult specialRecommendResult;
  const HmSuggestion({super.key, required this.specialRecommendResult});

  @override
  State<HmSuggestion> createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            color: const Color.fromARGB(255, 86, 24, 20),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省钱攻略",
          style: TextStyle(
            color: const Color.fromARGB(255, 124, 63, 58),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  List<GoodsItem> _getDisplayItems() {
    if (widget.specialRecommendResult.subTypes.isEmpty) {
      return [];
    }
    return widget.specialRecommendResult.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  List<Widget> _getChildrenList() {
    var list = _getDisplayItems();
    return list
        .map(
          (item) => Expanded(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.picture,
                    // width: 100,
                    height: 110,
                    fit: BoxFit.fill,
                    errorBuilder: ((context, error, stackTrace) => Image.asset(
                      "lib/assets/home_cmd_inner.png",
                      height: 110,
                      // width: 100,
                    )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 96, 12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${item.price}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("lib/assets/home_cmd_sm.png"),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 15),
          Row(
            children: [
              _buildLeft(),
              SizedBox(width: 10),
              Expanded(
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _getChildrenList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
