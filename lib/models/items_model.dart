// models/items_model.dart
class Item {
  String? title;
  String? category;
  String? location;
  double? price;
  String? image;
  int? waterRating;
  String? electricityOption;
  bool isNetworkImage;

  Item(this.title, this.category, this.location, this.price, [this.image, this.waterRating, this.electricityOption, this.isNetworkImage = false]);

  static List<Item> recommendation = [
    //www.google.com/url?sa=i&url=https%3A%2F%2Fkosass.knust.edu.gh%2Fobuasi-campus%2Fla-casa-maria&psig=AOvVaw1A3AkU2nliKFApNVSTGnPq&ust=1753570116726000&source=images&cd=vfe&opi=89978449&ved=0CBgQjhxqFwoTCNjoxPKL2Y4DFQAAAAAdAAAAABAK'),
    Item("Hostel for rent", "Four in a room", "Akyempem", 6000, "assets/hos1.jpeg"),
    Item("Hostel for rent", "Four in a room", "Brahabebom", 5700, "assets/hos2.jpg"),
  ];

  static List<Item> nearby = [
    Item("Modern House for renting", "Hostel", "CampCity", 5000, "assets/hos3.jpg"),
    Item("Hostel for rent", "Four in a room", "CampCity", 6000, "assets/knust1.jpeg"),
    Item("Hostel for rent", "Four in a room", "Brahabebom", 5500, "assets/knust3.jpg"),
    Item("Hostel for rent", "Four in a room", "Rice depo", 5600, "assets/knust4.jpg")
  ];
}