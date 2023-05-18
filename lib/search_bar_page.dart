
import 'package:flutter/material.dart';
import 'package:untitled1/platform_selector.dart';

import 'constants.dart';


class SearchBarPage extends StatefulWidget {
  const SearchBarPage({Key? key, required this.onChangedPlatform}) : super(key: key);
  final PlatformCallback onChangedPlatform;
  static const String route = 'search-bar';
  static const String title = 'Search bar';
  static const String subtitle =
      'The copy button copies but also shows a menu.';
  static const String url = '$kCodeUrl/search_bar_page.dart';
  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {





  int _selectedIndex = 0;

  List<NavigationRailDestination> _navigationRailDestination = [
    NavigationRailDestination(
      icon: Icon(Icons.favorite_border),
      selectedIcon: Icon(Icons.favorite),
      label: Text('First Menu'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.bookmark_border),
      selectedIcon: Icon(Icons.book),
      label: Text('Second Menu'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.star_border),
      selectedIcon: Icon(Icons.star),
      label: Text('Third Menu'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: _navigationRailDestination,
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child:_SearchBar(),
            ),
          )
        ],
      ),
    );
  }
}


class _SearchBar extends StatefulWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final SearchController searchController = SearchController();
  var searchBarTheme = SearchBarThemeData(
      backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
);

  SearchViewThemeData searchViewTheme = const SearchViewThemeData(
    constraints:
    BoxConstraints(minWidth: 360.0, minHeight: 140.0, maxHeight: 300.0),
  );
  @override
  Widget build(BuildContext context) {
    return SearchBarTheme(
      data: searchBarTheme,
      child: SearchViewTheme(
        data: searchViewTheme,
        child: SearchAnchor.bar(
          barHintText: 'Search',
          searchController: searchController,
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {

            if (controller.text.isNotEmpty) {

            }
            return [SizedBox.shrink()];
          },
        ),
      ),
    );
  }
}
