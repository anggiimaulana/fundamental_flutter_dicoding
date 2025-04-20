import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/bookmark/local_database_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/colors/restaurant_color.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurant();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Bookmark List",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: Colors.white),
        ),
        backgroundColor: RestaurantColor.blue.color,
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final bookmarkList = value.restaurantList ?? [];
          return switch (bookmarkList.isNotEmpty) {
            true => ListView.builder(
              itemCount: bookmarkList.length,
              itemBuilder: (context, index) {
                final restaurant = bookmarkList[index];
                return RestaurantCardWidget(
                  restaurant: restaurant,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: restaurant.id,
                    );
                  },
                );
              },
            ),
            _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("No Bookmarked")],
              ),
            ),
          };
        },
      ),
    );
  }
}
