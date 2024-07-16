import 'package:talkify/utils/exports.dart';
import 'package:talkify/utils/sizes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logout",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            gap12,
            InkWell(onTap: () {}, child: const Icon(Icons.logout_outlined))
          ],
        ),
      ),
    );
  }
}
