import 'package:talkify/features/authentication/domain/usecase/google_login.dart';
import 'package:talkify/features/authentication/domain/usecase/user_logout.dart';
import 'package:talkify/features/authentication/domain/usecase/user_register.dart';
import 'package:talkify/features/home/data/datasources/home_remote_data_source.dart';
import 'package:talkify/features/home/data/repositories/home_repo_impl.dart';
import 'package:talkify/features/home/domain/repositories/home_repo.dart';
import 'package:talkify/features/home/domain/usecase/create_chat_room.dart';
import 'package:talkify/features/home/domain/usecase/get_chat_messages.dart';
import 'package:talkify/features/home/domain/usecase/get_current_user.dart';
import 'package:talkify/features/home/domain/usecase/get_user_list.dart';
import 'package:talkify/features/home/domain/usecase/send_message.dart';
import 'package:talkify/features/home/presentation/bloc/home_bloc.dart';
import 'package:talkify/utils/exports.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initAuth();
  _homeInit();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

// Authentication
void _initAuth() {
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => UserRegister(serviceLocator()));
  serviceLocator.registerFactory(() => UserGoogleLogin(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogout(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
        userLogin: serviceLocator(),
        userRegister: serviceLocator(),
        userGoogleLogin: serviceLocator()),
  );
}

// Home
void _homeInit() {
  serviceLocator
      .registerFactory<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());

  serviceLocator.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator()));

  serviceLocator.registerFactory(() => GetUserList(serviceLocator()));
  serviceLocator.registerFactory(() => GetCurrentUser(serviceLocator()));
  serviceLocator.registerFactory(() => CreateChatRoom(serviceLocator()));
  serviceLocator.registerFactory(() => SendMessage(serviceLocator()));
  serviceLocator.registerFactory(() => GetChatMessages(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => HomeBloc(
        getUserList: serviceLocator(),
        getCurrentUser: serviceLocator(),
        userLogout: serviceLocator(),
        createChatRoom: serviceLocator(),
        sendMessage: serviceLocator(),
        getChatMessages: serviceLocator()),
  );
}
