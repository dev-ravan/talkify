part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingStete extends HomeState {}

final class HomeSuccessState extends HomeState {}

final class HomeFailureStete extends HomeActionState {}
