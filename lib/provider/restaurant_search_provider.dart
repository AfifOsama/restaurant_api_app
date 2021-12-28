import 'package:flutter/foundation.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant_search_object.dart';
import 'package:restaurant_api_app/utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService}) {
    fetchRestaurantbySearch("r");
  }

  late RestaurantSearch? _restaurantSearch;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantSearch? get result => _restaurantSearch!;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurantbySearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurantbySearch(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'Invalid Restaurant or Menu name';
        notifyListeners();
        return _message;
      } else {
        _state = ResultState.hasData;
        _restaurantSearch = restaurant;
        notifyListeners();
        return _restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
    }
  }
}
