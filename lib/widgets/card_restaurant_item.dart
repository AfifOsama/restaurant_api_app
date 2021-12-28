import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/common/navigation.dart';
import 'package:restaurant_api_app/data/model/restaurant_detail_arg.dart';
import 'package:restaurant_api_app/data/model/restaurant_object.dart';
import 'package:restaurant_api_app/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_api_app/theme/styles.dart';
import 'package:restaurant_api_app/ui/detail_page.dart';
import 'package:transparent_image/transparent_image.dart';

class CardRestaurantItem extends StatelessWidget {
  final RestaurantData restaurant;
  const CardRestaurantItem({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFav = snapshot.data ?? false;
            return Material(
              child: ListTile(
                tileColor: Colors.white,
                contentPadding: const EdgeInsets.only(bottom: 24),
                leading: Hero(
                  tag: restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FadeInImage.memoryNetwork(
                      image:
                          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                      width: 100,
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                    ),
                  ),
                ),
                title: Text(
                  restaurant.name,
                  style: myTextTheme.bodyText1,
                ),
                subtitle: Text(
                  restaurant.city,
                  style: myTextTheme.subtitle1,
                ),
                trailing: isFav
                    ? IconButton(
                        onPressed: () => provider.removeFavorite(restaurant.id),
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      )
                    : IconButton(
                        onPressed: () => provider.addFavorite(restaurant),
                        icon: const Icon(Icons.favorite_border),
                      ),
                onTap: () => Navigation.intentWithData(
                  DetailPage.routeName,
                  RestaurantDetailArg(id: restaurant.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
