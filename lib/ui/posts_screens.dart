import 'package:flutter/material.dart';
import 'package:flutter_logique/components/custom_appbar.dart';
import 'package:flutter_logique/data/provider/posts/posts_provider.dart';
import 'package:flutter_logique/utils/result_state.dart';
import 'package:flutter_logique/widget/posts_card.dart';
import 'package:provider/provider.dart';

class PostsScreens extends StatefulWidget {
  static const routeName = '/favorite_list';
  static const headlineText = "Posts";

  @override
  State<PostsScreens> createState() => _PostsScreensState();
}

class _PostsScreensState extends State<PostsScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: const CustomAppBar(),
      ),
      body: Consumer<PostsProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.datumResults.length + (provider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.datumResults.length - provider.nextPageThreshold) {
                  provider.fetchPosts();
                }
                return PostsCard(posts: provider.datumResults[index]);
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
      ),
    );
  }
}
