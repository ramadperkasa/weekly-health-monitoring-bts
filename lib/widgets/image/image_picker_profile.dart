import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_whm/state/account.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:m_whm/widgets/image/show_image.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerProfile extends StatefulWidget {
  @override
  _ImagePickerProfileState createState() => _ImagePickerProfileState();
}

class _ImagePickerProfileState extends State<ImagePickerProfile> {
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  PickedFile imagePicked;

  uploadFile(PickedFile file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));
      return null;
    }

    var fileName = (file.path.split('/').last);

    firebase_storage.UploadTask uploadTask;

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    uploadTask = ref.putFile(File(file.path), metadata);

    Provider.of<AccountData>(context, listen: false).setUrlTemp('');

    await uploadTask.whenComplete(() async {
      var url = await uploadTask.snapshot.ref.getDownloadURL();

      Provider.of<AccountData>(context, listen: false).setUrlTemp(url);

      if (Provider.of<AccountData>(context, listen: false).isEdited) {
        Provider.of<AccountData>(context, listen: false)
            .setAccount('image', url);
      }

      // Provider.of<AccountData>(context, listen: false)
      //     .setAccount('url', 'true');
      // Provider.of<AccountData>(context, listen: false).setAccount('image', url);
    });

    return Future.value(uploadTask);
  }

  void _onImageButtonPressed({BuildContext context}) async {
    await _displayPickImageDialog(context, (double maxWidth, double maxHeight,
        int quality, ImageSource source) async {
      try {
        final PickedFile pickedFile = await _picker.getImage(
          source: source,
          maxWidth: 350,
          maxHeight: 350,
          imageQuality: 90,
        );

        final File toFile = File(pickedFile.path);

        final appDir = await getApplicationDocumentsDirectory();

        imageCache.clear();
        var fileName = pickedFile.path.split('/').last;

        final savedImage = await toFile.copy('${appDir.path}/$fileName');

        setState(() {
          // imageProvider = FileImage(File(savedImage.path));
          Provider.of<AccountData>(context, listen: false)
              .setUrlLocalTemp(savedImage.path);
          // print(savedImage.path);
          imagePicked = pickedFile;
        });

        await uploadFile(pickedFile);
      } catch (e) {}
    });
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        print(response.file);
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    double width;
    double height;
    int quality;
    ImageSource source = ImageSource.camera;

    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Camera'),
                    onTap: () {
                      source = ImageSource.camera;
                      onPick(width, height, quality, source);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Galery'),
                  onTap: () {
                    source = ImageSource.gallery;
                    onPick(width, height, quality, source);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget _previewImage() {
      final Text retrieveError = _getRetrieveErrorWidget();
      if (retrieveError != null) {
        return retrieveError;
      }

      return showImageProfile(context);
    }

    return GestureDetector(
      onTap: () {
        _onImageButtonPressed(
          context: context,
        );
      },
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
                child: Container(
                  width: 70,
                  height: 70,
                  child:
                      !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                          ? FutureBuilder<void>(
                              future: retrieveLostData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Text('Loading...');
                                  case ConnectionState.done:
                                    return _previewImage();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text(
                                        'Pick image/video error: ${snapshot.error}}',
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return Text('Loading...');
                                    }
                                }
                              },
                            )
                          : (_previewImage()),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(100.0),
              ),
              child: Container(
                width: 70,
                height: 70,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    height: 25,
                    width: 70,
                    child: Center(
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality, ImageSource source);
