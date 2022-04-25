
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lm_hod/ReusableUtils/Responsive.dart';
import '../Responsive.dart';

class ScrollPageView extends StatefulWidget {
  const ScrollPageView({Key? key}) : super(key: key);

  @override
  State<ScrollPageView> createState() => _ScrollPageViewState();
}

class _ScrollPageViewState extends State<ScrollPageView> {
  int _currentPage = 0;

  late Timer _timer;
  late bool end;
  double radius = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState(){
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if(_currentPage == 4){
        end = true;
      }
      else if(_currentPage == 0){
        end = false;
      }

      if(end == false){
        _currentPage++;

      }
      else{
        _currentPage--;

      }
      _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }

  @override
  void dispose(){
    super.dispose();
    _timer.cancel();
  }
  List<String> listImages = [
    'assets/ScrollableImages/college.jpg',
    'assets/ScrollableImages/3.jpg',
    'assets/ScrollableImages/2.jpg',
    'assets/ScrollableImages/s2.jpg',
    'assets/ScrollableImages/about1.jpg'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: PageView(
        controller: _pageController,
        children: [
          Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenLayout(radius, context)),
              image: DecorationImage(
                  image: AssetImage(listImages[0]),
                  fit: BoxFit.cover
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: screenLayout(350, context)),

            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(
                  image: AssetImage(listImages[1]),
                  fit: BoxFit.cover
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: screenLayout(350, context)),

            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(
                  image: AssetImage(listImages[2]),
                  fit: BoxFit.cover
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: screenLayout(350, context)),

            ),),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(
                  image: AssetImage(listImages[3]),
                  fit: BoxFit.cover
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: screenLayout(350, context)),

            ),),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(
                  image: AssetImage(listImages[4]),
                  fit: BoxFit.cover
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: screenLayout(350, context)),
            ),
          ),
        ],
      ),
    );
  }
}

