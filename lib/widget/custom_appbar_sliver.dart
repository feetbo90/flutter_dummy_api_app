import 'package:flutter/material.dart';
import 'package:flutter_logique/components/header_title.dart';
import 'package:flutter_logique/components/search_widget_home.dart';
import 'package:flutter_logique/data/provider/posts/posts_id_provider.dart';

class CustomAppbarSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final PostsIdProvider provider;

  CustomAppbarSliver({required this.expandedHeight, required this.provider});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        const HeaderTitle(),
        Positioned(
          bottom: -1,
          left: 16,
          right: 16,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: SearchWidgetHome(provider: provider)
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
