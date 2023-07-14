library futhinos.globals;

import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
const String mainCollection = 'hinos_v2';
const String baseUrl =
    "https://firebasestorage.googleapis.com/v0/b/futhinos-522ad.appspot.com/o/";
const String baseUrlDownload = "?dl=1";

Future<void> initiateSharedPreferences() async {
  prefs = await SharedPreferences.getInstance();
}
