import 'dart:io';

import 'package:flutter/material.dart';

Future showImageWarningDialog({required BuildContext context, required File? pcikedImage}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose Option',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop('Camera');
              },
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop('Gallery');
              },
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
            ),
            if(pcikedImage !=null)
            ListTile(
              onTap: () {
                Navigator.of(context).pop('Remove');
              },
              leading: const Icon(Icons.remove),
              title: const Text('Remove'),
            ),
          ],
        ),
      );
    },
  );
}
