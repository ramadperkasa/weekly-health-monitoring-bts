import 'dart:io';

import 'package:flutter/material.dart';
import 'package:m_whm/widgets/futureBuilder.dart';

Widget showImageProfile(context) {
  if (getTempImage(context).split('/').first == 'http:' ||
      getTempImage(context).split('/').first == 'https:') {
    return Image.network(
      getTempImage(context),
      fit: BoxFit.cover,
      scale: 1,
      width: 70,
      height: 70,
    );
  } else if (getTempImage(context).split('/').first == 'assets') {
    return Image.asset(
      getTempImage(context),
      fit: BoxFit.cover,
      scale: 1,
      width: 70,
      height: 70,
    );
  } else {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          scale: 1,
          image: FileImage(
            File(
              getTempImage(context),
            ),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
