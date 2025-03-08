import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/services/spoonacular_service.dart';
import 'package:recipe/services/favorites_service.dart';
import 'package:recipe/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SpoonacularService()),
        ChangeNotifierProvider(create: (context) => FavoritesService()),
      ],
      child: MaterialApp(
        title: 'Recipe Finder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}