import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  const HmSlider({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _activeIndex = 0;

  Widget _getSlider() {
    return CarouselSlider(
      carouselController: _carouselController,
      items: widget.bannerList
          .map(
            (item) => Image.network(
              item.imgUrl,
              fit: BoxFit.cover,
              // 获取屏幕宽度
              width: MediaQuery.of(context).size.width,
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        onPageChanged: (index, reason) {
          setState(() {
            _activeIndex = index;
          });
        },
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: 5,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 30,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            "Search....",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _getDots() {
    return Positioned(
      bottom: 5,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.bannerList.length,
            ((index) => GestureDetector(
              onTap: () {
                _carouselController.animateToPage(index);
              },
              child: AnimatedContainer(
                duration: Durations.medium1,
                height: 5,
                width: index == _activeIndex ? 20 : 10,
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: index == _activeIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.4),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
