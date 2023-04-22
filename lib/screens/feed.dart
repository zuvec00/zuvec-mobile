import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/model.dart';
import '../routes/cart_page.dart';
import '../tabScreens/feedTabbars/discover.dart';
import '../tabScreens/feedTabbars/fashion_frames.dart';
import '../tabScreens/feedTabbars/fashion_reels.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text('F E E D',
                style: GoogleFonts.openSans(color: Colors.grey[900])),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Consumer<Model>(
                  builder: (context, value, child) => Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Cart())));
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
              const SizedBox(width: 10),
            ]),
        body: DefaultTabController(
            length: 3,
            child: Column(
              children: const [
                SizedBox(height: 8),
                Expanded(child: MyTabBar())
              ],
            )));
  }
}

class MyTabBar extends StatelessWidget {
  const MyTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            isScrollable: true,
            indicatorWeight: 2,
            indicatorColor: Colors.deepPurple[600],
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
            labelStyle: GoogleFonts.openSans(),
            tabs: const [
              Text('Discover'),
              Text('Fashion Frames'),
              Text('Fashion Reels'),
            ]),
        const SizedBox(
          height: 15,
        ),
        Expanded(
            child: TabBarView(children: [
          Discover(),
          FashionFrames(),
          FashionReels(),
        ]))
      ],
    );
  }
}
