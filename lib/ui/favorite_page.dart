import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_api_app/theme/styles.dart';
import 'package:restaurant_api_app/utils/result_state.dart';
import 'package:restaurant_api_app/widgets/card_restaurant_item.dart';

class FavoritePage extends StatelessWidget {
  static const String routeName = '/favorite_page';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Favorite Page',
          style: myTextTheme.headline6?.apply(color: Colors.white),
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              return CardRestaurantItem(
                restaurant: provider.favorite[index],
              );
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}
