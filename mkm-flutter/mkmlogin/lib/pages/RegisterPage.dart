import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mkmlogin/model/RegisterResponse.dart';
import 'package:mkmlogin/model/LoginResponse.dart';
import 'package:mkmlogin/presenters/UserPresenter.dart';
import 'package:mkmlogin/utils/PreferencesUtil.dart';
import 'package:mkmlogin/utils/injector.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> implements UserContract {
  double defaultFontSize = 14;
  double defaultIconSize = 17;

  String username, password, passwordConfirmation;
  bool obscureText = true;
  bool obscureConfirmText = true;
  String obscureWidget = "";

  UserPresenter presenter;

  BuildContext buildContext;
  bool isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final PreferencesUtil util = locator<PreferencesUtil>();
  RegisterPageState() {
    presenter = new UserPresenter(this);
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void toggleConfirmation() {
    setState(() {
      obscureConfirmText = !obscureConfirmText;
    });
  }

  void submit() {
    final form = formKey.currentState;
    debugPrint("validate and input" + form.validate().toString());
    if (form.validate()) {
      setState(() => isLoading = true);
      form.save();

      presenter.register(username, password);
    }
  }

  void showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  void onLoginFailed(String message) {}

  @override
  void onLoginSuccess(LoginResponse response) {}

  @override
  void onRegisterFailed(String message) {
    showSnackBar(message);
    setState(() => isLoading = false);
  }

  @override
  void onRegisterSuccess(RegisterResponse response) {
    setState(() => isLoading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final registerButton = Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(17.0),
        onPressed: submit,
        child: Text(
          "Daftar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        color: Color(0xFF6d4c41),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
            side: BorderSide(color: Color(0xFF6d4c41))),
      ),
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
    );

    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
              width: double.infinity,
              height: double.infinity,
              color: Colors.white70,
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        child: Container(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(Icons.close),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          showCursor: true,
                          onSaved: (val) => username = val,
                          validator: (val) {
                            String validate = "";
                            if (val.length <= 0) {
                              validate = "Username tidak boleh kosong";
                            } else if (val.length < 3) {
                              validate =
                                  "Username harus memiliki minimal 3 karakter.";
                            } else {
                              validate = null;
                            }
                            return validate;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              FeatherIcons.user,
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: defaultFontSize),
                            hintText: "Username",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          showCursor: true,
                          onSaved: (val) => password = val,
                          obscureText: obscureText,
                          validator: (val) {
                            String validate = "";
                            if (val.length <= 0) {
                              validate = "Kata Sandi tidak boleh kosong";
                            } else if (val.length < 5) {
                              validate =
                                  "Kata Sandi harus memiliki minimal 5 karakter.";
                            } else {
                              validate = null;
                            }
                            return validate;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              FeatherIcons.lock,
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: toggle,
                              child: Icon(
                                obscureText
                                    ? FeatherIcons.eyeOff
                                    : FeatherIcons.eye,
                                color: Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: defaultFontSize),
                            hintText: "Kata Sandi",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          showCursor: true,
                          obscureText: obscureText,
                          onSaved: (val) => passwordConfirmation = val,
                          validator: (val) {
                            String validate = "";
                            if (val.length <= 0) {
                              validate =
                                  "Konfirmasi Kata Sandi tidak boleh kosong";
                            } else {
                              validate = null;
                            }
                            return validate;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              FeatherIcons.lock,
                              color: Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: toggleConfirmation,
                              child: Icon(
                                obscureConfirmText
                                    ? FeatherIcons.eyeOff
                                    : FeatherIcons.eye,
                                color: Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                            ),
                            fillColor: Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: defaultFontSize),
                            hintText: "Konfirmasi Kata Sandi",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        isLoading
                            ? new CircularProgressIndicator()
                            : registerButton,
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Flexible(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Sudah mempunyai akun? ",
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: defaultFontSize,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: Text(
                                  "Masuk",
                                  style: TextStyle(
                                    color: Color(0xFF6d4c41),
                                    fontSize: defaultFontSize,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
