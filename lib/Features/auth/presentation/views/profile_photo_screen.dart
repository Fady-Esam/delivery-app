import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePhotoScreen extends StatefulWidget {
  const ProfilePhotoScreen({super.key});

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
          _showSnackBar('No valid face detected. Please try another image.');
        }
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      _showSnackBar('Failed to pick image: $e');
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
      _showSnackBar('Face detection failed: $e');
      return false;
    } finally {
      await faceDetector.close(); // Always close the detector to release resources
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  _buildTitleAndDescription(),
                  const SizedBox(height: 24),
                  _buildProfilePhotoPlaceholder(),
                  const SizedBox(height: 24),
                  _buildPhotoOptionsCard(),
                  const SizedBox(height: 24),
                  _buildContinueButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.all(12),
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle skip action
            print('Skip button pressed');
          },
          child: Text(
            'Skip',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a Profile Photo',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Choose a profile picture to personalize your account',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePhotoPlaceholder() {
    return GestureDetector(
      onTap: () async {
        await _pickImage(ImageSource.gallery);
      },
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(_selectedImage!.path),
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).colorScheme.primary,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tap to add a photo',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildPhotoOptionsCard() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              'Choose Photo From',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOptionButton(
                  context,
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  onTap: () async {
                    await _pickImage(ImageSource.gallery);
                  },
                ),
                _buildOptionButton(
                  context,
                  icon: Icons.photo_camera,
                  label: 'Camera',
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  onTap: () async {
                    await _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _selectedImage != null
            ? () {
                // Handle continue action
                print('Continue button pressed');
              }
            : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
