import 'package:flutter/material.dart';
import 'package:router_2_test/models/book.dart';
import 'package:router_2_test/navigation/book_route_path.dart';
import 'package:router_2_test/screens/screens.dart';

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  BookRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _navigatorKey;

  Book? _selectedBook;
  bool show404 = false;

  List<Book> books = [
    Book(title: 'Left Hand of Darkness', author: 'Ursula K. Le Guin'),
    Book(title: 'Too Like the Lightning', author: 'Ada Palmer'),
    Book(title: 'Kindred', author: 'Octavia E. Butler'),
  ];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          key: ValueKey('BooksListPage'),
          child: BooksListScreen(
            books: books,
            onTapped: _handleBookTapped,
          ),
        ),
        if (show404)
          MaterialPage(
            key: ValueKey('UnknownScreen'),
            child: UnknownScreen(),
          )
        else if (_selectedBook != null)
          MaterialPage(
            key: ValueKey('BookDetailPage'),
            child: BookDetailScreen(
              book: _selectedBook!,
            ),
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        show404 = false;
        _selectedBook = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    if (path.isUnknown) {
      _selectedBook = null;
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (path.id! < 0 || path.id! > books.length - 1) {
        show404 = true;
        return;
      }

      _selectedBook = books[path.id!];
    } else {
      _selectedBook = null;
    }

    show404 = false;
  }

  BookRoutePath get currentConfiguration {
    if (show404) {
      return BookRoutePath.unknown();
    }

    return _selectedBook == null
        ? BookRoutePath.home()
        : BookRoutePath.details(id: books.indexOf(_selectedBook!));
  }

  void _handleBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }
}
