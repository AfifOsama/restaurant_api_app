import 'dart:convert';

import 'package:restaurant_api_app/data/model/restaurant_detail_object.dart';
import 'package:restaurant_api_app/data/model/restaurant_object.dart';
import 'package:restaurant_api_app/data/model/restaurant_search_object.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';
  Client? client;
  ApiService({this.client}) {
    client ??= Client();
  }

  Future<Restaurant> getRestaurants() async {
    final response = await client!.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantDetails> getDetailRestaurant(String id) async {
    final response = await client!.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearch> getRestaurantbySearch(String query) async {
    final response = await client!.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants by search');
    }
  }
}
