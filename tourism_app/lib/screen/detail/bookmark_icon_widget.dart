import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/tourism.dart';
import 'package:tourism_app/provider/bookmark/local_database_provider.dart';
import 'package:tourism_app/provider/detail/bookmark_icon_provider.dart';

class BookmarkIconWidget extends StatefulWidget {
  final Tourism tourism;
  const BookmarkIconWidget({super.key, required this.tourism});

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
      await localDatabaseProvider.loadTourismById(widget.tourism.id);

      if (localDatabaseProvider.tourism != null) {
        final value = localDatabaseProvider.checkItemBookmark(
          widget.tourism.id,
        );
        bookmarkIconProvider.isBookmarked = value;
      } else {
        bookmarkIconProvider.isBookmarked = false;
      }

      // final value = localDatabaseProvider.checkItemBookmark(widget.tourism.id);
      // bookmarkIconProvider.isBookmarked = value;
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
            localDatabaseProvider.saveTourism(widget.tourism);
          } else {
            localDatabaseProvider.removeTourismById(widget.tourism.id);
          }
          bookmarkIconProvider.isBookmarked = !isBookmarked;
          localDatabaseProvider.loadlAllTourism();
        });
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
