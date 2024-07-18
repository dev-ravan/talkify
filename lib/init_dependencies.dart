import 'package:talkify/features/authentication/domain/usecase/google_login.dart';
import 'package:talkify/features/authentication/domain/usecase/user_register.dart';
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
  serviceLocator.registerFactory(
    () => UserRegister(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserGoogleLogin(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
        userLogin: serviceLocator(),
        userRegister: serviceLocator(),
        userGoogleLogin: serviceLocator()),
  );
}
