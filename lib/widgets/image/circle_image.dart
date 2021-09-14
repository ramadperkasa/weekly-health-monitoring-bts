import 'dart:io';

import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/widgets/futureBuilder.dart';

class KCircleImage extends StatelessWidget {
  KCircleImage({this.width = 70, this.height = 70});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: getDataAsync(context, 'image'),
          builder: (context, snapshot) {
            return FutureBuilder(
              future: getDataAsync(context, 'image_local'),
              builder: (context, snapshotLocal) {
                if (snapshot.hasData || snapshotLocal.hasData) {
                  return Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: snapshot.data.split('/').first == 'http:' ||
                                snapshot.data.split('/').first == 'https:'
                            ? NetworkImage(
                                snapshot.data,
                                scale: 1,
                              )
                            : snapshot.data.split('/').first == 'assets'
                                ? AssetImage(
                                    snapshot.data,
                                  )
                                : FileImage(
                                    File(
                                      snapshotLocal.data,
                                    ),
                                  ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(BaseColors.primary),
                  );
                }
              },
            );
          },
        )
      ],
    );
  }
}
