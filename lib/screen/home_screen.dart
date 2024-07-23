import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrData = 'https://play.google.com/store/apps/details?id=com.seniorworld.silverwings';
  String qrData1 = 'https://apps.apple.com/in/app/silverwings/id6477858123';
  bool isDeviceType = false;

  // This should be your app's package name or ID


  MobileScannerController mobileController = MobileScannerController();




  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      isDeviceType = true;
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      isDeviceType = false;
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        crossAxisAlignment:CrossAxisAlignment.center,
        children: <Widget>[
         //  Expanded(
         //    flex: 1,
         // child: QRScannerScreen()
         //  ),
          Expanded(
            flex: 1,
        child: MobileScanner(
            allowDuplicates: false,
            controller: MobileScannerController(),
            onDetect: (barcode, args) {
              String? code = barcode.rawValue;
              // qrRead.call(code ?? 'Empty');
            }),
      ),
          Expanded(
            flex: 1,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: QrImageView(
                data:isDeviceType == true
                ? qrData : qrData1,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller.pauseCamera();
        _handleQRCode(scanData.code!);
      }
    });
  }

  void _handleQRCode(String code) {
    String url;
    if (Platform.isAndroid) {
      // URL for Google Play Store
      url = 'https://play.google.com/store/apps/details?id=$code';
    } else if (Platform.isIOS) {
      // URL for Apple App Store
      url = 'https://apps.apple.com/app/id$code';
    } else {
      // Fallback URL
      url = 'https://www.example.com';
    }

    _launchURL(url);
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}



// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (controller != null) {
//       controller!.pauseCamera();
//       controller!.resumeCamera();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 4,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) async {
//       if (scanData.code != null) {
//         await _handleQRCode(scanData.code!);
//       }
//     });
//   }
//
//   Future<void> _handleQRCode(String code) async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     bool isAndroid = false;
//     bool isIOS = false;
//
//     if (await deviceInfo.androidInfo != null) {
//       isAndroid = true;
//     } else if (await deviceInfo.iosInfo != null) {
//       isIOS = true;
//     }
//
//     if (isAndroid) {
//       _launchURL("https://play.google.com/store/apps/details?id=com.senior.silverwings");
//     } else if (isIOS) {
//       _launchURL("https://apps.apple.com/app/idcom.senior.silverwings");
//     } else {
//       print("Unsupported device");
//     }
//   }
//
//   Future<void> _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

