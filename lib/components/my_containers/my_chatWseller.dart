import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyChatWithSellerButton extends StatelessWidget {
  const MyChatWithSellerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse('whatsapp://send?phone=+2348160287793&text=Hi, I would like to purchase '));
      },
      radius: 25,
      splashColor: Colors.grey,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.deepPurple, width: 1.5),
          ),
          child: Row(
            children: const [
              Icon(
                Icons.chat_rounded,
                size: 18,
              ),
              SizedBox(
                width: 8,
              ),
              Text('Chat with seller',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          )),
    );
  }
}
