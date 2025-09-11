// widgets/select_category.dart
import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryButton(Icons.bed_rounded, "2 in a room"),
          categoryButton(Icons.bed_outlined, "4 in a room"),
          categoryButton(Icons.bed_outlined, "1 in a room"),
          categoryButton(Icons.bed_outlined, "6 in a room"),
        ],
      ),
    );
  }
}
Widget categoryButton(IconData icon, String? text) {
  return Container(
    margin: EdgeInsets.all(18.0),
    padding: EdgeInsets.all(8.0),
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade100)
    ),
    child: InkWell(
      onTap: (){},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
          icon, 
          size: 32.0, 
          color: Color(0xFF2972FF),
          ),
          Text("$text")
        ],
      ),
    ),
  );
}