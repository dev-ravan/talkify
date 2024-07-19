import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkify/app/app.dart';
import 'package:talkify/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkify/features/home/presentation/bloc/home_bloc.dart';
import 'package:talkify/init_dependencies.dart';

void main() async {
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
  ], child: const MainApp()));
}
