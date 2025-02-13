
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import 'show_snack_bar_fun.dart';

// class ForgotPasswordView extends StatefulWidget {
//   const ForgotPasswordView({super.key});

//   @override
//   State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
// }

// class _ForgotPasswordViewState extends State<ForgotPasswordView> {
//   GlobalKey<FormState> formkey = GlobalKey();
//   AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

//   late TextEditingController emailController;
//   @override
//   void initState() {
//     super.initState();
//     emailController = TextEditingController();
//   }

//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: isLoading,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text(
//             'Reset Your Password',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: Form(
//             key: formkey,
//             autovalidateMode: autovalidateMode,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 24),
//                   Image.asset(
//                     'users_assets/assets/images/forgot_password.jpg',
//                     height: MediaQuery.sizeOf(context).height * 0.3,
//                   ),
//                   const SizedBox(height: 12),
//                   const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Forgot Password',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'please enter your email you like to update password and send to',
//                     style: TextStyle(
//                       fontSize: 19,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   const SizedBox(height: 22),
//                   TextFormField(
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Please enter your email first';
//                       } else if (!RegExp(
//                               r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//                           .hasMatch(value)) {
//                         return 'Invalid Email, It must be a valid email address';
//                       }
//                       return null;
//                     },
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.email),
//                       hintText: 'Email',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(
//                           color: Colors.blue,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(
//                           color: Colors.blue,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(
//                           color: Colors.blue,
//                         ),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 22),
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.sizeOf(context).width * 0.22,
//                         vertical: 12,
//                       ),
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () async {
//                       if (formkey.currentState!.validate()) {
//                         isLoading = true;
//                         setState(() {});
//                         try {
//                           // await FirebaseAuth.instance.sendPasswordResetEmail(
//                           //     email: emailController.text);
//                           isLoading = false;
//                           setState(() {});
//                           await showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                               content: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Image.asset(
//                                     'admin_assets/assets/images/warning.png',
//                                     height: 120,
//                                   ),
//                                   const SizedBox(height: 14),
//                                   const Text(
//                                     'We Sent a Reset Password Link to Your Email, You can check it now and Reset your password',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 14),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.pushAndRemoveUntil(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const SignInView()),
//                                           (route) => false);
//                                     },
//                                     child: const Text(
//                                       'Ok',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         } on Exception {
//                           isLoading = false;
//                           setState(() {});
//                           showSnackBarFun(
//                             context: context,
//                             text: 'Something went wrong, Please try again',
//                           );
//                         }
//                       } else {
//                         autovalidateMode = AutovalidateMode.always;
//                         setState(() {});
//                       }
//                     },
//                     icon: Transform.rotate(
//                       angle: -13.8 / 2,
//                       child: const Icon(
//                         Icons.send,
//                         color: Colors.white,
//                         size: 34,
//                       ),
//                     ),
//                     label: const Text(
//                       'Request Link',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w900,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 22),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
