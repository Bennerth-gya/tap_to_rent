// upload_images.dart
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadImagesPage extends StatefulWidget {
  const UploadImagesPage({super.key});

  @override
  State<UploadImagesPage> createState() => _UploadImagesPageState();
}

class _UploadImagesPageState extends State<UploadImagesPage> {
  File? _imageFile;
  Uint8List? _webImage;
  int _waterAvailability = 3;
  String _electricityOption = "Included";

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() => _webImage = bytes);
      } else {
        setState(() => _imageFile = File(picked.path));
      }
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null && _webImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'uploads/$fileName.jpg';
      final storage = Supabase.instance.client.storage.from('images');

      if (kIsWeb) {
        await storage.uploadBinary(path, _webImage!);
      } else {
        await storage.upload(path, _imageFile!);
      }

      final publicUrl = storage.getPublicUrl(path);
      debugPrint('Image public URL: $publicUrl');

      await Supabase.instance.client.from('hostels').insert({
        'image_url': publicUrl,
        'water_rating': _waterAvailability,
        'electricity_option': _electricityOption,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hostel uploaded successfully!')),
      );

      setState(() {
        _imageFile = null;
        _webImage = null;
        _waterAvailability = 3;
        _electricityOption = "Included";
      });

      Navigator.pop(context); // ✅ go back to home
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Hostel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: _webImage != null || _imageFile != null
                      ? kIsWeb
                          ? Image.memory(_webImage!, fit: BoxFit.cover)
                          : Image.file(_imageFile!, fit: BoxFit.cover)
                      : const Text("Tap to select image"),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text("Water Availability: $_waterAvailability/5"),
            Slider(
              value: _waterAvailability.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: _waterAvailability.toString(),
              onChanged: (val) {
                setState(() => _waterAvailability = val.toInt());
              },
            ),
            const SizedBox(height: 20),
            const Text("Electricity Option"),
            DropdownButton<String>(
              value: _electricityOption,
              items: const [
                DropdownMenuItem(value: "Included", child: Text("Included")),
                DropdownMenuItem(value: "Prepaid", child: Text("Prepaid")),
              ],
              onChanged: (value) {
                setState(() => _electricityOption = value!);
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _uploadImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Upload Hostel",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
