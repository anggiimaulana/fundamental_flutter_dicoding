import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/style/colors/restaurant_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Restaurants", style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
                Text("Recommendation restaurant for your!", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
              ],
            ),
            backgroundColor: RestaurantColor.blue.color,
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantListLoadedState(data: var tourismList) =>
              ListView.builder(
                itemCount: tourismList.length,
                itemBuilder: (context, index) {
                  final tourism = tourismList[index];

                  return RestaurantCardWidget(
                    restaurant: tourism,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: tourism.id,
                      );
                    },
                  );
                },
              ),
            RestaurantListErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
