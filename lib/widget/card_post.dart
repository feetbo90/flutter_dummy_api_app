import 'package:flutter/material.dart';
import 'package:flutter_logique/data/provider/db/database_provider.dart';
import 'package:flutter_logique/ui/favorites_screens.dart';
import 'package:flutter_logique/utils/date_time_helper.dart';
import 'package:provider/provider.dart';

import '../data/model/response/posts/posts.dart';

class CardPosts extends StatelessWidget {
  final Datum posts;

  const CardPosts({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(posts.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
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
                          posts.owner.firstName,
                          style: const TextStyle(
                              fontFamily: 'Oxygen',
                              fontSize: 13,
                              color: Colors.lightBlue),
                        ),
                        Text(
                          DateTimeHelper.format(posts.publishDate),
                          style: const TextStyle(
                              fontFamily: 'Oxygen',
                              fontSize: 13,
                              color: Colors.lightBlueAccent),
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
                    SizedBox(
                      height: 15,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: posts.tags.map((url) {
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 2.0, 0.0),
                                child: SizedBox(
                                  width: 50,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                    ),
                                    child: Text(url,
                                        style: const TextStyle(fontSize: 8,color: Colors.black54)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "${posts.likes}",
                      style: const TextStyle(
                          fontFamily: 'Oxygen',
                          fontSize: 12,
                          color: Colors.redAccent),
                    ),
                    const Text(
                      " likes",
                      style: TextStyle(
                          fontFamily: 'Oxygen',
                          fontSize: 12,
                          color: Colors.black54),
                    ),
                  ],
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
                  onPressed: () => provider.addFavorites(posts),
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
