import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/routes/cart_page.dart';
import 'package:firebase_practice/routes/payment_page.dart';
import 'package:firebase_practice/routes/shippingAddress/addNewAddress_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../components/my_containers/my_shippingAddressContainer.dart';
import '../../components/my_price.dart';
import '../../provider/model.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  double shippingFee = 0.00;
  bool storePickUp = false;

  void storePickUpHandler() {
    setState(() {
      storePickUp = !storePickUp;
    });
    if (storePickUp) {
      shippingFee = 0.0;
    } else {
      shippingFee = 2500.00;
    }
  }

  void initState() {
    super.initState();
    //refresh user address fields
    Provider.of<Model>(context, listen: false).refreshShippingAddress();
  }

  //text controllers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Cart()))),
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[900])),
        title: Text('Shipping Address',
            style: GoogleFonts.openSans(color: Colors.grey[900])),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Store Pickup',
                    style: TextStyle(fontSize: 14.5, color: Colors.grey[900])),
                InkWell(
                  onTap: storePickUpHandler,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color:
                            storePickUp ? Colors.deepPurple[600] : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: storePickUp ? 0.0 : 1.5,
                            color: storePickUp
                                ? Colors.white
                                : Colors.grey[300]!)),
                    child: Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              color: Colors.grey[600],
            ),
            Text('YOUR ADDRESSES', style: TextStyle(color: Colors.grey[600])),

            //add new address button
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AddNewAddressPage())));
              },
              child: DottedBorder(
                padding: const EdgeInsets.all(2),
                color: Colors.deepPurple[600]!,
                strokeWidth: 1.5,
                dashPattern: [
                  6,
                  3,
                ],
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_box_rounded,
                          size: 23,
                          color: Colors.deepPurple[600],
                        ),
                        Text('  Add New Address',
                            style: TextStyle(color: Colors.grey[600]))
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: 5,
              child: Consumer<Model>(
                builder: (context, value, child) => ListView.builder(
                    itemCount: value.userShippingAddressDetails.length,
                    itemBuilder: (context, index) {
                      final currentItem =
                          value.userShippingAddressDetails[index];
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.50),
                          child: MyShippingAddressContainer(
                            index: currentItem['key'],
                            firstName: currentItem['firstName'],
                            lastName: currentItem['lastName'],
                            deliveryAddress: currentItem['deliveryAddress'],
                            additionalInfo: currentItem['additionalInfo'],
                            region: currentItem['region'],
                            city: currentItem['city'],
                            mobilePhoneNo: currentItem['mobilePhoneNo'],
                            additionalPhoneNo: currentItem['additionalPhoneNo'],
                            selected: currentItem['addressSelected'],
                          ));
                    }),
              ),
            ),

            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                        child: Consumer<Model>(
                      builder: (context, value, child) => ListView(
                        children: [
                          const Text('Order Info',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600])),
                              Price(
                                price: value.getTotalPrice(),
                                fontSize: 13.5,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping Cost',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600])),
                              Price(
                                price: shippingFee,
                                fontSize: 13.5,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[600])),
                              Price(
                                price: value.getTotalPrice() + shippingFee,
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: Consumer<Model>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(15.0),
          child: BottomAppBar(
              elevation: 0,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  bool addressChosen =
                      Provider.of<Model>(context, listen: false)
                          .verifyUserPreferredAddress();
                  print('Address Chosen: $addressChosen');

                  if (!storePickUp &&
                      value.userShippingAddressDetails.length == 0) {
                    //notifies user
                    Flushbar(
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Colors.red[400]!,
                      margin: const EdgeInsets.only(top: 0),
                      duration: Duration(seconds: 2),
                      icon: Icon(Icons.error_outline_rounded,
                          color: Colors.white),
                      messageText: Text(
                          "Add a shipping address before proceeding to payment",
                          style: GoogleFonts.openSans(color: Colors.white)),
                    )..show(context);
                  } else if (!storePickUp && !addressChosen) {
                    Flushbar(
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Colors.red[400]!,
                      margin: const EdgeInsets.only(top: 0),
                      duration: Duration(seconds: 2),
                      icon: Icon(Icons.error_outline_rounded,
                          color: Colors.white),
                      messageText: Text("Please select one shipping address",
                          style: GoogleFonts.openSans(color: Colors.white)),
                    )..show(context);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PaymentPage(
                                  shippingFee: storePickUp
                                      ? 0.0
                                      : Provider.of<Model>(context,
                                              listen: false)
                                          .getUserPrefferedAddress(),
                                ))));
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 45,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFF5E35B1),
                    ),
                    child: Text(
                      'PROCEED TO PAYMENT',
                      style: TextStyle(color: Colors.grey[100]),
                    )),
              )),
        ),
      ),
    );
  }
}
