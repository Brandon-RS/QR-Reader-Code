import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class AllScansPage extends StatelessWidget {
  const AllScansPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    scanListProvider.loadScans();

    final scans = scanListProvider.scans;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        title: Text(
          'All Scans',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
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
        ],
      ),
      body: scans.isEmpty
          ? const Center(
              child: Text('Nothing to see!'),
            )
          : ListView.builder(
              itemCount: scans.length,
              itemBuilder: (_, int i) => ListTile(
                leading:
                    Icon(Icons.category, color: Theme.of(context).primaryColor),
                title: Text(
                  scans[i].value,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing:
                    const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              ),
            ),
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
              scanListProvider.deleteAll();
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
