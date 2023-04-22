import 'package:firebase_practice/bottombar.dart';
import 'package:firebase_practice/components/my_customWidgets/cart_empty.dart';
import 'package:firebase_practice/routes/shippingAddress/shippingAddress_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../components/my_containers/my_cartItemsCont.dart';
import '../components/my_containers/my_deleteAll.dart';
import '../components/my_price.dart';
import '../provider/model.dart';

class Cart extends StatefulWidget {
  Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  var totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    //refresh items saved in cart
    Provider.of<Model>(context, listen: false).refreshCartItems();
    //refresh the total number of items in cart
    Provider.of<Model>(context, listen: false).updateCartItemsLength();
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => MyBottomBar()))),
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[900])),
        title: Text('Order Details',
            style: GoogleFonts.openSans(color: Colors.grey[900])),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: Colors.grey[200],
        height: 150,
        animSpeedFactor: 2,
        backgroundColor: Colors.deepPurple[600],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
          child: Consumer<Model>(
            builder: (context, value, child) => value.userCartItems.length == 0
                ? CartEmpty()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('CART SUMMARY',
                                style: TextStyle(
                                    color: Colors.grey[
                                        600] /*fontSize: 18, fontWeight: FontWeight.bold*/)),
                            MyRemoveAllContainer2(),
                          ],
                        ),
                        Expanded(
                          flex: 5,
                          child: Consumer<Model>(
                            builder: (context, value, child) =>
                                ListView.builder(
                                    itemCount: value.userCartItems.length,
                                    itemBuilder: (context, index) {
                                      final currentItem =
                                          value.userCartItems[index];
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7.50),
                                          child: MyCartItems(
                                            index: currentItem['key'],
                                            productImagePath:
                                                currentItem['productImagePath'],
                                            productName:
                                                currentItem['productName'],
                                            productPrice:
                                                currentItem['productPrice'],
                                            productSize:
                                                currentItem['productSize'],
                                            itemQuantity: currentItem[
                                                'productItemQuantity'],
                                          ));
                                    }),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  thickness: 1,
                                ),
                                Expanded(
                                    child: Consumer<Model>(
                                  builder: (context, value, child) => ListView(
                                    children: [
                                      const Text('Order Info',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Subtotal',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[600])),
                                          Price(
                                            price: value.getTotalPrice(),
                                            fontSize: 13.5,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Shipping Cost',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[600])),
                                          Text('Not included yet.',
                                              style: TextStyle(fontSize: 12))
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[600])),
                                          Price(
                                            price: value.getTotalPrice(),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ))
                      ]),
          ),
        ),
      ),
      bottomNavigationBar: Consumer<Model>(
        builder: (context, value, child) => value.userCartItems.length == 0
            ? Text('')
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: BottomAppBar(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Row(children: [
                      InkWell(
                        radius: 25,
                        splashColor: Colors.grey,
                        onTap: () {
                          launchUrl(Uri.parse('tel://09125613618'));
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.deepPurple[600]!,
                                )),
                            child: Icon(Icons.phone_rounded,
                                color: Colors.deepPurple[600])),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        ShippingAddressPage())));
                          },
                          child: Container(
                              alignment: Alignment.center,
                              //width: MediaQuery.of(context).size.width,
                              height: 45,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.deepPurple[600],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('CHECKOUT ',
                                      style: TextStyle(color: Colors.grey[100])),
                                  Text('(',
                                      style: TextStyle(color: Colors.grey[100])),
                                  Price(
                                      price: value.getTotalPrice(),
                                      fontSize: 14,
                                      color: Colors.grey[100]),
                                  Text(')',
                                      style: TextStyle(color: Colors.grey[100]))
                                ],
                              )),
                        ),
                      ),
                    
                    ])),
              ),
      ),
    );
  }
}
