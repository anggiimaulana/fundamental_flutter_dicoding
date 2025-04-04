import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';

class MenuWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;
  const MenuWidget({super.key, required this.restaurantDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Menu", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox.square(dimension: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Foods", style: Theme.of(context).textTheme.titleMedium),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        restaurantDetail.menus.foods.map((food) {
                          return Text(
                            "• ${food.name}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Drinks",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        restaurantDetail.menus.drinks.map((drink) {
                          return Text(
                            "• ${drink.name}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
