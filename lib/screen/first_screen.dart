
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';
import 'package:test2/constants/route_name_constants.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with SingleTickerProviderStateMixin{
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late GifController _controller ;

  // late GifController controller;
  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync:this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.repeat(min: 0, max: 29, period: Duration(milliseconds: 2));
    });
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 2));
    context.push(RouteNameConstants.dashboardSR);
  }



  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              Container(
                color: Colors.red,
                child: Column(
                  children: [
                    Gif(
                      image: AssetImage("assets/gif/intro.gif"),
                      controller: _controller,
                      // if duration and fps is null, original gif fps will be used.
                      //fps: 30,
                      //duration: const Duration(seconds: 3),
                      autostart: Autostart.no,
                      placeholder: (context) => const Text('Loading...'),
                      onFetchCompleted: () {
                        _controller.reset();
                        _controller.forward();
                      },
                    ),
                    Center(
                        child: Text('Page 1',
                            style:
                                TextStyle(fontSize: 24, color: Colors.white))),
                  ],
                ),
              ),
              Container(
                color: Colors.green,
                child: Center(
                    child: Text('Page 2',
                        style: TextStyle(fontSize: 24, color: Colors.white))),
              ),
              Container(
                color: Colors.blue,
                child: Center(
                    child: Text('Page 3',
                        style: TextStyle(fontSize: 24, color: Colors.white))),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => _buildDot(index)),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
      width: _currentPage == index ? 12.0 : 8.0,
      height: _currentPage == index ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.black : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
