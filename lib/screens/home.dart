import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/components/my_containers/my_tabBar_container.dart';
import 'package:firebase_practice/routes/cart_page.dart';
import 'package:firebase_practice/tabScreens/watches.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/model.dart';
import '../tabScreens/crocs.dart';
import '../tabScreens/sneakers.dart';
import '../tabScreens/all_luchi.dart';
import '../tabScreens/luchi_material.dart';

class Home extends StatefulWidget {
  String? firstName;
  Home({
    super.key,
    this.firstName,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //get current user ID

  late String greeting;

  String _getCurrentUserId() {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String userID = currentUser.uid;
    return userID;
  }

  String _getGreeting() {
    int hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  void initState() {
    super.initState();

    setState(() {
      greeting = _getGreeting();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          automaticallyImplyLeading: false,
          // leading: Icon(Icons.menu_rounded, color: Colors.grey[900]),
          title: Text('Z U V E C',
              style: GoogleFonts.openSans(color: Colors.grey[900])),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Consumer<Model>(
                builder: (context, value, child) => Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) => Cart())));
                        },
                        icon: Icon(Icons.shopping_bag_outlined,
                            color: Colors.grey[900])),
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFF5E35B1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${value.cartLength}',
                          style: TextStyle(color: Colors.grey[100]),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 4,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
            child:
                // ignore: prefer_const_literals_to_create_immutables
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                  onTap: () {
                    print('sth:${size.height}, ${size.width}');
                  },
                  child: Row(children: [
                    Text('$greeting ',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    Icon(Icons.favorite_rounded,
                        size: 34, color: Colors.deepPurple[600])
                  ])),
              Text('Explore and Find Your Match',
                  style: TextStyle(fontSize: 13.5, color: Colors.grey[600])),
              Divider(
                indent: 15,
                endIndent: 15,
              ),
              SizedBox(height: 15),
              Expanded(child: MyTabBar())
            ]),
          ),
        ));
  }
}

// M Y  C U S T O M  T A B B A R  W I D G E T
class MyTabBar extends StatefulWidget {
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _animationController;

  void initState() {
    super.initState;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    Provider.of<Model>(context, listen: false).refreshCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              MyTabBarContainer(
                  icon: Icons.watch_rounded,
                  tabName: 'Ready 2 Wear ',
                  color: currentIndex == 0
                      ? Colors.grey[900]!
                      : Colors.transparent,
                  textColor:
                      currentIndex == 0 ? Colors.grey[100]! : Colors.grey[900]!,
                  borderColor: currentIndex == 0
                      ? Colors.grey[900]!
                      : Colors.grey[600]!),
              MyTabBarContainer(
                  icon: Icons.watch_rounded,
                  tabName: 'Ankara Materials ',
                  color: currentIndex == 1
                      ? Colors.grey[900]!
                      : Colors.transparent,
                  textColor:
                      currentIndex == 1 ? Colors.grey[100]! : Colors.grey[900]!,
                  borderColor: currentIndex == 1
                      ? Colors.grey[900]!
                      : Colors.grey[600]!),
              MyTabBarContainer(
                  icon: Icons.outlined_flag,
                  tabName: 'Watches ',
                  color: currentIndex == 2
                      ? Colors.grey[900]!
                      : Colors.transparent,
                  textColor:
                      currentIndex == 2 ? Colors.grey[100]! : Colors.grey[900]!,
                  borderColor: currentIndex == 2
                      ? Colors.grey[900]!
                      : Colors.grey[600]!),
              MyTabBarContainer(
                  icon: Icons.favorite_outline_rounded,
                  tabName: 'Footwear ',
                  color: currentIndex == 3
                      ? Colors.grey[900]!
                      : Colors.transparent,
                  textColor:
                      currentIndex == 3 ? Colors.grey[100]! : Colors.grey[900]!,
                  borderColor: currentIndex == 3
                      ? Colors.grey[900]!
                      : Colors.grey[600]!),
             /* MyTabBarContainer(
                  icon: Icons.favorite_outline_rounded,
                  tabName: 'Crocs ',
                  color: currentIndex == 4
                      ? Colors.grey[900]!
                      : Colors.transparent,
                  textColor:
                      currentIndex == 4 ? Colors.grey[100]! : Colors.grey[900]!,
                  borderColor:
                      currentIndex == 4 ? Colors.grey[900]! : Colors.grey[600]!)*/
            ]),
        const SizedBox(height: 15),
        Expanded(
            child: TabBarView(children: [
          Luchi(),
          LuchiMaterials(),
          Watches(),
          Sneakers(),
          //Crocs(),
          
        ]))
      ],
    );
  }
}
