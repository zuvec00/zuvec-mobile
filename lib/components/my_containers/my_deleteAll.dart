import 'package:firebase_practice/bottombar.dart';
import 'package:firebase_practice/screens/saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/model.dart';
import '../../routes/cart_page.dart';

// F O R  T H E  S A V E D  S E C T I O N
class MyRemoveAllContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Provider.of<Model>(context, listen: false).removeAllSavedItems();
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red[400]!,
            margin: const EdgeInsets.only(top: 0),
            duration: Duration(seconds: 2),
            icon: Icon(Icons.check_box_rounded, color: Colors.white),
            messageText: Text(
                "All Items successufully deleted.",
                style: GoogleFonts.openSans(color: Colors.white)),
          )..show(context).then((_) => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: ((context) => MyBottomBar()))));
          ;
        },
        child: Container(
            width: size.width * 0.35,
            padding:
                const EdgeInsets.symmetric(horizontal: 14,vertical:10),
            decoration: BoxDecoration(
              color: Colors.deepPurple[600],
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.delete_outline_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
                Text('Remove All',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))
              ],
            )));
  }
}

// F O R  T H E  C A R T  S E C T I O N
class MyRemoveAllContainer2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Provider.of<Model>(context, listen: false).removeAllCartItems();

          //notifies user
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red[400]!,
            margin: const EdgeInsets.only(top: 0),
            duration: Duration(seconds: 2),
            icon: Icon(Icons.check_box_rounded, color: Colors.white),
            messageText: Text("All Items successfully deleted.",
                style: GoogleFonts.openSans(color: Colors.white)),
          )..show(context).then((_) =>  Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => Cart()))));
         
        },
        child: Container(
            width: size.width * 0.35,
            padding:
                const EdgeInsets.only(left: 10, right: 14, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.deepPurple[600],
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.delete_outline_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
                Text('Remove All',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))
              ],
            )));
  }
}
