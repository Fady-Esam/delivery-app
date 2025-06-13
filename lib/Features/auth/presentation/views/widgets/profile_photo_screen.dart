import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saree3_mobile/core/widgets/custom_button.dart';
import 'dart:io';

import '../../../../../core/funcs/get_responsive_text.dart';
import '../../../../../core/helpers/show_snack_bar_fun.dart';
import '../../../../../core/utils/app_text_styles.dart';

class ProfilePhotoScreen extends StatefulWidget {
  const ProfilePhotoScreen({super.key});

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  XFile? _selectedImage;
  bool _isProcessing = false; // use it circular progress indicator

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _isProcessing = true;
        });
        bool isFaceValid = await _detectFace(File(pickedFile.path));
        setState(() {
          _isProcessing = false;
        });

        if (isFaceValid) {
          setState(() {
            _selectedImage = pickedFile;
          });
        } else {
          showSnackBarFun(
              context: context,
              text: 'لم يتم الكشف عن وجه صالح. يرجى تجربة صورة أخرى.');
        }
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      showSnackBarFun(context: context, text: 'فشل في اختيار الصورة: $e');
    }
  }

  Future<bool> _detectFace(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableClassification: true,
      ),
    );

    try {
      final List<Face> faces = await faceDetector.processImage(inputImage);
      return faces.isNotEmpty;
    } catch (e) {
      showSnackBarFun(context: context, text: 'فشل الكشف عن الوجه : $e');
      return false;
    } finally {
      await faceDetector
          .close(); // Always close the detector to release resources
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إضافة صورة الملف الشخصي',
          style: TextStyles.semiBold16.copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 22),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              //width: isTablet ? MediaQuery.sizeOf(context).width * 0.8 : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //const TitleAndDescriptionWidget(),
                  SizedBox(height: 12),
                  ProfilePhotoPlaceholderWidget(
                    selectedImage: _selectedImage,
                    pickImage: () => _pickImage(ImageSource.gallery),
                    onDeleteImage: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                  ),
                  SizedBox(height: 36.h),
                  PhotoOptionsCardWidget(pickImage: _pickImage),
                  SizedBox(height: 36.h),
                  //if (_selectedImage != null)
                  Center(
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        child: CustomButton(onPressed: () {}, text: "استمرار")),
                  )
                  //ContinueButtonWidget(selectedImage: _selectedImage),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePhotoPlaceholderWidget extends StatefulWidget {
  const ProfilePhotoPlaceholderWidget({
    super.key,
    required this.selectedImage,
    required this.pickImage,
    required this.onDeleteImage,
  });
  final XFile? selectedImage;
  final VoidCallback pickImage;
  final VoidCallback onDeleteImage;

  @override
  State<ProfilePhotoPlaceholderWidget> createState() =>
      _ProfilePhotoPlaceholderWidgetState();
}

class _ProfilePhotoPlaceholderWidgetState
    extends State<ProfilePhotoPlaceholderWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250.w,
        height: 250,
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            // color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        child: widget.selectedImage != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.file(
                      File(
                        widget.selectedImage!.path,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8, // Adjust as needed
                    right: 8, // Adjust as needed
                    child: GestureDetector(
                      onTap: widget.onDeleteImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 183, 179, 179),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          color: const Color.fromARGB(255, 17, 14, 14),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Container(
                  width: 120.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(60.r),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    // color: Theme.of(context).colorScheme.primary,
                    size: 60,
                  ),
                ),
              ),
      ),
    );
  }
}

class PhotoOptionsCardWidget extends StatelessWidget {
  final Function(ImageSource source) pickImage;

  const PhotoOptionsCardWidget({super.key, required this.pickImage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Text(
                  'اختر صورة من',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, fontSize: 20),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OptionButtonWidget(
                      icon: Icons.photo_library,
                      label: 'المعرض',
                      onTap: () => pickImage(ImageSource.gallery),
                    ),
                    OptionButtonWidget(
                      icon: Icons.photo_camera,
                      label: 'الكاميرا',
                      onTap: () => pickImage(ImageSource.camera),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionButtonWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const OptionButtonWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              // color: color,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Icon(
              icon,
              // color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: TextStyle(
              // color: Theme.of(context).colorScheme.onSurface,
              fontSize: getResponsiveFontSize(context, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
