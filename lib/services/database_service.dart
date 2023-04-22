import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uID;
  DatabaseService({required this.uID});

  final CollectionReference zuvecAppUsers =
      FirebaseFirestore.instance.collection('zuvecAppUsers');
  final CollectionReference emailSubscribers =
      FirebaseFirestore.instance.collection('emailSubscribers');
  final CollectionReference appRating =
      FirebaseFirestore.instance.collection('appRating');

  Future updateUserData( String tokenID,
      String firstName, String lastName, String phoneNo, String emailID) async {
    return await zuvecAppUsers.doc(uID).set({
      'Device TokenID': tokenID,
      'First Name': firstName,
      'Last Name': lastName,
      'Phone Number': phoneNo,
      'Email ID': emailID,
    });
  }

  Future updateUserEmailPreference(String emailID, bool isSubscribed) async {
    return await emailSubscribers
        .doc(uID)
        .set({'Email ID': emailID, 'User subscribed': isSubscribed});
  }

  Future updateRating(String feedback,double rating) async {
    return await appRating.doc(uID).set({
      'User feedback': feedback,
      'Rating value': rating,
    });
  }
}
