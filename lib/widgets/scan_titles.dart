import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/webview_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTitles extends StatelessWidget {
  const ScanTitles({Key? key, required this.icon}) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    final scans = scanListProvider.scans;

    if (scans.isEmpty) {
      return const Center(
        child: Text('Nothing to see!'),
      );
    }

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, int i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
        onDismissed: (DismissDirection direction) {
          scanListProvider.deleteScanById(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).primaryColor),
          title: Text(
            scans[i].value,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          // subtitle: Text(scans[i].id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () {
            scans[i].type == 'geo'
                ? launchURL(context, scans[i])
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          WebViewPage(url: scans[i].value),
                    ),
                  );
          },
          // onTap: () => launchURL(context, scans[i]),
        ),
      ),
    );
  }
}
