import 'package:flutter/material.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/widgets/profile_photo_screen.dart';


class AddImageView extends StatelessWidget {
  const AddImageView({super.key});
  static const routeName = 'addImage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilePhotoScreen(),
    );
  }
}
