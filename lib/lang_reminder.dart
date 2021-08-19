import 'package:shared_preferences/shared_preferences.dart';
import 'package:translutter/lang.dart';

class LangReminder {
  static final _sourceLangKey = 'sourceLangCode';
  static final _targetLangKey = 'targetLangCode';

  static Future<Lang> getSourceLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sourceLangCode = prefs.getString(_sourceLangKey);
    if (sourceLangCode == null) sourceLangCode = '';
    return LangRegister.sourceLangs
        .firstWhere((Lang l) => l.code == sourceLangCode);
  }

  static void setSourceLang(Lang sourceLang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_sourceLangKey, sourceLang.code);
  }

  static Future<Lang> getTargetLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? targetLangCode = prefs.getString(_targetLangKey);
    if (targetLangCode == null) targetLangCode = 'EN';
    return LangRegister.targetLangs
        .firstWhere((Lang l) => l.code == targetLangCode);
  }

  static void setTargetLang(Lang targetLang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_targetLangKey, targetLang.code);
  }
}
