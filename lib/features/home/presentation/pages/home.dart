import 'package:talkify/features/home/presentation/components/home_header.dart';
import 'package:talkify/features/home/presentation/components/user_tile.dart';
import 'package:talkify/utils/exports.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: Padding(
      padding: p16,
      child: Column(
        children: [
          // Header
          HomeHeader(),
          gap32,
          // List of users
          UserTile()
        ],
      ),
    )));
  }
}
