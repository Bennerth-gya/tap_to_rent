// features/hostels/presentation/cubits/hostels_states.dart
import 'package:tap_to_rent/models/items_model.dart';

abstract class HostelsState {}

class HostelsInitial extends HostelsState {}

class HostelsLoading extends HostelsState {}

class HostelsLoaded extends HostelsState {
  final List<Item> hostels;
  
  HostelsLoaded(this.hostels);
}

class HostelsError extends HostelsState {
  final String message;
  
  HostelsError(this.message);
}