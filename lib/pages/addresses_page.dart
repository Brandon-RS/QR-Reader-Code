import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_titles.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const  ScanTitles(
      icon: Icons.map_outlined,
    );
  }
}
