import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/meal.dart'; // Import the Meal model
import 'package:http/http.dart' as http; // Import HTTP package
import 'dart:convert'; // For decoding JSON

class HomeController extends GetxController {
  var isLoading = true.obs;
  var foodMeals = <Meal>[].obs; // Daftar makanan asli dari API
  var filteredMeals = <Meal>[].obs; // Daftar makanan setelah difilter berdasarkan pencarian

  @override
  void onInit() {
    super.onInit();
    fetchMeals(); // Call fetchMeals() when the controller is initialized
  }

  // Fetch meals data from an actual API
  void fetchMeals() async {
    try {
      isLoading.value = true; // Show loading indicator
      var mealsData = await fetchMealsFromApi(); // Fetch data from API
      foodMeals.value = mealsData.map((mealJson) => Meal.fromJson(mealJson)).toList(); // Convert JSON to Meal objects
      filteredMeals.value = foodMeals; // Set filteredMeals to show all initially
    } catch (e) {
      print('Error fetching meals: $e');
    } finally {
      isLoading.value = false; // Hide loading indicator after data is fetched
    }
  }

  // Actual API call to fetch meals data
  Future<List<Map<String, dynamic>>> fetchMealsFromApi() async {
    const url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef'; // Example URL, can be adjusted based on your API
    final response = await http.get(Uri.parse(url)); // Make GET request to API

    if (response.statusCode == 200) {
      var data = json.decode(response.body); // Decode the response body
      return List<Map<String, dynamic>>.from(data['meals']); // Return the list of meals from the API response
    } else {
      throw Exception('Failed to load meals');
    }
  }

  // Fungsi untuk mencari makanan berdasarkan query
  void searchMeals(String query) {
    if (query.isEmpty) {
      filteredMeals.value = foodMeals; // Jika query kosong, tampilkan semua makanan
    } else {
      filteredMeals.value = foodMeals.where((meal) {
        return meal.strMeal.toLowerCase().contains(query.toLowerCase()) ||
            meal.strCategory.toLowerCase().contains(query.toLowerCase());
      }).toList(); // Filter berdasarkan nama atau kategori
    }
  }
}
