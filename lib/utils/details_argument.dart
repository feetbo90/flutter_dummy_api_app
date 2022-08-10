import 'package:flutter_logique/data/provider/posts/posts_id_provider.dart';

class DetailsArgument {
  DetailsArgument({ required this.id, required this.provider });
  final String id;
  final PostsIdProvider provider;
}