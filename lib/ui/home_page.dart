import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/provider/restaurant_provider.dart';
import 'package:restaurant_api_app/theme/styles.dart';
import 'package:restaurant_api_app/utils/result_state.dart';
import 'package:restaurant_api_app/widgets/card_restaurant_item.dart';
import 'package:restaurant_api_app/widgets/drawer_widget.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(
          'Restaurant App',
          style: myTextTheme.headline6?.apply(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Hungry, ', style: myTextTheme.headline4),
                      TextSpan(
                        text: 'Osama',
                        style: myTextTheme.headline4?.apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Delivering to ',
                            style: myTextTheme.subtitle2),
                        TextSpan(
                            text: 'Home',
                            style: myTextTheme.subtitle2
                                ?.apply(color: primaryColor)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 16),
                child: Text('Please, choose the Restaurants...',
                    style: myTextTheme.bodyText2?.apply(fontWeightDelta: 2)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.state == ResultState.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.result.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = state.result.restaurants[index];
                          return CardRestaurantItem(
                            restaurant: restaurant,
                          );
                        },
                      );
                    } else if (state.state == ResultState.noData) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state.state == ResultState.error) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return const Center(
                        child: Text(''),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
