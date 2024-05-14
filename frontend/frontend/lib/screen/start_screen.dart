import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/const.dart';
import 'package:frontend/screen/sign_up.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              Page(
                  currentPage: _currentPage,
                  color: Colors.white54,
                  text:
                      'مسافر مع قروب؟ لا تشيل هم تطبيقنا بيساعدك في تنظيم مدفوعات السفرة',
                  onNextPressed: nextPage),
              Page(
                  currentPage: _currentPage,
                  color: Colors.white,
                  text: 'قسم الفواتير مع أصحابك وصنفها حسب فئات مختلفة ',
                  onNextPressed: nextPage),
              Page(
                  currentPage: _currentPage,
                  color: Colors.white,
                  text:
                      'ما وصلتك فلوسك؟ تقدر ترسلهم تذكيرات بالمبالغ الغير مدفوعة',
                  onNextPressed: nextPage),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary2,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                _currentPage == 2 ? 'سجل' : 'التالي',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void nextPage() {
    if (_currentPage < 2) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 100), curve: Curves.ease);
    }
    if (_currentPage == 2) {
      // to navigate to a different screen
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Page extends StatelessWidget {
  final int currentPage;
  final Color color;
  final String text;
  final VoidCallback onNextPressed;

  Page(
      {required this.currentPage,
      required this.color,
      required this.text,
      required this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/get_started${currentPage + 1}.svg',
            width: 200, // Adjust width as needed
            height: 200, // Adjust height as needed
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                text,
                style: const TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 23, 23, 23)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
