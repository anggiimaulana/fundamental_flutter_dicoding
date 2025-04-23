import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/favorite_icon_widget.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_app/style/colors/restaurant_color.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final FavoriteIconProvider favoriteIconProvider;

  @override
  void initState() {
    super.initState();
    favoriteIconProvider = FavoriteIconProvider();

    Future.microtask(() {
      context.read<RestaurantDetailProvider>().fetchRestaurantDetail(
        widget.restaurantId,
      );

      favoriteIconProvider.loadRestaurantById(widget.restaurantId);
    });
  }

  @override
  void dispose() {
    favoriteIconProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Restaurant Detail",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: RestaurantColor.blue.color,
        actions: [
          ChangeNotifierProvider.value(
            value: favoriteIconProvider,
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantDetailLoadedState(data: var restaurant) =>
                    FavoriteIconWidget(restaurant: restaurant),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantDetailLoadedState(data: var restaurantDetail) =>
              BodyOfDetailScreenWidget(restaurantDetail: restaurantDetail),
            RestaurantDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
