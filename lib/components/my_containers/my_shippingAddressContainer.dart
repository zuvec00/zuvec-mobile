import 'package:firebase_practice/provider/model.dart';
import 'package:firebase_practice/routes/shippingAddress/addNewAddress_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MyShippingAddressContainer extends StatefulWidget {
  final int index;
  final String firstName;
  final String lastName;
  final String deliveryAddress;
  final String additionalInfo;
  final String region;
  final String city;
  final String mobilePhoneNo;
  final String additionalPhoneNo;
  final bool selected;

  MyShippingAddressContainer({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.deliveryAddress,
    required this.additionalInfo,
    required this.region,
    required this.city,
    required this.index,
    required this.mobilePhoneNo,
    required this.additionalPhoneNo,
    required this.selected,
  });

  @override
  State<MyShippingAddressContainer> createState() =>
      _MyShippingAddressContainerState();
}

class _MyShippingAddressContainerState
    extends State<MyShippingAddressContainer> {
  @override
  Widget build(BuildContext context) {
    bool addressSelected = widget.selected;
    final size = MediaQuery.of(context).size;
    return Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              Provider.of<Model>(context, listen: false)
                  .removeAddress(widget.index);
            },
            icon: Icons.delete_rounded,
            backgroundColor: Colors.deepPurple.shade600,
            borderRadius: BorderRadius.circular(15),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    size: 26, color: Colors.grey[600]),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200, //make this responsive
                      child: Text(
                        widget.deliveryAddress,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(widget.region,
                            style: TextStyle(color: Colors.grey[600])),
                        Text(', ', style: TextStyle(color: Colors.grey[600])),
                        Text(widget.city,
                            style: TextStyle(color: Colors.grey[600]))
                      ],
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AddNewAddressPage(
                              index: widget.index,
                            ))));
              },
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          addressSelected = !addressSelected;
                        });

                        // calling function to toggle if the address selected or not
                        Provider.of<Model>(context, listen: false)
                            .toggleSelectedAddress(widget.index, {
                          'firstName': widget.firstName,
                          'lastName': widget.lastName,
                          'deliveryAddress': widget.deliveryAddress,
                          'additionalInfo': widget.additionalInfo,
                          'region': widget.region,
                          'city': widget.city,
                          'mobilePhoneNo': widget.mobilePhoneNo,
                          'additionalPhoneNo': widget.additionalPhoneNo,
                          'addressSelected': addressSelected,
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: widget.selected
                                ? Colors.deepPurple[600]
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: widget.selected ? 0.0 : 1.5,
                                color: widget.selected
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
                      )),
                  const SizedBox(height: 10),
                  Text('Edit',
                      style: TextStyle(
                          color: Colors.deepPurple[600],
                          decoration: TextDecoration.underline)),
                ],
              ),
            ),
          ]),
        ));
  }
}
