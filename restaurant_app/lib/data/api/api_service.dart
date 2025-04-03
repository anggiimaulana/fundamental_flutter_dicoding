import 'dart:convert';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/restaurant_search_response.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResponse> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant search');
    }
  }

  Future<List<CustomerReview>> getRestaurantReview(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<CustomerReview>.from(
        data["restaurant"]["customerReviews"].map(
          (x) => CustomerReview.fromJson(x),
        ),
      );
    } else {
      throw Exception('Failed to load restaurant reviews');
    }
  }

  Future<List<CustomerReview>> addReview(
    String id,
    String name,
    String review,
  ) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id, "name": name, "review": review}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<CustomerReview>.from(
        data["customerReviews"].map((x) => CustomerReview.fromJson(x)),
      );
    } else {
      throw Exception('Failed to add review');
    }
  }
}
