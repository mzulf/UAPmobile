import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: Consumer<ProfileController>(
          builder: (context, controller, _) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Bagian untuk foto profil
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.profileImage != null
                              ? FileImage(controller.profileImage!)
                              : AssetImage('assets/profile_image.png') as ImageProvider,
                        ),
                        GestureDetector(
                          onTap: controller.getProfileImage,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blueAccent,
                            child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Input untuk data profil (default kosong)
                    _buildTextField('Full Name', ''),
                    SizedBox(height: 10),
                    _buildTextField('Email', ''),
                    SizedBox(height: 10),
                    _buildTextField('Phone Number', ''),
                    SizedBox(height: 10),
                    // Tombol lokasi
                    ElevatedButton(
                      onPressed: () => controller.getCurrentLocation(context),
                      child: Text('Get Current Location'),
                    ),
                    SizedBox(height: 10),
                    // Tampilkan Latitude dan Longitude
                    if (controller.latitude != null && controller.longitude != null)
                      Column(
                        children: [
                          Text('Latitude: ${controller.latitude}'),
                          Text('Longitude: ${controller.longitude}'),
                        ],
                      )
                    else
                      Text('Lokasi tidak tersedia. Pastikan izin lokasi telah diberikan.'),
                    SizedBox(height: 20),
                    // Google Maps Widget
                    if (controller.latitude != null && controller.longitude != null)
                      SizedBox(
                        height: 300,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(controller.latitude!, controller.longitude!),
                            zoom: 15,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('current_location'),
                              position: LatLng(controller.latitude!, controller.longitude!),
                              infoWindow: InfoWindow(title: 'Lokasi Anda'),
                            ),
                          },
                          onMapCreated: (GoogleMapController mapController) {
                            print("GoogleMapController Created!");
                            controller.setMapController(mapController); // Mengirimkan controller ke ProfileController
                          },
                        ),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => controller.saveData(context),
                      child: Text('Simpan Data'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget untuk TextField
  Widget _buildTextField(String label, String value) {
    return TextField(
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
