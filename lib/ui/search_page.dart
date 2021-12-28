import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/common/navigation.dart';
import 'package:restaurant_api_app/data/model/restaurant_detail_arg.dart';
import 'package:restaurant_api_app/data/model/restaurant_search_object.dart';
import 'package:restaurant_api_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_api_app/theme/styles.dart';
import 'package:restaurant_api_app/ui/detail_page.dart';
import 'package:restaurant_api_app/utils/result_state.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Page',
          style: myTextTheme.headline6?.apply(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Insert a restaurant or menu name',
                ),
                style: myTextTheme.subtitle1,
                controller: _textEditController,
                onChanged: (query) {
                  Provider.of<RestaurantSearchProvider>(context, listen: false)
                      .fetchRestaurantbySearch(query);
                },
              ),
            ),
            _buildSearchItem(context),
          ],
        ),
      ),
    );
  }

  _buildSearchItem(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.result!.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result!.restaurants[index];
              return _cardSearchItem(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }

  _cardSearchItem({required RestaurantSearchData restaurant}) {
    return Material(
      child: ListTile(
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
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
        trailing: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Rating:  ', style: myTextTheme.subtitle2),
              TextSpan(
                  text: restaurant.rating.toString(),
                  style: myTextTheme.subtitle2?.apply(fontWeightDelta: 2)),
            ],
          ),
        ),
        onTap: () {
          Navigation.intentWithData(
            DetailPage.routeName,
            RestaurantDetailArg(id: restaurant.id),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
  }
}
