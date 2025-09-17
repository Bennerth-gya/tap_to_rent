// screens/home_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tap_to_rent/models/items_model.dart';
import 'package:tap_to_rent/widgets/search_field.dart';
import 'package:tap_to_rent/widgets/select_category.dart';
import 'package:tap_to_rent/widgets/suggestion_list.dart';

class HomeScreen extends StatefulWidget {
  final bool showBottomNavBar;
  
  const HomeScreen({super.key, this.showBottomNavBar = true});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            toolbarHeight: 80.0,
            title: Row(children: [
                Icon(
                    Icons.location_on,
                    color: Colors.blue.shade600,
                    ),
                    Text(
                        "Ghana, Tarkwa",
                        style: TextStyle(
                        color: Colors.grey.shade600,
                    ),)
                    ],
                    ),
                    actions: [IconButton(onPressed: (){}, 
                    icon: Icon(
                        Icons.notifications, 
                        color: Colors.grey.shade600,
                        )
                        )
                        ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                    children: [
                        //<<-------------We add some widgets------------->>
                        SearchField(),
                        SelectCategory(),
                        SizedBox(
                            height: 20.0,
                        ),
                        SuggestionList("Recommendation for you", Item.recommendation),
                        SizedBox(height: 20.0,),
                        SuggestionList("Nearby you", Item.nearby)
                        //<<------------Details screen----------->>
                    ],
                ),
                ),
        ),
        // <<-----------Let's now create the navigation button------------>>
        bottomNavigationBar: widget.showBottomNavBar ? BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue.shade600,
            unselectedItemColor: Colors.grey.shade600,
            items: [
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search), label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.heart), label: "Favourites"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message_outlined), label: "Messages"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person), label: "Profile"),
            ]
            ) : null,
    );
  }
}