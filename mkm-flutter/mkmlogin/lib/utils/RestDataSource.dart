import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mkmlogin/model/LoginRequest.dart';
import 'package:mkmlogin/model/LoginResponse.dart';
import 'package:mkmlogin/model/RegisterRequest.dart';
import 'package:mkmlogin/model/RegisterResponse.dart';
import 'package:mkmlogin/utils/UrlsUtil.dart';

import 'NetworkUtil.dart';
import 'PreferencesUtil.dart';
import 'injector.dart';

class RestDataSource {
  NetworkUtil networkUtil = new NetworkUtil();
  final PreferencesUtil util = locator<PreferencesUtil>();

  Future<LoginResponse> login(LoginRequest request) {
    print("UrlsUtil.LOGIN_URL " + UrlsUtil.LOGIN_URL);
    return networkUtil.post(UrlsUtil.LOGIN_URL, body: {
      "username": request.username,
      "password": request.password,
      "loginTime": request.loginTime
    }).then((dynamic res) {
      print("Result : " + res.toString());
      return LoginResponse.fromJson(res);
    }).catchError((Object ex) {
      print(ex.toString());
    });
  }

  Future<RegisterResponse> register(RegisterRequest request) {
    return networkUtil.post(UrlsUtil.REGISTER_URL, body: {
      "username": request.username,
      "password": request.password,
    }).then((dynamic res) {
      return RegisterResponse.fromJson(res);
    });
  }
}
