// import 'package:flutter/material.dart';
// import 'package:recipe/models/recipe.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:html/parser.dart' show parse;

// class RecipeDetailScreen extends StatelessWidget {
//   final Recipe recipe;

//   RecipeDetailScreen({required this.recipe});

//   String stripHtmlTags(String htmlString) {
//     final document = parse(htmlString);
//     return document.body?.text ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(recipe.title),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: () {
//               Share.share('Check out this recipe: ${recipe.title}');
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//   recipe.imageUrl,
//   errorBuilder: (context, error, stackTrace) {
//     return Center(child: Text('Image failed to load.'));
//   },
//   loadingBuilder: (context, child, loadingProgress) {
//     if (loadingProgress == null) return child;
//     return Center(
//       child: CircularProgressIndicator(
//         value: loadingProgress.expectedTotalBytes != null
//             ? loadingProgress.cumulativeBytesLoaded /
//                 (loadingProgress.expectedTotalBytes ?? 1)
//             : null,
//       ),
//     );
//   },
// )
// ,
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 recipe.title,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Ready in ${recipe.readyInMinutes} minutes'),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Ingredients:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(recipe.ingredients.join(', ')),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Instructions:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(stripHtmlTags(recipe.instructions)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//modifed verison

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/models/recipe.dart';
import 'package:share_plus/share_plus.dart';
import 'package:html/parser.dart' show parse;
import 'dart:typed_data';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  String stripHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }
// Replace the _fetchImageBytes method with this:
Future<Uint8List?> _fetchImageBytes(String url) async {
  try {
    // Option 1: Your own proxy server


// Option 2: Different public proxy
final proxyUrl = 'https://api.allorigins.win/raw?url=${Uri.encodeFull(url)}';

    final response = await http.get(Uri.parse(proxyUrl));
    return response.bodyBytes;
  } catch (e) {
    print("Image load error: $e");
    return null;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share('Check out this recipe: ${recipe.title}');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Uint8List?>(
              future: _fetchImageBytes(recipe.imageUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return Center(child: Text('Image failed to load.'));
                }
 return Image.memory(
  snapshot.data!,
  fit: BoxFit.fitWidth,  // <-- Stretch width but keep height as max as image
  width: double.infinity, // <-- Take full width of screen
);


              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Ready in ${recipe.readyInMinutes} minutes'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ingredients:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(recipe.ingredients.join(', ')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Instructions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(stripHtmlTags(recipe.instructions)),
            ),
          ],
        ),
      ),
    );
  }
}
