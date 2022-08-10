import 'package:flutter/material.dart';
import 'package:flutter_logique/data/model/response/users/users.dart';
import 'package:flutter_logique/data/provider/posts/posts_id_provider.dart';
import 'package:flutter_logique/data/provider/users/users_provider.dart';
import 'package:flutter_logique/ui/details_screens.dart';
import 'package:flutter_logique/utils/details_argument.dart';
import 'package:provider/provider.dart';

class CardUsers extends StatelessWidget {
  final Datum users;

  const CardUsers({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostsIdProvider myPostProvider =
    Provider.of<PostsIdProvider>(context, listen: false);

    return Consumer<UsersProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          builder: (context, snapshot) {
            return Material(
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: users.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      users.picture,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  users.title,
                  style: const TextStyle(
                      fontFamily: 'Oxygen',
                      fontSize: 14,
                      color: Colors.black54),
                ),
                subtitle: Text(
                  "${users.firstName} ${users.lastName}",
                  style: const TextStyle(
                      fontFamily: 'Oxygen',
                      fontSize: 12,
                      color: Colors.black54),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, DetailsScreens.routeName,
                        arguments: DetailsArgument(id: users.id, provider: myPostProvider)),
              ),
            );
          },
        );
      },
    );
  }
}
