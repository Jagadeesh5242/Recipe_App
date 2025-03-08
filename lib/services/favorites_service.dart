import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe/models/recipe.dart';

class FavoritesService with ChangeNotifier {
  List<Recipe> _favorites = [];

  List<Recipe> get favorites => _favorites;

  FavoritesService() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoritesJson = prefs.getStringList('favorites');
    if (favoritesJson != null) {
      _favorites = favoritesJson.map((json) => Recipe.fromJson(jsonDecode(json))).toList();
      notifyListeners();
    }
  }

  Future<void> addFavorite(Recipe recipe) async {
    _favorites.add(recipe);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> removeFavorite(Recipe recipe) async {
    _favorites.removeWhere((item) => item.id == recipe.id);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoritesJson = _favorites.map((recipe) => jsonEncode(recipe.toJson())).toList();
    await prefs.setStringList('favorites', favoritesJson);
  }
}