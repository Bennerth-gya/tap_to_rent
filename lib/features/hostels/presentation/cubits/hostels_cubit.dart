// features/hostels/presentation/cubits/hostels_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tap_to_rent/features/hostels/presentation/cubits/hostels_states.dart';
import 'package:tap_to_rent/models/items_model.dart';

class HostelsCubit extends Cubit<HostelsState> {
  HostelsCubit() : super(HostelsInitial());

  Future<void> fetchHostels() async {
    try {
      emit(HostelsLoading());
      
      final response = await Supabase.instance.client
          .from('hostels')
          .select()
          .order('created_at', ascending: false);

      final List<Item> hostels = (response as List).map((hostel) {
        return Item(
          "Hostel for rent",
          "Uploaded Hostel",
          "User Location", // You can add location field to your upload form
          0.0, // You can add price field to your upload form
          hostel['image_url'],
          hostel['water_rating'],
          hostel['electricity_option'],
          true, // isNetworkImage
        );
      }).toList();

      emit(HostelsLoaded(hostels));
    } catch (e) {
      emit(HostelsError(e.toString()));
    }
  }

  void addHostel(Item hostel) {
    if (state is HostelsLoaded) {
      final currentHostels = (state as HostelsLoaded).hostels;
      emit(HostelsLoaded([hostel, ...currentHostels]));
    }
  }
}