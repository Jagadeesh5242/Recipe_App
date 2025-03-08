import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/models/recipe.dart';

class SpoonacularService with ChangeNotifier {
  final String _apiKey = '6d4738c3a0d446e08236c5ce92dbc7a0';
  final String _baseUrl = 'https://api.spoonacular.com/recipes';

  Future<List<Recipe>> fetchTrendingRecipes() async {
    final response = await http.get(Uri.parse('$_baseUrl/random?number=10&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> recipesJson = data['recipes'];
      return recipesJson.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}