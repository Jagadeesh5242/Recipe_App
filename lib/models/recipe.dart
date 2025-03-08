class Recipe {
  final String id;
  final String title;
  final int readyInMinutes;
  final String imageUrl;
  final List<String> ingredients;
  final String instructions;

  Recipe({
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'].toString(),
      title: json['title'],
      readyInMinutes: json['readyInMinutes'],
      imageUrl: json['image'],
      ingredients: List<String>.from(json['extendedIngredients'].map((item) => item['original'])),
      instructions: json['instructions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'readyInMinutes': readyInMinutes,
      'image': imageUrl,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}