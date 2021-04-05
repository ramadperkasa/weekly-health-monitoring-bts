import 'package:flutter/material.dart';
import 'package:m_whm/components/button_block.dart';
import 'package:m_whm/components/layout.dart';
import 'package:m_whm/components/textfield.dart';
import 'package:m_whm/components/title_login.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Layout(
            imageUrl: "assets/images/img_forgot_password.png",
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleLogin(
                    title: 'Forgot Password',
                    subtitle:
                        'Enter the email associated with your account and we’ll send an email with instruction to reset your password.',
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KTextField(
                        keyboardType: TextInputType.emailAddress,
                        label: "Email",
                        placeholder: "Enter your email",
                        prefixIcon: Image.asset('assets/icons/ic_email.png',
                            height: 25, width: 25),
                      ),
                    ],
                  ),
                  ButtonBlock(
                    onPress: () =>
                        Navigator.pushNamed(context, '/reset-password'),
                    text: 'SEND',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
