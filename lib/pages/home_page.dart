import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/addresses_page.dart';
import 'package:qr_reader/pages/maps_hitory.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_botton.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(
      context,
      // listen: false,
    );
    final uiProvider = Provider.of<UiProvider>(context);
    final String type =
        scanListProvider.typeSelected == 'geo' ? 'Geolocation' : 'Websites';
    String a = uiProvider.selectedMenuOpt == 1 ? 'http' : 'geo';
    scanListProvider.loadScansByType(a);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 50),
            Text(
              '$type History',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              int cant = scanListProvider.scans.length;

              cant > 0
                  ? alertDialogWidget(context, scanListProvider)
                  : snackBarWidget(context);
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/all_scans_page'),
            icon: Icon(
              Icons.subject,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigatonBar(),
      floatingActionButton: const ScanBotton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void snackBarWidget(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: const [
          Text('Nothing to delete!', style: TextStyle(fontSize: 16)),
          Expanded(child: SizedBox()),
          Icon(Icons.info_rounded, color: Colors.white),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 13),
      backgroundColor: Theme.of(context).primaryColor,
      behavior: SnackBarBehavior.floating,
      shape: const StadiumBorder(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<dynamic> alertDialogWidget(
      BuildContext context, ScanListProvider scanListProvider) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Are you sure to delete all Scans?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final String type = scanListProvider.typeSelected;
              scanListProvider.deleteScansByType(type);
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtain the selected menu opt.
    final uiProvider = Provider.of<UiProvider>(context);

    // final currentIndex = uiProvider.selectedMenuOpt;
    // switch (currentIndex) {

    // final tempScan = ScanModel(value: 'https://google.com');

    // DBProvider.db.newScan(tempScan);
    // DBProvider.db.deleteALlScans().then(print);
    // DBProvider.db.getScanById(4).then((value) => print(value!.value));

    // Use the ScansListPrivider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (uiProvider.selectedMenuOpt) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return const MapsHistory();
      case 1:
        scanListProvider.loadScansByType('http');
        return const AddressesPage();
      default:
        return const MapsHistory();
    }
  }
}
