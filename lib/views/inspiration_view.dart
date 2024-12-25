import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/inspiration_controller.dart';
import '../views/meal_detail_view.dart';

class InspirationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InspirationController controller = Get.put(InspirationController());
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Inspiration'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search meals...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.searchMeals(value);
                }
              },
            ),
          ),
          Obx(() {
            if (!controller.isConnected.value) {
              return Center(
                child: Text(
                  'No Internet Connection',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            if (controller.meals.isEmpty) {
              return Center(child: Text('No meals available.'));
            }

            return Expanded(
              child: ListView.builder(
                itemCount: controller.meals.length,
                itemBuilder: (context, index) {
                  final meal = controller.meals[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: Image.network(
                        meal.strMealThumb,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error),
                      ),
                      title: Text(meal.strMeal),
                      subtitle: Text(meal.strCategory),
                      onTap: () => Get.to(() => MealDetailView(meal: meal)),
                      trailing: IconButton(
                        icon: Icon(Icons.save),
                        onPressed: () {
                          // Simpan meal ke penyimpanan lokal
                          controller.storage.write(meal.idMeal, meal.toJson());
                          Get.snackbar(
                            'Saved',
                            '${meal.strMeal} has been saved locally.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
