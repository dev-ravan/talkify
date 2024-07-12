import 'package:talkify/utils/exports.dart';
import 'package:toastification/toastification.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // darkTheme: darkMode,
        theme: lightMode,
        home: const LoginPage(),
      ),
    );
  }
}
