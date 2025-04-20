import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/bookmark/local_database_provider.dart';
import 'package:restaurant_app/provider/detail/bookmark_icon_provider.dart';

class BookmarkIconWidget extends StatefulWidget {
  final Restaurant restaurant;
  const BookmarkIconWidget({super.key, required this.restaurant});

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  @override
  void initState() {
    super.initState();
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantById(widget.restaurant.id);

      if (localDatabaseProvider.restaurant != null) {
        final value = localDatabaseProvider.checkItemBookmark(
          widget.restaurant.id,
        );
        bookmarkIconProvider.isBookmarked = value;
      } else {
        bookmarkIconProvider.isBookmarked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          final localDatabaseProvider = context.read<LocalDatabaseProvider>();
          final bookmarkIconProvider = context.read<BookmarkIconProvider>();
          final isBookmarked = bookmarkIconProvider.isBookmarked;

          if (!isBookmarked) {
            localDatabaseProvider.saveRestaurant(widget.restaurant);
          } else {
            localDatabaseProvider.removeRestaurantById(widget.restaurant.id);
          }

          bookmarkIconProvider.isBookmarked = !isBookmarked;
          localDatabaseProvider.loadAllRestaurant();
        });
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_border,
      ),
    );
  }
}
