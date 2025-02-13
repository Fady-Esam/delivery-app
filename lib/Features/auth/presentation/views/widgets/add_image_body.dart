// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_picker/image_picker.dart';

// class AddImageBody extends StatefulWidget {
//   const AddImageBody({super.key});

//   @override
//   State<AddImageBody> createState() => _AddImageBodyState();
// }

// class _AddImageBodyState extends State<AddImageBody> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   XFile? _selectedImage;
//   bool _isProcessing = false;

//   Future<void> _pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     try {
//       final pickedFile = await picker.pickImage(source: source);
//       if (pickedFile != null) {
//         setState(() {
//           _isProcessing = true;
//         });

//         bool isFaceValid = await _detectFace(File(pickedFile.path));
//         setState(() {
//           _isProcessing = false;
//         });

//         if (isFaceValid) {
//           setState(() {
//             _selectedImage = pickedFile;
//           });
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//                 content:
//                     Text('No valid face detected. Please try another image.')),
//           );
//         }
//       }
//     } catch (e) {
//       setState(() {
//         _isProcessing = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to pick image: $e')),
//       );
//     }
//   }

//   Future<bool> _detectFace(File imageFile) async {
//     final inputImage = InputImage.fromFile(imageFile);
//     final faceDetector = FaceDetector(
//         options: FaceDetectorOptions(
//       enableContours: true,
//       enableClassification: true,
//     ));

//     try {
//       final List<Face> faces = await faceDetector.processImage(inputImage);
//       await faceDetector.close();

//       // If at least one face is detected, return true
//       return faces.isNotEmpty;
//     } catch (e) {
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'تخطي',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 24),
//           Text(
//             'اضافة صورة',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'اختر صورة شخصية لحسابك',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//           SizedBox(height: 24),
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   shape: RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(16)),
//                   ),
//                   builder: (context) {
//                     return Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           ListTile(
//                             leading: Icon(Icons.photo_library),
//                             title: Text('Gallery'),
//                             onTap: () {
//                               Navigator.pop(context);
//                               _pickImage(ImageSource.gallery);
//                             },
//                           ),
//                           ListTile(
//                             leading: Icon(Icons.photo_camera),
//                             title: Text('Camera'),
//                             onTap: () {
//                               Navigator.pop(context);
//                               _pickImage(ImageSource.camera);
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 120,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(60),
//                     ),
//                     child: _selectedImage == null
//                         ? Icon(Icons.person_outline,
//                             size: 60, color: Colors.grey)
//                         : ClipRRect(
//                             borderRadius: BorderRadius.circular(60),
//                             child: Image.file(
//                               File(_selectedImage!.path),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                   ),
//                   if (_isProcessing)
//                     CircularProgressIndicator(
//                       color: Colors.blue,
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           Spacer(),
//           ElevatedButton(
//             onPressed: () {
//               if (_selectedImage != null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                       content: Text('Profile photo updated successfully!')),
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Please select a profile photo.')),
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               minimumSize: Size(double.infinity, 56),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(28),
//               ),
//             ),
//             child: Text(
//               'Continue',
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
