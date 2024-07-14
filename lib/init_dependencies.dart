import 'package:talkify/utils/exports.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initAuth();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(userLogin: serviceLocator()),
  );
}
