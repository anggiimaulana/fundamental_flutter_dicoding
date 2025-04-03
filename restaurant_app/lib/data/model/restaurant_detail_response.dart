import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/category.dart';
import 'package:restaurant_app/data/model/menus.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailResponse {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant.toJson(),
  };
}

class RestaurantDetail extends Restaurant {
  final String address;
  final List<Category> categories;
  final Menus menus;
  final List<CustomerReview> customerReviews;

  RestaurantDetail({
    required super.id,
    required super.name,
    required super.description,
    required super.pictureId,
    required super.city,
    required super.rating,
    required this.address,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      pictureId: json["pictureId"] ?? "",
      city: json["city"] ?? "",
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      address: json["address"] ?? "",
      categories:
          (json["categories"] as List<dynamic>?)
              ?.map((x) => Category.fromJson(x))
              .toList() ??
          [],
      menus: Menus.fromJson(json["menus"] ?? {}),
      customerReviews:
          (json["customerReviews"] as List<dynamic>?)
              ?.map((x) => CustomerReview.fromJson(x))
              .toList() ??
          [],
    );
  }
}
