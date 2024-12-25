import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ikon untuk kembali
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
        ),
        backgroundColor: Colors.transparent, // AppBar transparan
        elevation: 0, // Menghilangkan shadow dari AppBar
      ),
      body: Container(
        color: Color(0xFFFFF8E1), // Warna latar belakang
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 80),
                // Gambar lingkaran di atas
                ClipOval(
                  child: Container(
                    color: Colors.white,
                    width: 180,
                    height: 180,
                    child: Image.asset(
                      'assets/login_image.png', // Ganti dengan gambar Anda
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Input Email
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                // Input Password dengan fitur show/hide
                Obx(() {
                  return TextField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(controller.isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  );
                }),
                SizedBox(height: 20),
                // Tombol Login
                ElevatedButton(
                  onPressed: () {
                    // Langsung ke halaman dashboard tanpa menunggu hasil login
                    Get.toNamed('/dashboard_view');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50), // Ukuran tombol
                    padding: EdgeInsets.symmetric(vertical: 15), // Padding tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Sudut tombol membulat
                    ),
                    backgroundColor: Colors.orange, // Warna latar belakang tombol
                  ),
                  child: Text(
                    'Masuk',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                // Pemisah atau teks "Atau daftar menggunakan"
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Atau daftar menggunakan",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 20),
                // Tombol Login dengan Google
                OutlinedButton.icon(
                  onPressed: controller.loginWithGoogle,
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.red), // Ikon Google
                  label: Text("Google", style: TextStyle(fontSize: 16, color: Colors.black)),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, // Warna latar tombol
                    side: BorderSide(color: Colors.red), // Border warna merah
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // Tombol Login dengan Facebook
                OutlinedButton.icon(
                  onPressed: controller.loginWithFacebook,
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue), // Ikon Facebook
                  label: Text("Facebook", style: TextStyle(fontSize: 16, color: Colors.black)),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, // Warna latar tombol
                    side: BorderSide(color: Colors.blue), // Border warna biru
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Tautan Daftar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum punya akun? ", style: TextStyle(color: Colors.black)),
                    GestureDetector(
                      onTap: controller.goToRegister, // Navigasi ke halaman daftar
                      child: Text(
                        "Daftar sekarang!",
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
