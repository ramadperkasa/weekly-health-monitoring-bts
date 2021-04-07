import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/components/button_block.dart';
import 'package:m_whm/components/layout.dart';
import 'package:m_whm/components/textfield.dart';
import 'package:m_whm/components/title_login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;

  bool error = false;
  String errorText;

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
                        onChanged: (val) {
                          email = val;
                        },
                        error: error,
                        errorText: errorText,
                        keyboardType: TextInputType.emailAddress,
                        label: "Email",
                        placeholder: "Enter your email",
                        prefixIcon: Image.asset(
                          'assets/icons/ic_email.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ],
                  ),
                  ButtonBlock(
                    onPress: () async {
                      if (email != null) {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: email,
                          );

                          showAlertDialog(context);
                        } catch (e) {
                          print(e);
                          final snackBar = SnackBar(
                            content: Text(
                              'Terjadi Kesalahan',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        setState(() {
                          error = true;
                          errorText = 'Email Harus Diisi';
                        });
                      }
                    },
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

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Berhasil !"),
      content: Text(
        "Silahkan cek email anda untuk melanjutkan proses reset password.",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
          child: Text('Close'),
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
