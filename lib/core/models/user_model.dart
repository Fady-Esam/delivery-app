// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   final String userId, userImage, userName, userEmail;
//   final List<dynamic> userCart;
//   final List<dynamic> userWish;

//   UserModel({
//     required this.userId,
//     required this.userImage,
//     required this.userName,
//     required this.userEmail,
//     required this.userCart,
//     required this.userWish,
//   });


//   factory UserModel.fromJson(DocumentSnapshot documentSnapshot) {
//     Map<String, dynamic> json = documentSnapshot.data() as Map<String,dynamic>;
//     return UserModel(
//       userId: json['userId'], 
//       userImage: json['userImage'], 
//       userName: json['userName'], 
//       userEmail: json['userEmail'], 
//       userCart: json['userCart'], 
//       userWish: json['userWish'],
//     );
//   }
// }
