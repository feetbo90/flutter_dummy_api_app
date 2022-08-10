import 'package:flutter/material.dart';
import 'package:flutter_logique/data/model/response/posts/my_post.dart';
import 'package:flutter_logique/data/provider/db/database_provider.dart';
import 'package:flutter_logique/ui/favorites_screens.dart';
import 'package:provider/provider.dart';

class CardFavorites extends StatelessWidget {
  final MyPost posts;

  const CardFavorites({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(posts.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            var myPost = posts.owner.split("#");
            return Material(
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: posts.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      posts.image,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myPost[1],
                          style: const TextStyle(
                              fontFamily: 'Oxygen',
                              fontSize: 13,
                              color: Colors.lightBlue),
                        ),
                      ],
                    ),
                    Text(
                      posts.text,
                      style: const TextStyle(
                          fontFamily: 'Oxygen',
                          fontSize: 13,
                          color: Colors.black54),
                    ),
                  ],
                ),
                subtitle: Text(
                  "${posts.likes} likes",
                  style: const TextStyle(
                      fontFamily: 'Oxygen',
                      fontSize: 12,
                      color: Colors.black54),
                ),
                trailing: isBookmarked
                    ? IconButton(
                  icon: const Icon(Icons.thumb_up),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () => provider.removeFavorite(posts.id),
                )
                    : IconButton(
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () => provider.addFavoritesTwo(posts),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, FavoritesScreens.routeName,
                        arguments: posts),
              ),
            );
          },
        );
      },
    );
  }
}
