import 'package:flutter/material.dart';
import 'package:router_2_test/models/book.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
      ),
      body: Center(
        child: Text(book.title),
      ),
    );
  }
}
