import 'package:flutter/material.dart';
import 'package:m_whm/state/account.dart';
import 'package:provider/provider.dart';

String getData(BuildContext context, key, {isProv = true}) {
  if (!isProv) {
    var provWithoutListen = Provider.of<AccountData>(context, listen: false);
    provWithoutListen.getAccount(key);

    return provWithoutListen.account[key];
  } else {
    var prov = Provider.of<AccountData>(context);
    prov.getAccount(key);

    return prov.account[key];
  }
}

Future<String> getDataAsync(BuildContext context, key, {isProv = true}) async {
  if (!isProv) {
    var provWithoutListen = Provider.of<AccountData>(context, listen: false);
    provWithoutListen.getAccount(key);

    return provWithoutListen.account[key];
  } else {
    var prov = Provider.of<AccountData>(context);
    prov.getAccount(key);

    return prov.account[key];
  }
}

String getTempImage(BuildContext context, {isProv = true}) {
  if (!isProv) {
    var provWithoutListen = Provider.of<AccountData>(context, listen: false);

    return provWithoutListen.urlTempLocal != null
        ? provWithoutListen.urlTempLocal
        : provWithoutListen.urlTemp;
  } else {
    var prov = Provider.of<AccountData>(context);

    return prov.urlTempLocal != null ? prov.urlTempLocal : prov.urlTemp;
  }
}
