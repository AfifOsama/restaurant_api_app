import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant_object.dart';
import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group(
    'fetchRestaurantData',
    () {
      test(
        'Restaurant Provider test if result from ApiService has called succesfully ',
        () async {
          final client = MockClient();
          when(client
                  .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
              .thenAnswer((_) async => http.Response('''{
    "error": false,
    "message": "success",
    "count": 20,
    "restaurants": []}''', 200));
          // assert
          expect(await ApiService(client: client).getRestaurants(),
              isA<Restaurant>());
        },
      );
    },
  );
}
