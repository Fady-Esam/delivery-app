import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1592337713540-23df6db7db20?w=800&h=800',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Warning!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Are you sure you want to proceed?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Cancel button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.white,
                    // onPrimary: Colors.black,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    //print('OK button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.red,
                    // onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
