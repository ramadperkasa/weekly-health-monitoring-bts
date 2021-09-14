import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/widgets/button_block.dart';
import 'package:m_whm/widgets/layout.dart';
import 'package:m_whm/widgets/textfield.dart';
import 'package:m_whm/widgets/title_login.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  bool obscure = true;
  bool loading = false;
  String email;
  String password;

  void show() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Layout(
            isAppBar: false,
            imageUrl: "assets/images/img_login.png",
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleLogin(
                  title: 'Welcome',
                  subtitle: 'Please Sign in to fill out the form.',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KTextField(
                      keyboardType: TextInputType.emailAddress,
                      label: "Email",
                      placeholder: "Enter your email",
                      onChanged: (val) {
                        email = val;
                      },
                      prefixIcon: Image.asset('assets/icons/ic_email.png',
                          height: 25, width: 25),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    KTextField(
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (val) {
                        password = val;
                      },
                      obscure: obscure,
                      label: "Password",
                      placeholder: "Enter your password",
                      prefixIcon: Image.asset('assets/icons/ic_padlock.png',
                          height: 25, width: 25),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            show();
                          });
                        },
                        icon: obscure
                            ? Image.asset('assets/icons/ic_eye_hide.png',
                                height: 25, width: 25)
                            : Image.asset('assets/icons/ic_show_password.png',
                                height: 25, width: 25),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/password/forgot');
                      },
                      child: Text(
                        'Forgot Password ? ',
                        style: TextStyle(color: BaseColors.accent),
                      ),
                    ))
                  ],
                ),
                ButtonBlock(
                  onPress: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (newUser != null) {
                        Navigator.pushReplacementNamed(context, '/');
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Username / Password Salah'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      setState(() {
                        loading = false;
                      });
                    } catch (e) {
                      setState(() {
                        loading = false;
                      });
                      final snackBar = SnackBar(
                        content: Text('Username / Password Salah'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  text: 'SIGN IN',
                )
              ],
            ),
          ),
          loading
              ? Container(
                  color: Colors.white.withOpacity(0.6),
                  child: SpinKitFoldingCube(
                    color: BaseColors.primary.withOpacity(0.3),
                    size: 75.0,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
