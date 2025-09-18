// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  final bool showBottomNavBar;

  const HomeScreen({super.key, required this.showBottomNavBar});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> _futureHostels;

  Future<List<Map<String, dynamic>>> _fetchHostels() async {
    final response = await Supabase.instance.client
        .from('hostels')
        .select()
        .order('created_at', ascending: false);

    return (response as List).cast<Map<String, dynamic>>();
  }

  @override
  void initState() {
    super.initState();
    _futureHostels = _fetchHostels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hostels'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () async {
              await Navigator.pushNamed(context, '/upload');
              setState(() {
                _futureHostels = _fetchHostels(); // ✅ Refresh after upload
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureHostels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final hostels = snapshot.data ?? [];

          if (hostels.isEmpty) {
            return const Center(child: Text('No hostels uploaded yet.'));
          }

          return ListView.builder(
            itemCount: hostels.length,
            itemBuilder: (context, index) {
              final hostel = hostels[index];
              return Card(
                margin: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hostel['image_url'] != null &&
                        hostel['image_url'].toString().isNotEmpty)
                      Image.network(
                        hostel['image_url'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Water: ${hostel['water_rating']}/5\nElectricity: ${hostel['electricity_option']}",
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
