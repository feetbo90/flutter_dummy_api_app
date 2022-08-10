import 'package:flutter/material.dart';
import 'package:flutter_logique/components/custom_appbar.dart';
import 'package:flutter_logique/data/provider/users/users_provider.dart';
import 'package:flutter_logique/utils/result_state.dart';
import 'package:flutter_logique/widget/card_users.dart';
import 'package:provider/provider.dart';

class HomeScreensList extends StatefulWidget {
  static const routeName = '/home_list';

  const HomeScreensList({Key? key}) : super(key: key);

  @override
  State<HomeScreensList> createState() => _HomeScreensListState();
}

class _HomeScreensListState extends State<HomeScreensList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: const CustomAppBar(),
      ),
      body: Consumer<UsersProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.datumResults.length + (provider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.datumResults.length - provider.nextPageThreshold) {
                  provider.fetchUsers();
                }
                return CardUsers(users: provider.datumResults[index]);
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
