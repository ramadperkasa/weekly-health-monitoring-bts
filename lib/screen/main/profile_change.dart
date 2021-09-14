import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/state/account.dart';
import 'package:m_whm/widgets/futureBuilder.dart';
import 'package:m_whm/widgets/image/image_picker_profile.dart';

import 'package:m_whm/widgets/layout.dart';
import 'package:m_whm/widgets/rowWithSpaceBeetween.dart';
import 'package:m_whm/widgets/textfield.dart';
import 'package:provider/provider.dart';

class ProfileChange extends StatefulWidget {
  @override
  _ProfileChangeState createState() => _ProfileChangeState();
}

class _ProfileChangeState extends State<ProfileChange> {
  final double ratioHeight = 1.13;

  final TextStyle kTextValueStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );

  Map<String, TextEditingController> form = {
    'name': TextEditingController(),
    'position': TextEditingController(),
    'nik': TextEditingController(),
    'email': TextEditingController(),
    'phone_number': TextEditingController(),
    'gender': TextEditingController(),
  };

  List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem(
      child: Text('Male'),
      value: 'L',
    ),
    DropdownMenuItem(
      child: Text('Female'),
      value: 'P',
    ),
  ];

  @override
  void initState() {
    setData();
    setLocalData();

    Provider.of<AccountData>(context, listen: false).setIsEdited(false);

    super.initState();
  }

  setLocalData() async {
    Provider.of<AccountData>(context, listen: false).setUrlTemp(
      await Provider.of<AccountData>(context, listen: false)
          .getAccount('image'),
    );

    Provider.of<AccountData>(context, listen: false).setUrlLocalTemp(
      await Provider.of<AccountData>(context, listen: false)
          .getAccount('image_local'),
    );
  }

  setData() {
    form.forEach((key, value) {
      form[key].text = getData(context, key, isProv: false);
    });
  }

  saveChanges() {
    form.forEach((key, value) {
      Provider.of<AccountData>(context, listen: false)
          .setAccount(key, value.text);
    });

    Provider.of<AccountData>(context, listen: false).setAccount(
        'image', Provider.of<AccountData>(context, listen: false).urlTemp);

    Provider.of<AccountData>(context, listen: false).setAccount('image_local',
        Provider.of<AccountData>(context, listen: false).urlTempLocal);

    Provider.of<AccountData>(context, listen: false).setIsEdited(true);
  }

  showPreventDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text('Are you sure wan\'t to back to previous page?'),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: BaseColors.primary,
                ),
              ),
            ),
            SizedBox(
              width: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/profile',
                    );
                  },
                  child: Text(
                    'Back ',
                    style: TextStyle(
                      color: BaseColors.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await saveChanges();
                    Navigator.pushNamed(
                      context,
                      '/profile',
                    );
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      color: BaseColors.primary,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AccountData providerAccount = Provider.of<AccountData>(context);

    return WillPopScope(
      onWillPop: () async => showPreventDialog(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Layout(
          enabledPadding: false,
          isDrawer: false,
          ratioHeight: ratioHeight,
          title: Text('Change Profile'),
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/ic_arrow_left.png',
              height: 25,
              width: 25,
            ),
            onPressed: () {
              showPreventDialog(context);
            },
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () async {
                  await saveChanges();

                  Navigator.pushNamed(
                    context,
                    '/profile',
                  );
                }),
          ],
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: ImagePickerProfile(),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: RowWithSpaceBetween(
                            image: Icon(
                              Icons.account_circle_rounded,
                              color: BaseColors.primary,
                            ),
                            title: 'Name',
                            value: Container(
                              width: 155,
                              height: 20,
                              child: TextField(
                                controller: form['name'],
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  isCollapsed: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: RowWithSpaceBetween(
                            image: Icon(
                              Icons.badge,
                              color: BaseColors.primary,
                            ),
                            title: 'Position',
                            value: Container(
                              width: 155,
                              height: 20,
                              child: TextField(
                                controller: form['position'],
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Position',
                                  isCollapsed: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 8.0,
                          width: double.infinity,
                          color: Color(0xFFF3F3F3),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 18.0,
                              ),
                              RowWithSpaceBetween(
                                image: Image.asset(
                                  'assets/icons/ic_identity.png',
                                  height: 25,
                                  width: 25,
                                ),
                                title: 'NIK',
                                value: Container(
                                  width: 155,
                                  child: TextField(
                                    controller: form['nik'],
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'NIK',
                                      isCollapsed: true,
                                    ),
                                  ),
                                ),
                              ),
                              RowWithSpaceBetween(
                                onPress: () {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Email tidak bisa diubah',
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                image: Image.asset('assets/icons/ic_email.png',
                                    height: 25, width: 25),
                                title: 'Email',
                                value: Container(
                                  width: 155.0,
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0),
                                      labelText:
                                          providerAccount.getCurrentEmail(),
                                      isCollapsed: true,
                                    ),
                                  ),
                                ),
                              ),
                              RowWithSpaceBetween(
                                image: Image.asset(
                                    'assets/icons/ic_telephone.png',
                                    height: 25,
                                    width: 25),
                                title: 'Phone Number : ',
                                value: Container(
                                  width: 155.0,
                                  child: TextField(
                                    controller: form['phone_number'],
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0),
                                      isCollapsed: true,
                                    ),
                                  ),
                                ),
                              ),
                              RowWithSpaceBetween(
                                image: Image.asset('assets/icons/ic_gender.png',
                                    height: 25, width: 25),
                                title: 'Gender',
                                value: DropdownButton<String>(
                                  isDense: true,
                                  value: form['gender'].text,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      form['gender'].text = newValue;
                                    });
                                  },
                                  items: dropdownItems,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 8.0,
                          width: double.infinity,
                          color: Color(0xFFF3F3F3),
                        ),
                        Container(
                          padding: EdgeInsets.all(18.0),
                          child: RowWithSpaceBetween(
                            image: Image.asset('assets/icons/ic_padlock.png',
                                height: 25, width: 25),
                            title: 'Password',
                            value: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/password/reset');
                              },
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: BaseColors.accent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(
    {BuildContext context, keyboardType, label, placeholder, value, key}) {
  var controller = TextEditingController();
  controller.text = value;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KTextField(
                keyboardType: keyboardType,
                label: label,
                placeholder: placeholder,
                controller: controller,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<AccountData>(context, listen: false)
                  .setAccount(key, controller.text);
              Navigator.of(context).pop();
            },
            child: Text(
              'Submit',
              style: TextStyle(
                color: BaseColors.primary,
              ),
            ),
          ),
        ],
      );
    },
  );
}
