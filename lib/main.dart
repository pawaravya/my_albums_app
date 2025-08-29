import 'package:flutter/material.dart';
import 'package:my_movie_app/app_features/albums/ui/album_list_screen.dart';
import 'package:my_movie_app/app_features/albums/ui/splash_screen.dart';
import 'package:my_movie_app/utils/app_shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.customSharedPreferences.initPrefs();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
