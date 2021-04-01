import 'package:flutter/material.dart';
import 'package:m_whm/components/button_block.dart';
import 'package:m_whm/components/layout.dart';
import 'package:m_whm/components/textfield.dart';
import 'package:m_whm/components/title_login.dart';
import 'package:m_whm/const/color.dart';

enum PassType { newPass, confPass }

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool obscure1 = true;
  bool obscure2 = true;

  void show(PassType pass) {
    setState(() {
      pass == PassType.newPass ? obscure1 = !obscure1 : obscure2 = !obscure2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
        imageUrl: "assets/images/img_forgot_password.png",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleLogin(
              title: 'Reset Password',
              subtitle:
                  'Please enter the new password that you will use for your account.',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KTextField(
                  obscure: obscure1,
                  label: "New Password",
                  placeholder: "Enter your new password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: BaseColors.primary,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      show(PassType.newPass);
                    },
                    icon: obscure1
                        ? Image.asset('assets/icons/ic_eye_hide.png',
                            height: 25, width: 25)
                        : Image.asset('assets/icons/ic_show_password.png',
                            height: 25, width: 25),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                KTextField(
                  obscure: obscure2,
                  label: "Confirm Password",
                  placeholder: "Confirm your password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: BaseColors.primary,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      show(PassType.confPass);
                    },
                    icon: obscure2
                        ? Image.asset('assets/icons/ic_eye_hide.png',
                            height: 25, width: 25)
                        : Image.asset('assets/icons/ic_show_password.png',
                            height: 25, width: 25),
                  ),
                ),
              ],
            ),
            ButtonBlock(
              onPress: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (Route<dynamic> route) => false),
              text: 'CONFIRM',
            )
          ],
        ),
      ),
    );
  }
}
