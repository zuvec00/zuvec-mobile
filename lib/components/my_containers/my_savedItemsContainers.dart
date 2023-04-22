import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_practice/provider/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../my_price.dart';
import 'my_add2Cart.dart';

class MySavedItems extends StatelessWidget {
  final String productImagePath;
  final String productName;
  final double productPrice;
  final String productSize;
  final int? index;
  const MySavedItems({
    super.key,
    required this.productImagePath,
    required this.productName,
    required this.productPrice,
    required this.productSize,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            //deletes item
            Provider.of<Model>(context, listen: false).removeSavedItem(index!);

            //notifies user
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Colors.red[400]!,
              margin: const EdgeInsets.only(top: 0),
              duration: Duration(seconds: 2),
              icon: Icon(Icons.check_box_rounded, color: Colors.white),
              messageText: Text("Item successfully deleted.",
                  style: GoogleFonts.openSans(color: Colors.white)),
            )..show(context);
          },
          icon: Icons.delete_rounded,
          backgroundColor: Colors.deepPurple.shade600,
          borderRadius: BorderRadius.circular(15),
        )
      ]),
      child: Container(
          padding: const EdgeInsets.all(8),
         // width: size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(7.5)),
                  child: CachedNetworkImage(
                      imageUrl: productImagePath,
                      placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                                color: Colors.deepPurple[600]),
                          ),
                      errorWidget: (context, url, error) => Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red))),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$productName',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 2),
                    Price(
                      price: productPrice,
                      fontSize: 13,
                    ),
                    
                    
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Text('variant:${productSize}',
                              overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600])),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              //calls the function to add items to cart
                              Provider.of<Model>(context, listen: false)
                                  .addCartItem({
                                'productImagePath': productImagePath,
                                'productName': productName,
                                'productPrice': productPrice.toDouble(),
                                'productSize': productSize,
                                'productItemQuantity': 1,
                              });

                              //calls the function to update the length of cart
                              Provider.of<Model>(context, listen: false)
                                  .updateCartItemsLength();

                              //notifies user
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Colors.green[400]!,
                                margin: const EdgeInsets.only(top: 0),
                                duration: Duration(seconds: 2),
                                icon: Icon(Icons.check_box_rounded,
                                    color: Colors.white),
                                messageText: Text("Cart successfully updated.",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white)),
                              )..show(context);
                            },
                            child: MyAddToCartButton2()),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
