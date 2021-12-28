import 'package:flutter/foundation.dart';
import 'package:restaurant_api_app/data/database/database_helper.dart';
import 'package:restaurant_api_app/data/model/restaurant_object.dart';
import 'package:restaurant_api_app/utils/result_state.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  RestaurantFavoriteProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantData> _favorite = [];
  List<RestaurantData> get favorite => _favorite;

  late RestaurantData _restaurant;
  RestaurantData get restaurant => _restaurant;

  void _getFavorite() async {
    _favorite = await databaseHelper.getFavs();
    if (_favorite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantData restaurant) async {
    try {
      await databaseHelper.insertFav(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message =
          'Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favorited = await databaseHelper.getFavbyId(id);
    return favorited.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFav(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message =
          'Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
      notifyListeners();
    }
  }
}
