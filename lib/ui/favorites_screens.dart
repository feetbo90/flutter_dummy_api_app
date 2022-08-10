import 'package:flutter/material.dart';
import 'package:flutter_logique/data/provider/db/database_provider.dart';
import 'package:flutter_logique/utils/result_state.dart';
import 'package:flutter_logique/widget/card_favorites.dart';
import 'package:provider/provider.dart';

class FavoritesScreens extends StatefulWidget {
  static const routeName = '/favorite_list';
  static const headlineText = "Favorites";

  @override
  State<FavoritesScreens> createState() => _FavoritesScreensState();
}

class _FavoritesScreensState extends State<FavoritesScreens> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.myFavorite.length,
            itemBuilder: (context, index) {
              return CardFavorites(posts: provider.myFavorite[index]);
            },
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Text(provider.message),
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}
