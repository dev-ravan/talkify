import 'dart:developer';

import 'package:talkify/features/home/presentation/bloc/home_bloc.dart';
import 'package:talkify/features/home/presentation/components/home_header.dart';
import 'package:talkify/features/home/presentation/components/user_tile.dart';
import 'package:talkify/init_dependencies.dart';
import 'package:talkify/utils/exports.dart';
import 'package:talkify/utils/toasts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    serviceLocator.get<HomeBloc>().add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          log("First");
          if (state.isLogout) {
            log("2");
            successToastMsg(
                msg: "Logged out successfully..!", context: context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginPage()));
          } else {
            log("3");
            warningToastMsg(msg: "Logged out failed :(", context: context);
          }
        } else if (state is LogoutFailureStete) {
          log("4");
          warningToastMsg(msg: "Logged out failed :(", context: context);
        }
      },
      builder: (context, state) {
        //  [Success]
        if (state is HomeSuccessState) {
          return SafeArea(
              child: Padding(
            padding: p16,
            child: Column(
              children: [
                // Header
                HomeHeader(user: state.user),
                gap32,
                // List of users
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.usersList.length,
                  itemBuilder: (context, index) {
                    return UserTile(
                      user: state.usersList[index],
                    );
                  },
                ),
              ],
            ),
          ));
        }
        // [Error]
        else if (state is HomeFailureStete) {
          return Center(
            child: Text(
              state.error,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        // Loading
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    ));
  }
}
