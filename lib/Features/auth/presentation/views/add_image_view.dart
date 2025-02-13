import 'package:flutter/material.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/profile_photo_screen.dart';

import 'widgets/add_image_body.dart';

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
