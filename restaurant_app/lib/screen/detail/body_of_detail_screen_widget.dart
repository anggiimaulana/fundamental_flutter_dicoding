import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  final Restaurant restaurant;
  const BodyOfDetailScreenWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Menambahkan border-radius
                  child: Image.network(
                    restaurant.largeImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox.square(dimension: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.pin_drop, color: Colors.redAccent),
                            const SizedBox.square(dimension: 4),
                            Expanded(
                              child: Text(
                                restaurant.city,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox.square(dimension: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description", style: TextTheme.of(context).titleLarge),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox.square(dimension: 16),
              Column(
                children: [
                  Text("Menu", style: TextTheme.of(context).titleLarge),
                  Row(
                    children: [
                      Text("Foods", style: Theme.of(context).textTheme.titleMedium),
                      // Text(restaurant.)
                    ],
                  ),
                ],
              ),
              const SizedBox.square(dimension: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Review", style: TextTheme.of(context).titleLarge),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox.square(dimension: 4),
                          Text(
                            restaurant.rating.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
