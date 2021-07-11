import 'package:flutter/material.dart';
import 'package:router_2_test/navigation/book_route_path.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    // handle '/'
    if (uri.pathSegments.length == 0) {
      return BookRoutePath.home();
    }

    // handle '/books'
    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0].toLowerCase() == 'books') {
        return BookRoutePath.home();
      }
    }

    // handle '/books/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') return BookRoutePath.unknown();

      final remaining = uri.pathSegments[1];
      final id = int.tryParse(remaining);

      if (id == null) return BookRoutePath.unknown();

      return BookRoutePath.details(id: id);
    }

    // Handle unknown routes
    return BookRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(BookRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/book/${path.id}');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    return null;
  }
}
