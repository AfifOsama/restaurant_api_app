import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant_detail_arg.dart';
import 'package:restaurant_api_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_api_app/theme/styles.dart';
import 'package:restaurant_api_app/ui/detail_body.dart';
import 'package:restaurant_api_app/utils/result_state.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final RestaurantDetailArg detailArgs;
  const DetailPage({Key? key, required this.detailArgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            apiService: ApiService(), id: detailArgs.id),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              var restaurant = state.result!.restaurantDetailsData;
              return NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverSafeArea(
                        top: false,
                        sliver: SliverAppBar(
                          backgroundColor: primaryColor,
                          expandedHeight: 230,
                          pinned: true,
                          floating: true,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Hero(
                                  tag: restaurant.pictureId,
                                  child: NetworkImage(
                                    imgUrl:
                                        'https://restaurant-api.dicoding.dev/images/medium/' +
                                            restaurant.pictureId,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.center,
                                      colors: <Color>[
                                        Color(0x90000000),
                                        Color(0x00000000),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              restaurant.name,
                              style: myTextTheme.headline6
                                  ?.apply(fontWeightDelta: 2),
                            ),
                            titlePadding:
                                const EdgeInsets.only(left: 48, bottom: 14),
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: DetailBody(
                  restaurantData: restaurant,
                ),
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
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}

class NetworkImage extends StatelessWidget {
  final String imgUrl;
  final double width;
  final BoxFit fit;
  const NetworkImage(
      {Key? key, required this.imgUrl, required this.width, required this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imgUrl,
      width: width,
      fit: fit,
    );
  }
}
