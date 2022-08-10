import 'package:flutter/material.dart';
import 'package:flutter_logique/components/search_widget_home.dart';
import 'package:flutter_logique/data/model/response/friend/friend.dart';
import 'package:flutter_logique/data/provider/db/db_friend_provider.dart';
import 'package:flutter_logique/data/provider/posts/posts_id_provider.dart';
import 'package:flutter_logique/data/provider/users/users_id_provider.dart';
import 'package:flutter_logique/utils/date_time_helper.dart';
import 'package:flutter_logique/utils/details_argument.dart';
import 'package:flutter_logique/utils/result_state.dart';
import 'package:flutter_logique/widget/card_post.dart';
import 'package:provider/provider.dart';

class DetailsScreens extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  const DetailsScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailsArgument;

    UsersIdProvider myProvider =
        Provider.of<UsersIdProvider>(context, listen: false);
    myProvider.fetchUsersById(args.id);

    PostsIdProvider myPostProvider =
        Provider.of<PostsIdProvider>(context, listen: false);
    args.provider.fetchPostsById(args.id, 1);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: SafeArea(
            child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SearchWidgetHome(provider: myPostProvider))),
      ),
      body: Column(
        children: [
          Consumer<UsersIdProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightGreen,
                            image: DecorationImage(
                                image: NetworkImage(state.result.picture),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Consumer<DbFriendProvider>(
                            builder: (context, provider, child) {
                          return FutureBuilder<bool>(
                              future: provider.isFriend(args.id),
                              builder: (context, snapshot) {
                                var isFriend = snapshot.data ?? false;
                                return Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: isFriend
                                        ? IconButton(
                                            icon: const Icon(Icons.person),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            onPressed: () =>
                                                provider.removeFriend(args.id),
                                          )
                                        : IconButton(
                                            icon: const Icon(
                                                Icons.person_add_rounded),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            onPressed: () => provider.addFriend(
                                                Friend(
                                                    id: args.id,
                                                    name: state
                                                        .result.firstName)),
                                          ));
                              });
                        }),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Text("Gender : ${state.result.gender}"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                          "Date : ${DateTimeHelper.format(state.result.dateOfBirth)}"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                          "Join from : ${DateTimeHelper.myTime(state.result.updatedDate)}"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.email,
                            size: 15,
                          ),
                          Text(state.result.email),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_balance_outlined,
                            size: 15,
                          ),
                          Text(state.result.location.street),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: const Text("Posts"),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("No Internet connection"),
                );
              }
            },
          ),
          Expanded(
            child: Consumer<PostsIdProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.hasData) {
                  return ListView.builder(
                    itemCount:
                        state.datumResults.length + (state.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index ==
                          state.datumResults.length - state.nextPageThreshold) {
                        state.fetchPostsById(args.id, 0);
                      }
                      return CardPosts(posts: state.datumResults[index]);
                    },
                  );
                } else {
                  return Center(
                    child: Text(state.message),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
