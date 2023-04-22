import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/routes/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:provider/provider.dart';

import '../components/my_containers/my_productCard.dart';
import '../components/my_containers/my_watchesProductCard.dart';
import '../provider/model.dart';
import '../routes/watches_productDetails.dart';

class Watches extends StatelessWidget {
  Watches({super.key});

  @override
  Widget build(BuildContext context) {
    //get collection reference of the watches catalog
    final CollectionReference watchesCatalog =
        FirebaseFirestore.instance.collection('watchesCatalogFr');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: StreamBuilder(
              stream: watchesCatalog.snapshots(),
              builder:
                  (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Colors.deepPurple[600]),
                  );
                } else if (streamSnapshot.hasData) {
                  int documentLength = streamSnapshot.data!.docs.length;
                  Provider.of<Model>(context, listen: false)
                      .itemSavedHandler();
                  if (documentLength == 0) {
                    return const Center(
                      child: Text(
                        'N O  P R O D U C T S  A V A I L A B L E 💔 ',
                        style: TextStyle(fontSize: 13.5),
                      ),
                    );
                  }
                  return SizedBox.expand(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 250,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => WatchesProductDetail(
                                          index: index,
                                          productListImages:
                                              streamSnapshot.data!.docs[index]
                                                  ['productListImages'],
                                          productDescription:
                                              streamSnapshot.data!.docs[index]
                                                  ['Product description'],
                                          productBoxes: streamSnapshot.data!.docs[index]
                                              ['Product boxes'],
                                          productImage: streamSnapshot.data!
                                              .docs[index]['Product image'],
                                          productName: streamSnapshot.data!.docs[index]
                                              ['Product name'],
                                          productPrice:
                                              streamSnapshot.data!.docs[index]
                                                  ['Product price']))));
                            },
                            child: MyWatchesProductCard(
                              index: index,
                              productName: streamSnapshot.data!.docs[index]
                                  ['Product name'],
                              productImage: streamSnapshot.data!.docs[index]
                                  ['Product image'],
                              productDescription: streamSnapshot
                                  .data!.docs[index]['Product description'],
                              productBoxes: streamSnapshot.data!.docs[index]
                                  ['Product boxes'],
                              productPrice: streamSnapshot.data!.docs[index]
                                  ['Product price'],
                              productSaved: streamSnapshot.data!.docs[index]
                                  ['Product saved'],
                              productListImages: streamSnapshot
                                  .data!.docs[index]['productListImages'],
                            ),
                          );
                        }),
                  );
                }

                return Image.asset('lib/assets/register.png');
              }),
        ),
      ],
    );
  }
}
