import 'package:mkmlogin/model/LoginRequest.dart';
import 'package:mkmlogin/model/LoginResponse.dart';
import 'package:mkmlogin/model/RegisterRequest.dart';
import 'package:mkmlogin/model/RegisterResponse.dart';
import 'package:mkmlogin/utils/RestDataSource.dart';

abstract class UserContract {
  void onLoginSuccess(LoginResponse response);
  void onLoginFailed(String message);

  void onRegisterSuccess(RegisterResponse response);
  void onRegisterFailed(String message);
}

class UserPresenter {
  UserContract contract;
  RestDataSource rest = new RestDataSource();
  UserPresenter(this.contract);

  login(String username, String password) {
    LoginRequest req = new LoginRequest();
    req.username = username;
    req.password = password;
    req.loginTime = 0;
    rest.login(req).then((LoginResponse response) {
      contract.onLoginSuccess(response);
    }).catchError((Object ex) {
      contract.onLoginFailed(ex.toString());
    });
  }

  register(String username, String password) {
    RegisterRequest req = new RegisterRequest();
    req.username = username;
    req.password = password;
    rest.register(req).then((RegisterResponse response) {
      contract.onRegisterSuccess(response);
    }).catchError((Object ex) {
      contract.onRegisterFailed(ex.toString());
    });
  }
}
