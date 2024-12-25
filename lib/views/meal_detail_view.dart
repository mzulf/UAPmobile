import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/meal.dart';

class MealDetailView extends StatelessWidget {
  final Meal meal;

  MealDetailView({required this.meal});

  @override
  Widget build(BuildContext context) {
    // Menambahkan kontrol observasi untuk status loading
    var isDataLoaded = false.obs;

    // Jika data sudah ada, beri waktu untuk loading data
    Future.delayed(Duration(seconds: 1), () {
      isDataLoaded.value = true; // Simulasi loading data selesai
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.strMeal),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Meal
            Image.network(
              meal.strMealThumb,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, size: 200),
            ),
            SizedBox(height: 20),
            // Nama Meal
            Text(
              meal.strMeal,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Menampilkan kategori dan area setelah data berhasil dimuat
            Obx(() {
              if (!isDataLoaded.value) {
                return Container(); // Mengosongkan jika data belum dimuat
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category: ${meal.strCategory}'),
                  Text('Area: ${meal.strArea}'),
                ],
              );
            }),
            SizedBox(height: 20),
            // Instruksi, menampilkan setelah data dimuat
            Obx(() {
              if (!isDataLoaded.value) {
                return Container(); // Mengosongkan jika data belum dimuat
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    meal.strInstructions,
                    textAlign: TextAlign.justify,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
