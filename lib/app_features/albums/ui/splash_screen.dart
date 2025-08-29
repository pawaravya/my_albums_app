import 'package:flutter/material.dart';
import 'package:my_movie_app/common_widgets/app_text.dart';
import 'package:my_movie_app/constants/string_constants.dart';
import 'album_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.5;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _navigateToAlbumScreen();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      _opacity = 1.0;
      _scale = 1.0;
    });
  }

  void _navigateToAlbumScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const AlbumListScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: _opacity,
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOutBack,
            child: AppText(
              text: StringConstants.appName,
              appTextOptions: AppTextOptions(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
