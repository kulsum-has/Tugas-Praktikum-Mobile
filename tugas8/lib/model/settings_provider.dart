import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _temaMode = ThemeMode.light;
  String _username = "Pengguna Anonim"; 

  ThemeMode get temaMode => _temaMode;
  bool get modeGelap => _temaMode == ThemeMode.dark;
  String get username => _username; 

  static const String key_theme = "theme_key";
  static const String key_username = "username_key"; 
  SettingsProvider() {
    loadSettings();
  }

  void loadSettings() async {
    final koneksi = await SharedPreferences.getInstance();
    
    final gelap = koneksi.getBool(key_theme) ?? false;
    _temaMode = gelap ? ThemeMode.dark : ThemeMode.light;

    _username = koneksi.getString(key_username) ?? "Pengguna Anonim"; 
    
    notifyListeners();
  }

  void setTema(bool aktif) async {
    _temaMode = aktif ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final koneksi = await SharedPreferences.getInstance();
    koneksi.setBool(key_theme, aktif);
  }

  void setUsername(String name) async {
    if (name.trim().isEmpty) {
      _username = "Pengguna Anonim";
    } else {
      _username = name;
    }
    notifyListeners();

    final koneksi = await SharedPreferences.getInstance();
    koneksi.setString(key_username, _username);
  }
}