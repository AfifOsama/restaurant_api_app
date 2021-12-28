import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/provider/preferences_provider.dart';
import 'package:restaurant_api_app/provider/schedulling_provider.dart';
import 'package:restaurant_api_app/theme/styles.dart';
import 'package:restaurant_api_app/widgets/custom_dialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const routeName = '/setting_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings Page',
              style: myTextTheme.headline6?.apply(color: Colors.white)),
          backgroundColor: primaryColor,
        ),
        body: _buildList(context));
  }

  _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: Text('Dark Theme', style: myTextTheme.bodyText1),
                trailing: Switch.adaptive(
                  value: false,
                  onChanged: (value) {
                    customDialog(context);
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title:
                    Text('Scheduling Restaurant', style: myTextTheme.bodyText1),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyRestoActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledRestaurant(value);
                          provider.enableDailyResto(value);
                        }
                      },
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
