// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ewsrtes/core/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'user_data_state.dart';

// class UserDataCubit extends Cubit<UserDataState> {
//   UserDataCubit() : super(UserDataInitialState());
//   var users = FirebaseFirestore.instance.collection('users');
//   Future<void> sendUserData({
//     required String userId,
//     required String userImage,
//     required String userName,
//     required String userEmail,
//     required Timestamp createdAt,
//     required List<dynamic> userCart,
//     required List<dynamic> userWish,
//   }) async {
//     await users.doc(FirebaseAuth.instance.currentUser!.uid).set({
//       'userId': userId,
//       'userImage': userImage,
//       'userName': userName,
//       'userEmail': userEmail,
//       'createdAt': createdAt,
//       'userCart': userCart,
//       'userWish': userWish,
//     });
//     emit(SendUserDataState());
//   }

//   Future<UserModel> fetchUserData({required String id}) async {
//     var userdoc = await users.doc(id).get();
//     UserModel userData = UserModel.fromJson(userdoc);
//     emit(FetchUserDataState());
//     return userData;
//   }
// }
