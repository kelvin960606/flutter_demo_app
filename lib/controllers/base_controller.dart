import 'package:flutter_demo_app/constants/enum.dart';
import 'package:get/state_manager.dart';

class BaseController extends GetxController {
  final Rx<ViewState> _state = ViewState.idle.obs;
  final Rx<AuthState> _authState = AuthState.uninitialized.obs;

  bool get isBusy => _state.value == ViewState.busy;

  bool get isIdle => _state.value == ViewState.idle;

  bool get isError => _state.value == ViewState.error;

  bool get isSubmitBusy => _state.value == ViewState.busy;

  bool get isAuthenticated => _authState.value == AuthState.authenticated;

  bool get isUnauthenticated => _authState.value == AuthState.unauthenticated;

  bool get isUninitialized => _authState.value == AuthState.uninitialized;

  bool get isAuthenticating => _authState.value == AuthState.authenticating;

  ViewState get state => _state.value;

  AuthState get authState => _authState.value;

  void setBusy() {
    _setViewState(ViewState.busy);
  }

  void setIdle() {
    _setViewState(ViewState.idle);
  }

  void setError() {
    _setViewState(ViewState.error);
  }

  void setAuthenticated() => _setAuthState(AuthState.authenticated);

  void setAuthenticating() => _setAuthState(AuthState.authenticating);

  void setUninitialized() => _setAuthState(AuthState.uninitialized);

  void setUnauthenticated() => _setAuthState(AuthState.unauthenticated);

  void setOnSplashInitiated() => _setAuthState(AuthState.onSplashInitiated);

  void _setAuthState(AuthState newState) {
    _authState.value = newState;
  }

  void _setViewState(ViewState newState) {
    _state.value = newState;
  }
}
