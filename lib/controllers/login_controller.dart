import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Controller untuk email dan password
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Observable untuk mengatur visibilitas password
  var isPasswordHidden = true.obs;

  // Fungsi untuk toggle visibilitas password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Fungsi login
  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    // Validasi sederhana
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password wajib diisi!",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      // Logika login (contoh navigasi ke halaman dashboard)
      Get.toNamed('/dashboard');
    }
  }

  // Fungsi login menggunakan Google
  void loginWithGoogle() {
    // Implementasi login Google
    Get.snackbar("Google Login", "Login dengan Google berhasil!",
        snackPosition: SnackPosition.BOTTOM);
  }

  // Fungsi login menggunakan Facebook
  void loginWithFacebook() {
    // Implementasi login Facebook
    Get.snackbar("Facebook Login", "Login dengan Facebook berhasil!",
        snackPosition: SnackPosition.BOTTOM);
  }

  // Navigasi ke halaman daftar
  void goToRegister() {
    Get.toNamed('/register'); // Pastikan Anda sudah mendaftarkan rute ini
  }
}
