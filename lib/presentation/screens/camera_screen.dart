import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constants.dart';

class CameraScreen extends StatefulWidget {
  static const routeName = '/scan-qr-code';
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  var qrstr = "Press to Scan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: myDarkGreen,
          title: const Text('Scanning QR code'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                qrstr,
                style: TextStyle(color: myDarkGreen, fontSize: 30),
              ),
              ElevatedButton(
                onPressed: scanQr,
                style: ElevatedButton.styleFrom(
                    backgroundColor: myDarkGreen,
                    fixedSize: Size(getWidth(context) * 0.6, 60)),
                child: const Text(
                  ('Scanner'),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
          .then((qrValue) async {
        if (qrValue != '-1') {
          showSuccessBottomSheet(context, qrValue);
        } else {
          setState(() {
            qrstr = 'unable to read this';
          });
          showFailureBottomSheet(context);
        }
      });
    } catch (e) {
      setState(() {
        qrstr = 'unable to read this';
      });
      showFailureBottomSheet(context);
    }
  }

  Future<void> showSuccessBottomSheet(
    context,
    String val,
  ) async {
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      useRootNavigator: true,
      builder: (context) => Material(
        color: Colors.white,
        child: StatefulBuilder(
          builder: (ctx, setState) => Container(
            height: getHeight(ctx) / 2.3,
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Lottie.asset('assets/images/green check-mark.json',
                      width: 140, height: 140),
                  Text(
                    'Your Serial number is: $val',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff171d22),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                          MediaQuery.of(context).size.height * 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: val)).then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: myDarkGreen,
                              content: const Text(
                                'Copied Successfully',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ).whenComplete(
                        () => Navigator.of(ctx, rootNavigator: true).pop(),
                      );
                    },
                    // Navigator.of(ctx, rootNavigator: true).pop(),
                    child: const Text(
                      "Copy",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> showFailureBottomSheet(
    context,
  ) async {
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      useRootNavigator: true,
      builder: (context) => Material(
        color: Colors.white,
        child: StatefulBuilder(
          builder: (ctx, setState) => Container(
            height: getHeight(ctx) / 2.3,
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.close_outlined,
                    size: 70,
                    color: Colors.red,
                  ),
                  const Text(
                    'Something went wrong,please try again',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff171d22),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                          MediaQuery.of(context).size.height * 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.of(ctx, rootNavigator: true).pop(),
                    child: const Text(
                      "close",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
