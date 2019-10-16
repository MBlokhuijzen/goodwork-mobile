import 'package:flutter_test/flutter_test.dart';
import 'package:goodwork/blocs/auth/auth_bloc.dart';
import 'package:goodwork/blocs/auth/auth_state.dart';
import 'package:goodwork/repositories/auth_repository.dart';
import 'package:goodwork/blocs/auth/auth_event.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  final AuthBloc authBloc = AuthBloc(authRepository);

  test('Initial state', () {
    expect(authBloc.initialState, InitialAuthState());
  });

  test('BaseUrl Loaded', () {
    final List<AuthState> expectedResponse = [
      InitialAuthState(),
      const BaseUrlSet(urlSet: true)
    ];

    expectLater(authBloc.state, emitsInOrder(expectedResponse));

    authBloc.dispatch(BaseUrlLoaded());
  });

  test('Access Token Loaded And User Not Found', () {
    final List<AuthState> expectedResponse = [
      InitialAuthState(),
      UserLoading(),
      UserNotFound()
    ];

    expectLater(authBloc.state, emitsInOrder(expectedResponse));

    authBloc.dispatch(AccessTokenLoaded());
  });
}
