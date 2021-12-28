import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/common/navigation.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant_detail_arg.dart';
import 'package:restaurant_api_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_api_app/provider/preferences_provider.dart';
import 'package:restaurant_api_app/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_api_app/provider/restaurant_provider.dart';
import 'package:restaurant_api_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_api_app/provider/schedulling_provider.dart';
import 'package:restaurant_api_app/ui/favorite_page.dart';
import 'package:restaurant_api_app/ui/home_page.dart';
import 'package:restaurant_api_app/ui/search_page.dart';
import 'package:restaurant_api_app/ui/setting_page.dart';
import 'package:restaurant_api_app/ui/splash_screen.dart';
import 'package:restaurant_api_app/utils/background_service.dart';
import 'package:restaurant_api_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/database/database_helper.dart';
import 'theme/styles.dart';
import 'ui/detail_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) => RestaurantSearchProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<RestaurantFavoriteProvider>(
          create: (_) => RestaurantFavoriteProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                detailArgs: ModalRoute.of(context)?.settings.arguments
                    as RestaurantDetailArg,
              ),
          SearchPage.routeName: (context) => const SearchPage(),
          FavoritePage.routeName: (context) => const FavoritePage(),
          SettingPage.routeName: (context) => const SettingPage(),
        },
        navigatorKey: navigatorKey,
      ),
    );
  }
}
