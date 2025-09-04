import 'package:flutter/material.dart';
import 'package:tap_to_rent/models/items_model.dart';
import 'package:tap_to_rent/screens/details_screen.dart';
import 'package:tap_to_rent/widgets/house_cart.dart';

class SuggestionList extends StatefulWidget {
  SuggestionList(this.title, this.items, {super.key});
  String? title;
  List<Item> items;
  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title!, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              ),
              TextButton(onPressed: (){}, child: Text("See All"))
            ],
          ),
          SizedBox(
            height: 12.0,
          ),
          Container(
            height: 340.0,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.items.length, 
              itemBuilder: (context, index)=> 
              ItemCard(widget.items[index], () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                DetailsScreen(widget.items[index])));
              }),
              ),
          )
        ],
      ),
    );
  }
}