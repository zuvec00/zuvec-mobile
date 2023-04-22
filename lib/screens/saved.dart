import 'package:firebase_practice/components/my_customWidgets/saved_empty.dart';
import 'package:firebase_practice/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../components/my_containers/my_deleteAll.dart';
import '../components/my_containers/my_savedItemsContainers.dart';
import '../provider/model.dart';
import '../routes/cart_page.dart';

class Saved extends StatefulWidget {
  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  void initState() {
    super.initState();
    Provider.of<Model>(context, listen: false).refreshSavedItems();
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[100],
          leading: Text(''),
          title: Text(
            'W I S H L I S T',
            style: GoogleFonts.openSans(color: Colors.grey[900]),
          ),
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) => Cart())));
                        },
                        icon: Icon(Icons.shopping_bag_outlined,
                            color: Colors.grey[900])),
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[600],
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
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: Colors.grey[200],
        height: 150,
        animSpeedFactor: 2,
        backgroundColor: Colors.deepPurple[600],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Consumer<Model>(
            builder: (context, value, child) => value.userSavedItems.length == 0
                // if saved section is empty =>
                ? SavedEmpty()
                //else =>
                : Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyRemoveAllContainer(),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                        child: Consumer<Model>(
                      builder: (context, value, child) => ListView.builder(
                          itemCount: value.userSavedItems.length,
                          itemBuilder: (context, index) {
                            final currentItem = value.userSavedItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: MySavedItems(
                                productImagePath:
                                    currentItem['productImagePath'],
                                productName: currentItem['productName'],
                                productPrice: currentItem['productPrice'],
                                productSize: currentItem['productSize'],
                                index: currentItem['key'],
                              ),
                            );
                          }),
                    ))
                  ]),
          ),
        ),
      ),
    );
  }
}
