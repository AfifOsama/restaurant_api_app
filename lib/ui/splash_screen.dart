import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_api_app/theme/styles.dart';

import 'home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/1024.png',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Restaurant App',
                    style: myTextTheme.headline6?.apply(color: Colors.white)),
              ),
            ),
          ],
        ),
        duration: 1000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const HomePage(),
        centered: true,
      ),
    );
  }
}
