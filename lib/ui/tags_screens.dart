import 'package:flutter/material.dart';
import 'package:flutter_logique/components/custom_appbar.dart';
import 'package:flutter_logique/data/provider/tag/tag_post_provider.dart';
import 'package:flutter_logique/utils/result_state.dart';
import 'package:flutter_logique/widget/card_post.dart';
import 'package:provider/provider.dart';

class TagsScreens extends StatefulWidget {
  static const routeName = '/tags_screens';
  static const headlineText = "Favorites";

  String query;
  TagsScreens({Key? key, required this.query}) : super(key: key);

  @override
  State<TagsScreens> createState() => _TagsScreensState();
}

class _TagsScreensState extends State<TagsScreens> {
  @override
  Widget build(BuildContext context) {
    TagsPostProvider myProvider =
    Provider.of<TagsPostProvider>(context, listen: false);
    myProvider.fetchTagPosts(widget.query, 1);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: const CustomAppBar(),
      ),
      body: Consumer<TagsPostProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.datumResults.length + (provider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.datumResults.length - provider.nextPageThreshold) {
                  provider.fetchTagPosts(widget.query,0);
                }
                return CardPosts(posts: provider.datumResults[index]);
              },
            );
          } else if (provider.state == ResultState.noData) {
            return const Center(
              child: Text("Empty Data"),
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
