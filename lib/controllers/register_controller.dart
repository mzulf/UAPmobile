import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  // Menyembunyikan / menampilkan password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Menyembunyikan / menampilkan confirm password
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Fungsi untuk register
  void register() {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password dan konfirmasi password tidak sama.',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      // Lakukan proses pendaftaran (misalnya, menggunakan Firebase)
      Get.snackbar('Success', 'Pendaftaran berhasil!',
          snackPosition: SnackPosition.BOTTOM);
      // Alihkan ke halaman login atau halaman utama setelah berhasil
    }
  }
}
