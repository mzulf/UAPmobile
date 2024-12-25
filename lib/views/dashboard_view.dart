import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import 'home_view.dart';
import 'write_recipe_view.dart';
import 'favorites_view.dart';
import 'inspiration_view.dart';
import 'profile_view.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find();

    return Obx(
          () => Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          leading: IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage(controller.profileImage.value),
            ),
            onPressed: () {
              controller.changePage(4); // Pindah ke halaman Profil
            },
          ),
        ),
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            HomeView(),
            WriteRecipeView(),
            FavoritesView(),
            InspirationView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              label: 'Tulis Resep',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Resep Saya',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
