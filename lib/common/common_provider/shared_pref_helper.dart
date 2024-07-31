import 'package:home_challenger_for_flutter/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<String> setTheme(String theme) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('theme', theme);
    return theme;
  }

  static Future<String> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('theme') ?? 'theme';
  }

  static Future<String> setColor(String color) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('color', color);
    return color;
  }

  static Future<String> getColor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('color') ?? 'color';
  }

  static Future<void> saveHistoryTime(List<HistoryModel> historyList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> jsonList = historyList.map((item) => item.toJson()).toList();
    await preferences.setStringList('time', jsonList);
  }

  static Future<List<HistoryModel>> getHistoryTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> jsonList = preferences.getStringList('time') ?? [];
    return jsonList.map((item) => HistoryModel.fromJson(item)).toList();
  }

  static Future<void> saveHistoryList(List<HistoryModel> historyList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> jsonList = historyList.map((item) => item.toJson()).toList();
    await preferences.setStringList('history_list', jsonList);
  }

  static Future<List<HistoryModel>> getHistoryList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> jsonList = preferences.getStringList('history_list') ?? [];
    return jsonList.map((item) => HistoryModel.fromJson(item)).toList();
  }

  // clear all data
  static Future<void> clearAllData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
