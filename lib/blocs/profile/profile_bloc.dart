import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../models/user_model.dart';
import '../../repositories/user/user_repository.dart';
import '../auth/auth_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;
  StreamSubscription? _authSubscription;

  ProfileBloc({
    required AuthBloc authBloc,
    required UserRepository userRepository,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);

    // Listen to AuthBloc state changes
    _authSubscription = _authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated) {
        add(LoadProfile(state.authUser));
      } else {
        add(LoadProfile(null)); // Trigger unauthenticated state
      }
    });
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    if (event.authUser != null) {
      // Fetch user profile from repository
      _userRepository.getUser(event.authUser!.uid).listen((user) {
        if (user != null) {
          add(UpdateProfile(user));
        } else {
          emit(ProfileUnauthenticated());
        }
      });
    } else {
      emit(ProfileUnauthenticated());
    }
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) {
    emit(ProfileLoaded(user: event.user));
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
