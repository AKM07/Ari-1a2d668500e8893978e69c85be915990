import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mkmlogin/model/RegisterResponse.dart';
import 'package:mkmlogin/model/LoginResponse.dart';
import 'package:mkmlogin/pages/RegisterPage.dart';
import 'package:mkmlogin/presenters/UserPresenter.dart';
import 'package:mkmlogin/utils/PreferencesUtil.dart';
import 'package:mkmlogin/utils/injector.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> implements UserContract {
  BuildContext buildContext;
  bool isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final PreferencesUtil util = locator<PreferencesUtil>();

  double defaultFontSize = 14;
  double defaultIconSize = 17;

  UserPresenter presenter;

  LoginPageState() {
    presenter = UserPresenter(this);
  }

  String email, password;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  void submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() => isLoading = true);
      form.save();

      presenter.login(email, password);
    }
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void onLoginFailed(String message) {
    setState(() => isLoading = false);
  }

  @override
  void onLoginSuccess(LoginResponse response) {
    setState(() => isLoading = false);
    util.putString(PreferencesUtil.username, response.username);
  }

  @override
  void onRegisterFailed(String message) {}

  @override
  void onRegisterSuccess(RegisterResponse response) {}
  @override
  Widget build(BuildContext context) {
    final loginButton = new Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(17.0),
        onPressed: submit,
        child: Text(
          "Masuk",
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
            width: double.infinity,
            height: double.infinity,
            color: Colors.white70,
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
                Flexible(
                  flex: 5,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          showCursor: true,
                          onSaved: (val) => email = val,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            return val.length > 0
                                ? null
                                : "Username tidak boleh kosong.";
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
                              FeatherIcons.mail,
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
                            return val.length > 0
                                ? null
                                : "Password tidak boleh kosong.";
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
                              fontSize: defaultFontSize,
                            ),
                            hintText: "Kata Sandi",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Lupa Password?",
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: defaultFontSize,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        isLoading
                            ? new CircularProgressIndicator()
                            : loginButton,
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
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
                            "Tidak mempunyai akun? ",
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: defaultFontSize,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            )
                          },
                          child: Container(
                            child: Text(
                              "Daftar",
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
    );
  }
}
