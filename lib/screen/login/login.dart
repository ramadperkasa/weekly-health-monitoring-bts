import 'package:flutter/material.dart';
import 'package:m_whm/components/button_block.dart';
import 'package:m_whm/components/layout.dart';
import 'package:m_whm/components/textfield.dart';
import 'package:m_whm/components/title_login.dart';
import 'package:m_whm/const/color.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscure = true;

  @override
  void initState() {
    super.initState();
  }

  void show() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
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
                  label: "Email",
                  placeholder: "Enter your email",
                  prefixIcon: Image.asset('assets/icons/ic_email.png',
                      height: 25, width: 25),
                ),
                SizedBox(
                  height: 24.0,
                ),
                KTextField(
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
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: Text(
                    'Forgot Password ? ',
                    style: TextStyle(color: BaseColors.accent),
                  ),
                ))
              ],
            ),
            ButtonBlock(
              onPress: () => Navigator.pushReplacementNamed(context, '/'),
              text: 'SIGN IN',
            )
          ],
        ),
      ),
    );
  }
}
