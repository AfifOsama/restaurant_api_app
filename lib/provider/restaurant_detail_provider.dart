import 'package:flutter/foundation.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant_detail_object.dart';
import 'package:restaurant_api_app/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurant(id);
  }

  late RestaurantDetails? _restaurantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetails? get result => _restaurantDetail!;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.getDetailRestaurant(id);
      if (restaurantDetail.restaurantDetailsData.id.isEmpty) {
        _state = ResultState.noData;
        _message = 'Restaurant Detail Data is Empty';
        notifyListeners();
        return _message;
      } else {
        _state = ResultState.hasData;
        _restaurantDetail = restaurantDetail;
        notifyListeners();
        return _restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
    }
  }
}
