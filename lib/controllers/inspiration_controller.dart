import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../models/meal.dart';
import '../services/api_service.dart';

class InspirationController extends GetxController {
  var isConnected = true.obs;
  var meals = <Meal>[].obs;
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _checkConnection();
    _fetchRandomMeals(); // Fetch meals saat awal
  }

  // Mengecek koneksi internet secara berkala
  void _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;

    // Listen perubahan koneksi
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
    });
  }

  // Fetch meals dari API jika ada koneksi internet
  Future<void> _fetchRandomMeals() async {
    if (!isConnected.value) {
      Get.snackbar(
        'No Internet Connection',
        'Unable to fetch meals. Please check your internet connection.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      var fetchedMeals = await ApiService.getRandomMeals(5); // Fetch 5 random meals
      meals.assignAll(fetchedMeals);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch meals: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Untuk fitur search
  Future<void> searchMeals(String query) async {
    if (!isConnected.value) {
      Get.snackbar(
        'No Internet Connection',
        'Unable to search meals. Please check your internet connection.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      var searchedMeals = await ApiService.searchMeals(query);
      meals.assignAll(searchedMeals);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to search meals: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
