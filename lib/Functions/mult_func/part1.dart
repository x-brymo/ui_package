import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:http/http.dart' as http;
class MultipleFunc {

Future<void> backupData(Map<String, dynamic> data, String fileName) async {
  final file = await _getLocalFile(fileName);
  await file.writeAsString(jsonEncode(data));
}

Future<Map<String, dynamic>> restoreData(String fileName) async {
  try {
    final file = await _getLocalFile(fileName);
    final contents = await file.readAsString();
    return jsonDecode(contents);
  } catch (e) {
    return {};
  }
}

Future<File> _getLocalFile(String fileName) async {
  final path = await getTemporaryDirectory();
  return File('$path/$fileName');
}
// TODO   < >
final ColorScheme _lightScheme = const ColorScheme.light();
final ColorScheme _darkScheme = const ColorScheme.dark();

ColorScheme getColorScheme(bool isDarkMode) {
  return isDarkMode ? _darkScheme : _lightScheme;
}
// TODO   < >
int _appLaunchCount = 0;
final int _promptThreshold = 10;

void checkAndPromptForRating(BuildContext context) {
  _appLaunchCount++;
  if (_appLaunchCount >= _promptThreshold) {
    _showRatingPrompt(context);
  }
}

void _showRatingPrompt(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Rate Us'),
        content: const Text('Would you like to rate our app?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Link to app store for rating
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}

// TODO   < [analyzeUserInteractions] >
Map<String, int> analyzeUserInteractions(List<String> actions) {
  Map<String, int> interactionCounts = {};

  for (var action in actions) {
    interactionCounts[action] = (interactionCounts[action] ?? 0) + 1;
  }

  return interactionCounts;
}

void showWalkthroughGuide(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('App Walkthrough'),
        content: const Text('This is your first step. Tap next to continue.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Proceed to the next step in the walkthrough
            },
            child: const Text('Next'),
          ),
        ],
      );
    },
  );
}
Orientation getDeviceOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation;
}

void adjustUIForOrientation(BuildContext context) {
  if (getDeviceOrientation(context) == Orientation.landscape) {
    // Adjust for landscape mode

  } else {
    // Adjust for portrait mode
      // write code 

  }
}


// Future<File?> compressImage(File file, String targetPath) async {
//   return await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path,
//     targetPath,
//     quality: 80, // Compression quality (lower = more compressed)
//   );
// }



Future<void> downloadImage(String url, String fileName) async {
  final response = await http.get(Uri.parse(url));
  final bytes = response.bodyBytes;

  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$fileName');
  await file.writeAsBytes(bytes);
}
bool isSystemDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

ThemeData getAppropriateTheme(BuildContext context) {
  return isSystemDarkMode(context) ? ThemeData.dark() : ThemeData.light();
}

Future<CroppedFile?> cropImage(File imageFile) async {
  return await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
     
    uiSettings: [

    ]
  );
}


void scanQRCode(Function(String) onCodeScanned) {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;

  qrController?.scannedDataStream.listen((scanData) {
    onCodeScanned(scanData.code);
  });

  // Call `dispose` when the scanner is no longer in use
  qrController?.dispose();
}


void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
}

Future<String?> pasteFromClipboard() async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  return data?.text;
}


}