import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences s_prefs;

saveAbout(about) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-about", about);
}

savePropertyItem(cartItems) async {
  s_prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(cartItems);
  s_prefs.setString("l-propItem", jsonString);
}

savePropertyName(name) async {
  s_prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(name);
  s_prefs.setString("l-nameItem", jsonString);
}

saveName(name) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-name", name);
}

saveUserState(ustate) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-userstate", ustate);
}

saveSurname(surname) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-surname", surname);
}

saveCreatedAt(tm) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-created", tm);
}

savePhone(cred) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-phone", cred);
}

saveUser(user) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-user", user);
}

showUser() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-user");

  return temp;
}

showSelfie() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-selfie");

  return temp;
}

showCreated() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-created");

  return temp;
}

saveSelfie(ustate) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-selfie", ustate);
}

saveEmail(email) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-email", email);
}

saveWSSVerify(status) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setBool("l-verify", status);
}

saveToken(tk) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-token", tk);
}

setSecured(secured) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setBool("l-secured", secured);
}

saveId(id) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setString("l-id", id);
}

//SHOW SAVE DATA
showUsername() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-username");

  return temp;
}

showRef() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-oken");

  return temp;
}

showWSSVerify() async {
  s_prefs = await SharedPreferences.getInstance();

  bool? temp = s_prefs.getBool("l-verify");

  return temp;
}

showEmail() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-email");

  return temp;
}

showId() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-id");

  return temp;
}

showPropertyItem() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-propItem");

  return temp;
}

showPropertyNameItem() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-nameItem");

  return temp;
}

showToken() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-token");

  return temp;
}

showName() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-name");

  return temp;
}

showAbout() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-about");

  return temp;
}

showPhone() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-phone");

  return temp;
}

showState() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-userstate");

  return temp;
}

showCity() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-city");

  return temp;
}

showSurname() async {
  s_prefs = await SharedPreferences.getInstance();

  String? temp = s_prefs.getString("l-surname");

  return temp;
}

isSecured() async {
  s_prefs = await SharedPreferences.getInstance();

  bool? temp = s_prefs.getBool("l-secured");

  return temp;
}

clear() async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.clear();
}

//end BNB wallet

//Polywallet

saveNotify(Poly) async {
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setInt("l-Poly", Poly);
}

saveOnce(once) async {
  print(once);
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setInt("l-Once", once);
}

saveWssConnect(once) async {
  print(once);
  s_prefs = await SharedPreferences.getInstance();
  s_prefs.setBool("l-active", once);
}

showOnce() async {
  s_prefs = await SharedPreferences.getInstance();

  int? temp = s_prefs.getInt("l-Once");

  temp ??= 0;
  print(temp);
  return temp;
}

showWssConnect() async {
  s_prefs = await SharedPreferences.getInstance();

  bool? temp = s_prefs.getBool("l-active");

  temp ??= false;
  print(temp);
  return temp;
}

showNotify() async {
  s_prefs = await SharedPreferences.getInstance();

  int? temp = s_prefs.getInt("l-Poly");

  return temp;
}

class Storage {


  static Future<dynamic> getAlreadyAUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool('l-alreadyAUser');
    return value;
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', 123);
  }

  static Future oneTime<int>() async {
    var once = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('l-intValue', once);
    if (once == 0) {
      prefs.setInt('l-intValue', once);
    } else {
      return once;
    }
  }


}
