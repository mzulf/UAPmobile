import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileController extends ChangeNotifier {
  File? profileImage;
  double? latitude;
  double? longitude;
  Position? currentPosition;
  GoogleMapController? mapController;

  // Mengambil gambar profil dari kamera atau galeri
  Future<void> getProfileImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        profileImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error getting profile image: $e');
    }
  }

  // Mengambil lokasi saat ini
  Future<void> getCurrentLocation(BuildContext context) async {
    try {
      // Periksa apakah layanan lokasi diaktifkan
      if (!await Geolocator.isLocationServiceEnabled()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Layanan lokasi tidak diaktifkan.')),
        );
        return;
      }

      // Periksa izin lokasi
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Izin lokasi ditolak.')),
          );
          return;
        }
      }

      // Mendapatkan lokasi saat ini
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = currentPosition?.latitude;
      longitude = currentPosition?.longitude;

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error mendapatkan lokasi: $e')),
      );
    }
  }

  // Mengatur controller Google Maps
  void setMapController(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();  // Memberitahu listener bahwa controller sudah diset
  }

  // Membersihkan controller Google Maps saat tidak diperlukan
  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  // Menyimpan data profil
  void saveData(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data profil berhasil disimpan.')),
    );
  }
}
