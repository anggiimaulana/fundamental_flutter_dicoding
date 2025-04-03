import 'dart:convert';

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}

class AddReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  AddReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory AddReviewResponse.fromJson(String source) =>
      AddReviewResponse.fromMap(json.decode(source));

  factory AddReviewResponse.fromMap(Map<String, dynamic> json) =>
      AddReviewResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
          json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
        ),
      );

  Map<String, dynamic> toMap() => {
    "error": error,
    "message": message,
    "customerReviews": List<dynamic>.from(
      customerReviews.map((x) => x.toJson()),
    ),
  };

  String toJson() => json.encode(toMap());
}
