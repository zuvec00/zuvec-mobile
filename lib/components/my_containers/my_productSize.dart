import 'package:flutter/material.dart';

class MyProductSizeCont extends StatelessWidget {
  final String size;
  final bool isSelected;
  final VoidCallback onSelected;
  const MyProductSizeCont(
      {super.key,
      required this.size,
      required this.isSelected,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal:7,vertical:3.5),
          
          decoration: BoxDecoration(
            color: isSelected ? Colors.deepPurple[600] : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: isSelected ? Colors.grey[100]! : Colors.grey[600]!,
                width: isSelected ? 0 : 1.5),
            
          ),
          child: Center(
              child: Text(size,
                  style: TextStyle(
                      color: isSelected ? Colors.grey[100] : Colors.grey[900],
                      fontSize: 13)))),
    );
  }
}
