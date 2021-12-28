import 'package:flutter/material.dart';
import 'package:restaurant_api_app/data/model/restaurant_detail_object.dart';
import 'package:restaurant_api_app/theme/styles.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({Key? key, required this.restaurantData}) : super(key: key);
  final RestaurantDetailsData restaurantData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 22,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Description',
                style: myTextTheme.headline5
                    ?.apply(fontWeightDelta: 2, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 24, left: 24, bottom: 16, top: 8),
              child: Text(
                restaurantData.description,
                style: myTextTheme.bodyText2,
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 24, bottom: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.place),
                        Text(
                          restaurantData.city,
                          style: myTextTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 32, bottom: 16, top: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              restaurantData.rating.toString(),
                              style: myTextTheme.bodyText1?.apply(
                                  fontWeightDelta: 2, fontSizeDelta: 10),
                            ),
                          ],
                        ),
                        Text(
                          restaurantData.rating >= 4.0 ? 'Very Good' : 'Good',
                          style: myTextTheme.caption,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 22, top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(12)),
              child: Text(
                'Menus',
                style: myTextTheme.headline5
                    ?.apply(fontWeightDelta: 2, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, top: 16),
              child: Text(
                'Foods',
                style: myTextTheme.bodyText1?.apply(fontWeightDelta: 2),
              ),
            ),
            const Divider(
              thickness: 1.5,
              endIndent: 320,
              indent: 20,
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: restaurantData.menus.foods
                  .map(
                    (food) => Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(
                                'assets/images/diet.png',
                                width: 100,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Flexible(
                            flex: 2,
                            child: Text(
                              food.name,
                              style: myTextTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, top: 36),
              child: Text(
                'Drinks',
                style: myTextTheme.bodyText1?.apply(fontWeightDelta: 2),
              ),
            ),
            const Divider(
              thickness: 1.5,
              endIndent: 320,
              indent: 20,
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: restaurantData.menus.drinks
                  .map(
                    (drink) => Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              'assets/images/drink.png',
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            drink.name,
                            style: myTextTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
