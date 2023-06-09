import 'package:firebase_practice/components/my_textfield.dart';
import 'package:firebase_practice/provider/model.dart';
import 'package:firebase_practice/routes/shippingAddress/shippingAddress_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddNewAddressPage extends StatelessWidget {
  final int? index;
  AddNewAddressPage({
    super.key,
    this.index,
  });

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final deliveryAddressController = TextEditingController();
  final additionalInfoController = TextEditingController();
  final regionController = TextEditingController();
  final cityController = TextEditingController();
  final mobilePhoneNoController = TextEditingController();
  final additionalPhoneNoController = TextEditingController();

  Future<void> return2PrevPage(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 500));

    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => ShippingAddressPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[900])),
        title: Text(index == null ? 'Add New Address' : 'Edit Address',
            style: GoogleFonts.openSans(color: Colors.grey[900])),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Container(
                        width: constraints.maxWidth * 0.65,
                        child: MyTextField(
                          controller: firstNameController,
                          hintText: 'First Name',
                          obscureText: false,
                          paddingHeight: 10,
                          paddingWidth: 10,
                        ));
                  }),
                ),
                Expanded(
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Container(
                        width: constraints.maxWidth * 0.65,
                        child: MyTextField(
                          controller: lastNameController,
                          hintText: 'Last Name',
                          obscureText: false,
                          paddingHeight: 10,
                          paddingWidth: 10,
                        ));
                  }),
                )
              ],
            ),
            MyTextField(
              controller: deliveryAddressController,
              hintText: 'Delivery Address',
              obscureText: false,
              paddingHeight: 10,
              paddingWidth: 10,
            ),
            MyTextField(
              controller: additionalInfoController,
              hintText: 'Additional Info',
              obscureText: false,
              paddingHeight: 10,
              paddingWidth: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Container(
                        width: constraints.maxWidth * 0.65,
                        child: MyTextField(
                          controller: regionController,
                          hintText: 'State/Region',
                          obscureText: false,
                          paddingHeight: 10,
                          paddingWidth: 10,
                        ));
                  }),
                ),
                Expanded(
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Container(
                        width: constraints.maxWidth * 0.65,
                        child: MyTextField(
                          controller: cityController,
                          hintText: 'City',
                          obscureText: false,
                          paddingHeight: 10,
                          paddingWidth: 10,
                        ));
                  }),
                )
              ],
            ),
            MyTextField(
              controller: mobilePhoneNoController,
              hintText: 'Mobile Phone Number',
              obscureText: false,
              paddingHeight: 10,
              paddingWidth: 10,
            ),
            MyTextField(
              controller: additionalPhoneNoController,
              hintText: 'Additional Mobile Number',
              obscureText: false,
              paddingHeight: 10,
              paddingWidth: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                // when user taps add new address
                if (index == null) {
                  Provider.of<Model>(context, listen: false).addNewAddress({
                    'firstName': firstNameController.text.trim(),
                    'lastName': lastNameController.text.trim(),
                    'deliveryAddress': deliveryAddressController.text.trim(),
                    'additionalInfo': additionalInfoController.text.trim(),
                    'region': regionController.text.trim(),
                    'city': cityController.text.trim(),
                    'mobilePhoneNo': mobilePhoneNoController.text.trim(),
                    'additionalPhoneNo':
                        additionalPhoneNoController.text.trim(),
                    'addressSelected':false,
                  });
                  return2PrevPage(context);
                }
                // when user taps edit
                else {
                  Provider.of<Model>(context, listen: false)
                      .updateAddress(index!, {
                    'firstName': firstNameController.text.trim(),
                    'lastName': lastNameController.text.trim(),
                    'deliveryAddress': deliveryAddressController.text.trim(),
                    'additionalInfo': additionalInfoController.text.trim(),
                    'region': regionController.text.trim(),
                    'city': cityController.text.trim(),
                    'mobilePhoneNo': mobilePhoneNoController.text.trim(),
                    'additionalPhoneNo':
                        additionalPhoneNoController.text.trim(),
                    'addressSelected': false,
                  });
                  return2PrevPage(context);
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.deepPurple[600],
                  ),
                  child: Text(
                    'SAVE & CONTINUE',
                    style: TextStyle(color: Colors.grey[100]),
                  )),
            )),
      ),
    );
  }
}
