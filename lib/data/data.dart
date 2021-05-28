import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patient_app/models/user_model.dart';

final users = [
  User(profileImageUrl: 'assets/user0.jpg'),
  User(profileImageUrl: 'assets/user1.jpg'),
  User(profileImageUrl: 'assets/user2.jpg'),
];
// Current User
final User currentUser = User(
  profileImageUrl: 'assets/user0.jpg',
  backgroundImageUrl: 'assets/user_background.jpg',
  name: 'Taha',
);

class Data {
  String imgUrl, firstName, lastName, speciality, hospital, shortDesc, longDesc;
  Timestamp availableTime;
  Data(this.imgUrl, this.firstName, this.lastName, this.speciality,
      this.hospital, this.shortDesc, this.longDesc, this.availableTime);
}
