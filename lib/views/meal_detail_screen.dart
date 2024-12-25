import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MealDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan argumen meal yang diteruskan
    final meal = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.strMeal), // Menampilkan nama resep
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(meal.strMealThumb), // Menampilkan gambar resep
            SizedBox(height: 10),
            Text(
              'Resep: ${meal.strMeal}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              meal.strInstructions, // Menampilkan instruksi resep
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
