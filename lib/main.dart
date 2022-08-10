import 'package:flutter/material.dart';
import 'package:flutter_logique/common/navigation.dart';
import 'package:flutter_logique/data/api/api_services.dart';
import 'package:flutter_logique/data/database/db_friend_helper.dart';
import 'package:flutter_logique/data/provider/db/database_provider.dart';
import 'package:flutter_logique/data/provider/db/db_friend_provider.dart';
import 'package:flutter_logique/data/provider/posts/posts_id_provider.dart';
import 'package:flutter_logique/data/provider/posts/posts_provider.dart';
import 'package:flutter_logique/data/provider/tag/tag_post_provider.dart';
import 'package:flutter_logique/data/provider/users/users_id_provider.dart';
import 'package:flutter_logique/data/provider/users/users_provider.dart';
import 'package:flutter_logique/ui/home_screens.dart';
import 'package:flutter_logique/ui/splash_screens.dart';
import 'package:flutter_logique/ui/tags_screens.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'data/database/database_helper.dart';
import 'ui/details_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UsersProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider(
          create: (_) => UsersIdProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider(
          create: (_) => PostsProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider(
          create: (_) => PostsIdProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider(
          create: (_) => TagsPostProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => DbFriendProvider(databaseHelper: DbFriendHelper()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Users App',
        navigatorKey: navigatorKey,
        initialRoute: SplashScreenPage.routeName,
        routes: {
          SplashScreenPage.routeName: (context) => const SplashScreenPage(),
          HomeScreens.routeName: (context) => const HomeScreens(),
          DetailsScreens.routeName: (context) => const DetailsScreens(),
          TagsScreens.routeName: (context) => TagsScreens(
                query: ModalRoute.of(context)?.settings.arguments as String,
              ),
        },
      ),
    );
  }
}
