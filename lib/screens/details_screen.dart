// screens/details_screen.dart
import 'package:flutter/material.dart';
import 'package:tap_to_rent/models/items_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(this.item, {super.key});
  final Item item;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        title: Text(
          widget.item.title!,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: double.infinity,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: AssetImage(widget.item.image!),
                fit: BoxFit.cover
                )
            ),
            ),
            SizedBox(height: 10.0,),
            Text(widget.item.category!, 
            style: TextStyle(color: Colors.blue.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 18.0
            ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text( 
            widget.item.title!, 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0,),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  ),
                  Text(
                widget.item.category!, 
                style: TextStyle(
                color: Colors.blue.shade600,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
              ),
                
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${widget.item.price}₵ / year",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline)
                  )
              ],
            ),
            Expanded(child: Container()),
            Container(
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: RawMaterialButton(
                onPressed: (){},
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)
                ),
                fillColor: Colors.blue.shade600,
                child: Text(
                  "Tap To Rent", 
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  
                  ),
                ),
            )
          ],
        ),
        ),
    );
  }
}