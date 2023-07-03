import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carouse_Slider extends StatefulWidget {
  const Carouse_Slider({super.key});

  @override
  State<Carouse_Slider> createState() => _Carouse_SliderState();
}

class _Carouse_SliderState extends State<Carouse_Slider> {
  List imagesList = [
    {"id": 1, "image_path": 'assets/images/2.png'},
    {"id": 2, "image_path": 'assets/images/3.png'},
    {"id": 3, "image_path": 'assets/images/5.png'},
    {"id": 4, "image_path": 'assets/images/6.png'},
  ];

  CarouselController _carouselController = CarouselController();

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            InkWell(
              child: CarouselSlider(
                items: imagesList
                    .map(
                      (item) => Image.asset(
                        item['image_path'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                carouselController: _carouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2,
                  scrollPhysics: const BouncingScrollPhysics(),
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imagesList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: (() => _carouselController.animateToPage(entry.key)),
                    child: Container(
                      height: 7,
                      width: _currentIndex == entry.key ? 17 : 7,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _currentIndex == entry.key
                              ? Colors.red
                              : Colors.teal),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        )
      ],
    );
  }
}
