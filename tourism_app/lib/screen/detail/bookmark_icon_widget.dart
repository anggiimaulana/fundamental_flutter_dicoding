import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/tourism.dart';
import 'package:tourism_app/provider/detail/bookmark_icon_provider.dart';
import 'package:tourism_app/provider/detail/bookmark_list_provider.dart';

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
    final bookmarkListProvider = context.read<BookmarkListProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() {
      final tourismInList = bookmarkListProvider.checkItemBookmark(
        widget.tourism,
      );
      bookmarkIconProvider.isBookmarked = tourismInList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          final bookmarkListProvider = context.read<BookmarkListProvider>();
          final bookmarkIconProvider = context.read<BookmarkIconProvider>();
          final isBookmarked = bookmarkIconProvider.isBookmarked;

          if (!isBookmarked) {
            bookmarkListProvider.addBookmark(widget.tourism);
          } else {
            bookmarkListProvider.removeBookmark(widget.tourism);
          }
          bookmarkIconProvider.isBookmarked = !isBookmarked;
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
