import 'package:flutter/material.dart';
import 'package:restaurant_api_app/theme/styles.dart';
import 'package:restaurant_api_app/ui/favorite_page.dart';
import 'package:restaurant_api_app/ui/search_page.dart';
import 'package:restaurant_api_app/ui/setting_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: Text(
              'Menu',
              style: myTextTheme.headline5
                  ?.apply(color: Colors.white, fontWeightDelta: 2),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () => Navigator.pushNamed(context, SearchPage.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.favorite_rounded),
            title: const Text('Favorite'),
            onTap: () => Navigator.pushNamed(context, FavoritePage.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            onTap: () => Navigator.pushNamed(context, SettingPage.routeName),
          ),
        ],
      ),
    );
  }
}
