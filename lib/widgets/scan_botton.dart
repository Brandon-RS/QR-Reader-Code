import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/webview_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanBotton extends StatelessWidget {
  const ScanBotton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#fd5720',
          'Cancelar',
          false,
          ScanMode.QR,
        );
        // String barcodeScanRes = 'https://pub.dev';
        // String barcodeScanRes = 'geo:40.745898,-73.990478';

        if (barcodeScanRes == '-1') {
          return;
        }

        final scanListProvider = Provider.of<ScanListProvider>(
          context,
          listen: false,
        );
        final newScan = await scanListProvider.newScan(barcodeScanRes);
        // scanListProvider.newScan('geo:15.33,15.66');

        newScan.type == 'geo'
            ? launchURL(context, newScan)
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      WebViewPage(url: barcodeScanRes),
                ),
              );
      },
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
