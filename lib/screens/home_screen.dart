import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/services/spoonacular_service.dart';
import 'package:recipe/models/recipe.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spoonacularService = Provider.of<SpoonacularService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Finder'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: spoonacularService.fetchTrendingRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recipes found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return ListTile(
                  title: Text(recipe.title),
                  subtitle: Text('Ready in ${recipe.readyInMinutes} minutes'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(recipe: recipe),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}