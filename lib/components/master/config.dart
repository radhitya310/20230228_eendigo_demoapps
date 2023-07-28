import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static SharedPreferences? _prefs = null;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get livenessUrl =>
      _prefs?.getString('livenessUrl') ?? 'https://api.example.com';
  static set livenessUrl(String value) =>
      _prefs?.setString('livenessUrl', value);

  static String get livenessKey =>
      _prefs?.getString('livenessKey') ?? 'your-api-key';
  static set livenessKey(String value) =>
      _prefs?.setString('livenessKey', value);

  static int get livenessTimeout => _prefs?.getInt('livenessTimeout') ?? 5000;
  static set livenessTimeout(int value) =>
      _prefs?.setInt('livenessTimeout', value);

  static String get tenantCode =>
      _prefs?.getString('tenantCode') ?? 'tenant-code';
  static set tenantCode(String value) =>
      _prefs?.setString('tenantCode', value);

  static String get apiKey =>
      _prefs?.getString('apiKey') ?? 'your-api-key';
  static set apiKey(String value) =>
      _prefs?.setString('apiKey', value);
}
