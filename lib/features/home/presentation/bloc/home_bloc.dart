import 'dart:async';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/features/home/domain/usecase/get_current_user.dart';
import 'package:talkify/features/home/domain/usecase/get_user_list.dart';
import 'package:talkify/utils/exports.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserList _getUserList;
  final GetCurrentUser _getCurrentUser;
  HomeBloc(
      {required GetUserList getUserList,
      required GetCurrentUser GetCurrentUser})
      : _getUserList = getUserList,
        _getCurrentUser = GetCurrentUser,
        super(HomeInitial()) {
    on<HomeInitialEvent>(_homeInitialEvent);
  }

  FutureOr<void> _homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingStete());
    try {
      final userList = await _getUserList.getUserList();
      final user = await _getCurrentUser.getCurrentUser();
      user.fold(
        (l) => emit(HomeFailureStete(l.msg)),
        (user) {
          return userList.fold(
            (l) => emit(HomeSuccessState(const [], user)),
            (userList) => emit(HomeSuccessState(userList, user)),
          );
        },
      );
    } catch (e) {
      emit(HomeFailureStete(e.toString()));
    }
  }
}
