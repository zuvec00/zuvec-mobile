import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/routes/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:provider/provider.dart';

import '../components/my_containers/my_productCard.dart';
import '../provider/model.dart';

class Luchi extends StatelessWidget {
  Luchi({super.key});

  @override
  Widget build(BuildContext context) {
    //get collection reference of the watches catalog
    final CollectionReference watchesCatalog =
        FirebaseFirestore.instance.collection('watchesCatalaog');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: StreamBuilder(
              stream: watchesCatalog.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Colors.deepPurple[600]),
                  );
                } else if (streamSnapshot.hasData) {
                  documentLength2 = streamSnapshot.data!.docs.length;
                  int documentLength = streamSnapshot.data!.docs.length;
                  Provider.of<Model>(context, listen: false).itemSavedHandler();

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
                                      builder: ((context) => ProductDetail(
                                          index: index,
                                          productListImages: streamSnapshot
                                              .data!
                                              .docs[index]['productListImages'],
                                          productSizes: streamSnapshot.data!.docs[index]
                                              ['Product sizes'],
                                          productImage: streamSnapshot.data!
                                              .docs[index]['Product image'],
                                          productDescription:
                                              streamSnapshot.data!.docs[index]
                                                  ['Product description'],
                                          productName: streamSnapshot.data!.docs[index]
                                              ['Product name'],
                                          productPrice: streamSnapshot.data!
                                              .docs[index]['Product price']))));
                            },
                            child: MyProductCard(
                              index: index,
                              productName: streamSnapshot.data!.docs[index]
                                  ['Product name'],
                              productDescription: streamSnapshot
                                  .data!.docs[index]['Product description'],
                              productImage: streamSnapshot.data!.docs[index]
                                  ['Product image'],
                              productSizes: streamSnapshot.data!.docs[index]
                                  ['Product sizes'],
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

                return Center(child: Text('An error occured'));
              }),
        ),
      ],
    );
  }
}

/* 
  LayoutGrid(
                        gridFit: GridFit.loose,
                        columnSizes: [1.fr, 1.fr],
                        rowSizes: const [
                          auto,
                          auto,
                        ],
                        rowGap: 10,
                        columnGap: 10,
                        children: [
                          for (int i = 0;
                              i < streamSnapshot.data!.docs.length;
                              i++)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => ProductDetail(
                                            index: i,
                                            productImage: streamSnapshot
                                                .data!.docs[i]['Product image'],
                                            productName: streamSnapshot
                                                .data!.docs[i]['Product name'],
                                            productPrice: streamSnapshot.data!
                                                .docs[i]['Product price']))));
                              },
                              child: MyProductCard(
                                index: i,
                                productName: streamSnapshot.data!.docs[i]
                                    ['Product name'],
                                productImage: streamSnapshot.data!.docs[i]
                                    ['Product image'],
                                productPrice: streamSnapshot.data!.docs[i]
                                    ['Product price'],
                                productSaved: streamSnapshot.data!.docs[i]
                                    ['Product saved'],
                              ),
                            )
                        ]);
*/

